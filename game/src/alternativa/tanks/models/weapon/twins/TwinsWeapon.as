package alternativa.tanks.models.weapon.twins {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class TwinsWeapon extends BattleRunnerProvider implements Weapon, LogicUnit {
    private static var shotId:int;

    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const shotDirection:Vector3 = new Vector3();
    private static const rayHit:RayHit = new RayHit();

    private var nextTime:EncryptedInt = new EncryptedIntImpl();
    private var recoilForce:Number;
    private var controller:SimpleWeaponController;
    private var weaponPlatform:WeaponPlatform;
    private var enabled:Boolean;
    private var targetingSystem:TargetingSystem;
    private var currentBarrel:int;
    private var callback:TwinsWeaponCallback;
    private var ammunition:TwinsAmmunition;
    private var effects:TwinsEffects;
    private var weakening:DistanceWeakening;
    private var weaponObject:WeaponObject;
    private var stunEnergy:Number;
    private var stunned:Boolean;

    public function TwinsWeapon(param1:IGameObject, param2:IGameObject, param3:TwinsCC) {
      super();
      this.weaponObject = new WeaponObject(param2);
      var local4:DistanceWeakening = this.weaponObject.distanceWeakening();
      var local5:WeaponCommonData = this.weaponObject.commonData();
      var local6:TwinsWeaponCallback = TwinsWeaponCallback(param2.adapt(TwinsWeaponCallback));
      var local7:ITwinsSFXModel = ITwinsSFXModel(param2.adapt(ITwinsSFXModel));
      var local8:TwinsAmmunition = new TwinsAmmunition(this.weaponObject,param3,local7.getSFXData(),local6);
      var local9:TargetingSystem = new CommonTargetingSystem(param1,this.weaponObject,local4.getDistance());
      local9.getProcessor().setShotFromMuzzle();
      var local10:SimpleWeaponController = new SimpleWeaponController();
      this.recoilForce = local5.getRecoilForce();
      this.controller = local10;
      this.targetingSystem = local9;
      this.callback = local6;
      this.ammunition = local8;
      this.effects = local7.getPlasmaWeaponEffects();
      this.weakening = local4;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.controller.init();
    }

    public function destroy() : void {
      this.targetingSystem = null;
      this.effects = null;
      this.controller.destroy();
      this.controller = null;
    }

    public function activate() : void {
      getBattleRunner().addLogicUnit(this);
    }

    public function deactivate() : void {
      getBattleRunner().removeLogicUnit(this);
    }

    public function enable() : void {
      if(!this.enabled) {
        this.enabled = true;
        this.controller.discardStoredAction();
      }
    }

    public function disable(param1:Boolean) : void {
      this.enabled = false;
    }

    public function reset() : void {
      this.controller.discardStoredAction();
      this.nextTime.setInt(0);
      this.currentBarrel = 0;
    }

    public function getStatus() : Number {
      if(this.stunned) {
        return this.stunEnergy;
      }
      var local1:Number = 1 - (this.nextTime.getInt() - getTimer()) / this.weaponObject.getReloadTimeMS();
      return local1 > 1 ? 1 : local1;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.enabled) {
        if(this.controller.wasActive() && param1 >= this.nextTime.getInt()) {
          this.shoot(param1);
        }
      }
      this.controller.discardStoredAction();
    }

    private function shoot(param1:int) : void {
      this.nextTime.setInt(param1 + this.weaponObject.getReloadTimeMS());
      this.weaponPlatform.getAllGunParams(allGunParams,this.currentBarrel);
      this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.recoilForce);
      this.weaponPlatform.addDust(1);
      this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(this.currentBarrel));
      if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),allGunParams)) {
        this.doRealShot(param1,allGunParams);
      } else {
        this.doDummyShot(param1);
      }
      this.currentBarrel = (this.currentBarrel + 1) % this.weaponPlatform.getNumberOfBarrels();
    }

    private function doRealShot(param1:int, param2:AllGlobalGunParams) : void {
      var local4:TargetingResult = null;
      if(this.barrelCollidesWithStatic(param2.barrelOrigin,param2.direction,this.weaponPlatform.getBarrelLength(this.currentBarrel))) {
        shotDirection.copy(param2.direction);
      } else {
        local4 = this.targetingSystem.target(param2);
        shotDirection.copy(local4.getDirection());
      }
      var local3:TwinsShot = this.ammunition.getShot();
      local3.addToGame(param2,shotDirection,this.weaponPlatform.getBody(),false,++shotId);
      this.callback.onShot(param1,local3.getShotId(),this.currentBarrel,shotDirection);
    }

    private function barrelCollidesWithStatic(param1:Vector3, param2:Vector3, param3:Number) : Boolean {
      return getBattleRunner().getCollisionDetector().raycastStatic(param1,param2,CollisionGroup.STATIC,param3,null,rayHit);
    }

    private function doDummyShot(param1:int) : void {
      this.callback.onDummyShot(param1,this.currentBarrel);
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.TWINS_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
    }

    public function fullyRecharge() : void {
      this.nextTime.setInt(0);
      this.stunEnergy = 1;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      this.nextTime.setInt(this.nextTime.getInt() + param2 - param1);
    }

    public function stun() : void {
      this.stunEnergy = this.getStatus();
      this.stunned = true;
    }

    public function calm(param1:int) : void {
      this.nextTime.setInt(this.nextTime.getInt() + param1);
      this.stunned = false;
    }
  }
}
