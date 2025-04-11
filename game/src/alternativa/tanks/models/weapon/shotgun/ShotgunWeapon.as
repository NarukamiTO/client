package alternativa.tanks.models.weapon.shotgun {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunEffects;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
  import flash.utils.getTimer;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class ShotgunWeapon extends CommonLocalWeapon {
    private var params:ShotgunShotCC;
    private var reminderShots:int;
    private var nextShotTime:int;
    private var targeting:ShotgunRicochetTargetingSystem;
    private var fullDamageDistance:Number;
    private var bestDirection:Vector3 = new Vector3();
    private var weaponObject:ShotgunObject;
    private var reloadTimeMS:int;
    private var effects:ShotgunEffects;
    private var isMagazineReloading:Boolean;
    private var lastShotTime:int;
    private var buffedMode:Boolean;
    private var stunEnergy:Number;
    private var stunned:Boolean;

    public function ShotgunWeapon(param1:ShotgunShotCC, param2:ShotgunObject, param3:ShotgunRicochetTargetingSystem, param4:ShotgunEffects) {
      super(true);
      this.params = param1;
      this.weaponObject = param2;
      this.targeting = param3;
      this.reloadTimeMS = param2.getReloadTimeMS();
      var local5:DistanceWeakening = param2.distanceWeakening();
      this.fullDamageDistance = local5.getFullDamageDistance();
      this.effects = param4;
      this.stunned = false;
      this.reset();
    }

    override public function getStatus() : Number {
      if(this.isMagazineReloading) {
        if(this.stunned) {
          return this.stunEnergy;
        }
        return 1 - (this.nextShotTime - getTimer()) / this.params.magazineReloadTime;
      }
      return this.reminderShots / Number(this.params.magazineSize);
    }

    override public function runLogic(param1:int, param2:int) : void {
      if(isShooting() && param1 >= this.nextShotTime) {
        this.shoot(param1);
      }
    }

    private function shoot(param1:int) : void {
      var local4:Vector.<Tank> = null;
      this.lastShotTime = param1;
      var local2:WeaponPlatform = this.getWeaponPlatform();
      if(!this.buffedMode && --this.reminderShots == 0) {
        this.isMagazineReloading = true;
        this.reminderShots = this.params.magazineSize;
        this.nextShotTime = param1 + this.params.magazineReloadTime;
        this.effects.createMagazineReloadSoundEffect(local2.getTurret3D(),this.params.magazineReloadTime);
      } else {
        this.isMagazineReloading = false;
        this.nextShotTime = param1 + this.reloadTimeMS;
        if(!this.buffedMode) {
          this.effects.createReloadSoundEffect(local2.getTurret3D(),this.reloadTimeMS);
        }
      }
      local2.getAllGunParams(gunParams);
      var local3:WeaponCommonData = this.weaponObject.commonData();
      local2.getBody().addWorldForceScaled(gunParams.barrelOrigin,gunParams.direction,-local3.getRecoilForce());
      local2.addDust();
      if(BattleUtils.isTurretAboveGround(local2.getBody(),gunParams)) {
        local4 = this.targeting.getShotDirection(gunParams,local2.getBody(),this.bestDirection);
        this.weaponObject.discrete().tryToShoot(param1,this.bestDirection,local4);
      } else {
        this.bestDirection.copy(gunParams.direction);
        this.weaponObject.discrete().tryToDummyShoot(param1,this.bestDirection);
      }
      this.effects.createShotEffects(this.weaponObject,gunParams,local2,this.bestDirection);
    }

    override public function reset() : void {
      super.reset();
      this.effects.stopEffects();
      this.reminderShots = this.params.magazineSize;
      this.nextShotTime = getTimer();
      this.isMagazineReloading = false;
    }

    override public function getWeaponPlatform() : WeaponPlatform {
      return super.getWeaponPlatform();
    }

    override public function destroy() : void {
      super.destroy();
      this.weaponObject = null;
      this.targeting = null;
      this.params = null;
      this.effects.stopEffects();
      this.effects = null;
    }

    override public function disable(param1:Boolean) : void {
      super.disable(param1);
      this.effects.stopEffects();
    }

    override public function getResistanceProperty() : ItemProperty {
      return ItemProperty.SHOTGUN_RESISTANCE;
    }

    public function setRemainingShots(param1:int) : void {
      this.reminderShots = Math.min(param1,this.params.magazineSize);
      if(this.isMagazineReloading) {
        if(battleService.getBattleRunner().getPhysicsTime() < this.nextShotTime) {
          this.nextShotTime = this.lastShotTime + this.reloadTimeMS;
        }
        this.isMagazineReloading = false;
      }
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.buffedMode = param1;
      this.reloadTimeMS = this.weaponObject.getReloadTimeMS();
      if(param1) {
        this.effects.stopEffects();
      }
    }

    override public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      this.nextShotTime += param2 - param1;
    }

    override public function fullyRecharge() : void {
      this.nextShotTime = getTimer();
      this.isMagazineReloading = false;
    }

    override public function stun() : void {
      if(this.isMagazineReloading) {
        this.stunEnergy = this.getStatus();
      }
      this.stunned = true;
    }

    override public function calm(param1:int) : void {
      var local2:Number = NaN;
      var local3:WeaponPlatform = null;
      if(this.isMagazineReloading) {
        local2 = this.params.magazineReloadTime * (1 - this.stunEnergy);
        local3 = this.getWeaponPlatform();
        this.effects.createMagazineReloadSoundEffect(local3.getTurret3D(),local2);
      }
      this.nextShotTime += param1;
      this.stunned = false;
    }
  }
}
