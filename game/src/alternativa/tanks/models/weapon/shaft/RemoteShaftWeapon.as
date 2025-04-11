package alternativa.tanks.models.weapon.shaft {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteShaftWeapon implements Weapon {
    private static const allGunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const shotDirection:Vector3 = new Vector3();

    private var effects:ShaftEffects;
    private var shaftCC:ShaftCC;
    private var weaponPlatform:WeaponPlatform;
    private var turnSpeedModificationTask:TurnSpeedModificationTask;
    private var speedCharacteristics:SpeedCharacteristics;
    private var turret:WeaponMount;
    private var recoilForce:EncryptedNumber;
    private var laser:LaserPointer;

    public function RemoteShaftWeapon(param1:Number, param2:ShaftCC, param3:ShaftEffects, param4:WeaponMount, param5:SpeedCharacteristics, param6:LaserPointer) {
      super();
      this.recoilForce = new EncryptedNumberImpl(param1);
      this.shaftCC = param2;
      this.effects = param3;
      this.turret = param4;
      this.speedCharacteristics = param5;
      this.laser = param6;
    }

    private static function getShotDirection(param1:Vector3, param2:Vector3, param3:Vector3) : Vector3 {
      if(param2 != null) {
        return shotDirection.diff(param2,param1).normalize();
      }
      if(param3 == null) {
        param3 = allGunParams.direction;
      }
      return shotDirection.diff(param3,param1).normalize();
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
    }

    public function destroy() : void {
      this.effects.destroy();
    }

    public function activate() : void {
    }

    public function deactivate() : void {
      this.stopManualTargeting();
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
      this.stopManualTargeting();
    }

    public function reset() : void {
      this.stopManualTargeting();
    }

    public function getStatus() : Number {
      return 0;
    }

    public function startManualTargeting() : void {
      if(this.turnSpeedModificationTask == null) {
        this.effects.createManualModeEffects(this.weaponPlatform.getTurret3D());
        this.turnSpeedModificationTask = new TurnSpeedModificationTask(this.shaftCC,this.turret,this.speedCharacteristics);
        this.turnSpeedModificationTask.start();
      }
    }

    public function stopManualTargeting() : void {
      if(this.turnSpeedModificationTask != null) {
        this.turnSpeedModificationTask.stop();
        this.turnSpeedModificationTask = null;
      }
      this.effects.stopManualTargetingEffects();
      this.laser.hideLaser();
    }

    public function showShotEffects(param1:Vector3, param2:Body, param3:Vector3, param4:Number) : void {
      var local5:Vector3 = null;
      this.weaponPlatform.getAllGunParams(allGunParams);
      this.weaponPlatform.getBody().addWorldForceScaled(allGunParams.muzzlePosition,allGunParams.direction,-this.recoilForce.getNumber());
      this.weaponPlatform.addDust();
      this.effects.createMuzzleFlashEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
      this.effects.createShotSoundEffect(allGunParams.muzzlePosition);
      this.effects.createHitMark(allGunParams.barrelOrigin,param1);
      if(param1 != null || param3 != null) {
        local5 = getShotDirection(allGunParams.barrelOrigin,param1,param3);
        this.effects.createHitPointsGraphicEffects(param1,param3,allGunParams.muzzlePosition,allGunParams.direction,local5);
        this.applyImpactForce(param2,param3,local5,param4);
      }
    }

    private function applyImpactForce(param1:Body, param2:Vector3, param3:Vector3, param4:Number) : void {
      var local5:Number = NaN;
      var local6:Tank = null;
      if(param1 == null) {
        return;
      }
      if(Vector3.isFiniteVector(param3)) {
        local5 = param4 * WeaponConst.BASE_IMPACT_FORCE.getNumber();
        if(param1 != null && param1.tank != null) {
          if(Vector3.isFiniteVector(param2)) {
            local6 = param1.tank;
            local6.applyWeaponHit(param2,param3,local5);
          }
        }
      }
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.SHAFT_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.recoilForce.setNumber(param1);
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }
  }
}
