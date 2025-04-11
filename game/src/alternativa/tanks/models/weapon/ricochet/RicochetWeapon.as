package alternativa.tanks.models.weapon.ricochet {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import alternativa.tanks.utils.MathUtils;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RicochetWeapon extends BattleRunnerProvider implements IRicochetWeapon, LogicUnit {
    [Inject]
    public static var battleService:BattleService;

    private static var shotId:int;

    private static const shotDirection:Vector3 = new Vector3();
    private static const rayHit:RayHit = new RayHit();
    private static const _gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var recoilForce:Number;
    private var energyRechargeRate:Number;
    private var nextShotTime:int;
    private var energyBaseTime:int;
    private var weaponPlatform:WeaponPlatform;
    private var controller:SimpleWeaponController = new SimpleWeaponController();
    private var targetingSystem:RicochetTargetingSystem;
    private var reloadingTime:int;
    private var effects:RicochetEffects;
    private var ammunition:RicochetAmmunition;
    private var callback:RicochetWeaponCallback;
    private var enabled:Boolean;
    private var ricochetInitParams:RicochetCC;
    private var lastEnergy:int;
    private var weaponObject:WeaponObject;
    private var stunEnergy:Number;
    private var stunned:Boolean;
    private var stunTime:int;

    public function RicochetWeapon(param1:IGameObject, param2:RicochetCC) {
      super();
      var local3:IRicochetSFXModel = IRicochetSFXModel(param1.adapt(IRicochetSFXModel));
      this.weaponObject = new WeaponObject(param1);
      var local4:RicochetWeaponCallback = RicochetWeaponCallback(param1.adapt(RicochetWeaponCallback));
      this.ricochetInitParams = param2;
      this.recoilForce = this.weaponObject.commonData().getRecoilForce();
      this.energyRechargeRate = param2.energyRechargeSpeed / 1000;
      this.targetingSystem = getTargetingSystem(this.weaponObject.verticalAutoAiming(),param2);
      this.reloadingTime = this.weaponObject.getReloadTimeMS();
      this.effects = local3.getRicochetEffects();
      this.ammunition = new RicochetAmmunition(this.weaponObject,param2,local3.getSfxData(),local4);
      this.callback = local4;
    }

    private static function getTargetingSystem(param1:VerticalAutoAiming, param2:RicochetCC) : RicochetTargetingSystem {
      var local3:Number = Number(param1.getElevationAngleUp());
      var local4:int = int(param1.getNumRaysUp());
      var local5:Number = Number(param1.getElevationAngleDown());
      var local6:int = int(param1.getNumRaysDown());
      var local7:Number = param2.shotDistance;
      var local8:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      return new RicochetTargetingSystem(local3,local4,local5,local6,local7,local8,battleService.getRicochetTargetEvaluator(),param2.maxRicochetCount);
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.controller.init();
    }

    public function destroy() : void {
      this.ricochetInitParams = null;
      this.effects = null;
      this.callback = null;
      this.targetingSystem = null;
      this.controller.destroy();
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
      this.energyBaseTime = 0;
      this.nextShotTime = 0;
      this.controller.discardStoredAction();
    }

    public function getStatus() : Number {
      if(this.stunned) {
        return this.stunEnergy;
      }
      return this.getEnergy(getTimer()) / this.ricochetInitParams.energyCapacity;
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:Number = NaN;
      if(this.enabled) {
        if(this.controller.wasActive() && param1 >= this.nextShotTime) {
          local3 = this.getEnergy(param1);
          if(local3 >= this.ricochetInitParams.energyPerShot && !this.stunned) {
            this.shoot(param1,local3);
          }
        }
      }
      this.controller.discardStoredAction();
    }

    private function shoot(param1:int, param2:Number) : void {
      this.lastEnergy = param2 - this.ricochetInitParams.energyPerShot;
      this.nextShotTime = param1 + this.reloadingTime;
      this.setEnergyBaseTime(param1,this.lastEnergy);
      this.weaponPlatform.getAllGunParams(_gunParams);
      this.weaponPlatform.addDust();
      this.applyRecoilForceToShooter(_gunParams.muzzlePosition,_gunParams.direction,-this.recoilForce);
      this.effects.createShotEffects(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition(),_gunParams.muzzlePosition);
      this.effects.createLightEffect(this.weaponPlatform.getTurret3D(),this.weaponPlatform.getLocalMuzzlePosition());
      if(BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),_gunParams)) {
        this.doRealShot(param1,_gunParams);
      } else {
        this.doDummyShot(param1);
      }
    }

    private function applyRecoilForceToShooter(param1:Vector3, param2:Vector3, param3:Number) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(param1,param2,param3);
    }

    private function doRealShot(param1:int, param2:AllGlobalGunParams) : void {
      if(this.barrelCollidesWithStatic(param2.barrelOrigin,param2.direction,this.weaponPlatform.getBarrelLength())) {
        shotDirection.copy(param2.direction);
      } else {
        this.targetingSystem.getShotDirection(param2.muzzlePosition,param2.direction,param2.elevationAxis,this.weaponPlatform.getBody(),shotDirection);
      }
      this.createShot(param1,param2,shotDirection);
    }

    private function doDummyShot(param1:int) : void {
      this.callback.onDummyShot(param1);
    }

    private function barrelCollidesWithStatic(param1:Vector3, param2:Vector3, param3:Number) : Boolean {
      return getBattleRunner().getCollisionDetector().raycastStatic(param1,param2,CollisionGroup.STATIC,param3,null,rayHit);
    }

    private function getEnergy(param1:int) : Number {
      return MathUtils.clamp(this.energyRechargeRate * (param1 - this.energyBaseTime),0,this.ricochetInitParams.energyCapacity);
    }

    private function setEnergyBaseTime(param1:int, param2:Number) : void {
      this.energyBaseTime = param1 - param2 / this.energyRechargeRate;
    }

    private function createShot(param1:int, param2:AllGlobalGunParams, param3:Vector3) : void {
      var local4:RicochetShot = this.ammunition.getShot();
      local4.addToGame(param2,param3,this.weaponPlatform.getBody(),false,++shotId);
      this.callback.onShot(param1,local4.getShotId(),param3);
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.RICOCHET_RESISTANCE;
    }

    public function addEnergy(param1:int) : void {
      this.setEnergyBaseTime(this.nextShotTime,this.lastEnergy + param1);
    }

    public function reconfigure(param1:Number, param2:Number) : void {
      this.ricochetInitParams.shotDistance = param1;
      this.ricochetInitParams.energyPerShot = param2;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.recoilForce = param1;
    }

    public function fullyRecharge() : void {
      this.addEnergy(this.ricochetInitParams.energyCapacity);
      this.stunEnergy = 1;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      this.nextShotTime += param2 - param1;
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.reloadingTime = this.weaponObject.getReloadTimeMS();
    }

    public function stun() : void {
      this.stunEnergy = this.getStatus();
      this.stunTime = getTimer();
      this.stunned = true;
    }

    public function calm(param1:int) : void {
      var local2:int = getTimer() - this.stunTime;
      this.nextShotTime += param1;
      this.energyBaseTime += local2;
      this.stunned = false;
    }
  }
}
