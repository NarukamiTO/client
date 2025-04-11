package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxData;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapons.common.CommonLocalWeapon;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class ArtilleryWeapon extends CommonLocalWeapon {
    private const BUFFED_SHOT_POWER:* = 1;

    private var reloadTimeMs:int;
    private var reloadingEndTime:int;
    private var weaponObject:ArtilleryObject;
    private var user:IGameObject;
    private var shotId:int;
    private var params:ArtilleryCC;
    private var startChargingTime:Number;
    private var needReleaseTrigger:Boolean;
    private var weaponMount:WeaponMount;
    private var effects:ArtilleryEffects;
    private var extraReloadingTimeMs:int;
    private var sfxData:ArtillerySfxData;
    private var buffed:Boolean;
    private var stunned:Boolean;
    private var stunStatus:Number;

    public function ArtilleryWeapon(param1:IGameObject, param2:ArtilleryObject, param3:ArtilleryCC, param4:ArtillerySfxData, param5:ArtilleryEffects) {
      super(param2.isLocal());
      this.user = param1;
      this.weaponObject = param2;
      this.params = param3;
      this.reloadTimeMs = param2.getReloadTimeMS();
      this.extraReloadingTimeMs = this.reloadTimeMs;
      this.effects = param5;
      this.sfxData = param4;
      this.reset();
    }

    override public function init(param1:WeaponPlatform) : void {
      var local2:ITankModel = ITankModel(this.user.adapt(ITankModel));
      this.weaponMount = local2.getWeaponMount();
      super.init(param1);
    }

    override public function getStatus() : Number {
      if(this.stunned) {
        return this.stunStatus;
      }
      if(this.buffed) {
        return 1 - Math.max(0,(this.reloadingEndTime - getTimer()) / this.reloadTimeMs);
      }
      if(this.isCharging()) {
        return 1 - Math.min(1,(getTimer() - this.startChargingTime) * 0.001 / this.params.chargingTime);
      }
      return 1 - Math.max(0,(this.reloadingEndTime - getTimer()) / (this.reloadTimeMs + this.extraReloadingTimeMs));
    }

    override public function runLogic(param1:int, param2:int) : void {
      if(this.needReleaseTrigger) {
        this.needReleaseTrigger = false;
        if(this.canShoot(this.startChargingTime)) {
          this.shoot(getPhysicsTime() - this.startChargingTime);
        }
        super.releaseTrigger();
      }
      super.runLogic(param1,param2);
      if(this.canShoot(param1)) {
        if(this.buffed) {
          this.shoot(getPhysicsTime() - this.startChargingTime);
        } else if(!this.canShoot(this.startChargingTime)) {
          this.startCharging();
        }
      }
    }

    public function startCharging() : void {
      this.startChargingTime = getPhysicsTime();
      this.weaponObject.charging().startCharging(this.startChargingTime);
      if(this.isLocalWeapon()) {
        this.effects.createChargingSoundEffect(getWeaponPlatform().getTurret3D());
      }
    }

    override public function releaseTrigger() : void {
      this.needReleaseTrigger = true;
    }

    public function shoot(param1:int) : void {
      var local2:int = getPhysicsTime();
      this.weaponObject.charging().finishCharging(local2);
      this.extraReloadingTimeMs = this.getNotSpentChargingDuration(param1);
      if(this.buffed) {
        this.reloadingEndTime = local2 + this.reloadTimeMs;
      } else {
        this.reloadingEndTime = local2 + this.reloadTimeMs + this.extraReloadingTimeMs;
      }
      var local3:WeaponPlatform = getWeaponPlatform();
      local3.getAllGunParams(gunParams);
      var local4:WeaponCommonData = this.weaponObject.commonData();
      local3.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-local4.getRecoilForce());
      local3.addDust();
      if(!BattleUtils.isTurretAboveGround(local3.getBody(),gunParams)) {
        this.weaponObject.shellCommunication().tryToDummyShoot(local2,0);
        return;
      }
      this.weaponObject.shellCommunication().tryToShoot(local2,0,++this.shotId,gunParams.direction);
      var local5:ArtilleryShell = ArtilleryShell(battleService.getObjectPool().getObject(ArtilleryShell));
      local5.init(this.sfxData,this.weaponObject,this.params,this.getSpeed(this.getDiscretePowerByDuration(param1)));
      local5.addToGame(gunParams,gunParams.direction,local3.getBody(),this is RemoteArtilleryWeapon,this.shotId);
      this.effects.createShotEffect(local3,gunParams,this.getPower(param1),this.weaponMount.getBarrelInterpolatedElevation() * 180 / Math.PI,this.reloadTimeMs + this.extraReloadingTimeMs);
    }

    private function getNotSpentChargingDuration(param1:int) : int {
      return param1 > this.params.chargingTime * 1000 ? 0 : int(this.params.chargingTime * 1000 - param1);
    }

    private function getSpeed(param1:Number) : Number {
      var local2:Number = this.params.minShellSpeed;
      var local3:Number = this.params.maxShellSpeed;
      return local2 + (local3 - local2) * param1;
    }

    public function getPower(param1:int) : Number {
      return this.getPowerByDuration(param1 - this.startChargingTime);
    }

    public function getDiscretePower(param1:int) : Number {
      return this.getDiscretePowerByDuration(param1 - this.startChargingTime);
    }

    private function getPowerByDuration(param1:int) : Number {
      return this.buffed ? this.BUFFED_SHOT_POWER : this.getChargedPower(param1);
    }

    private function getDiscretePowerByDuration(param1:int) : Number {
      return int(this.getPowerByDuration(param1) * this.params.speedsCount) / this.params.speedsCount;
    }

    private function getChargedPower(param1:int) : Number {
      return Math.min(1,param1 * 0.001 / this.params.chargingTime);
    }

    public function isCharging() : Boolean {
      return !this.stunned && this.startChargingTime >= this.reloadingEndTime;
    }

    public function isStunned() : Boolean {
      return this.stunned;
    }

    public function isBuffed() : Boolean {
      return this.buffed;
    }

    private function canShoot(param1:int) : Boolean {
      return isShooting() && param1 >= this.reloadingEndTime;
    }

    override public function reset() : void {
      super.reset();
      this.effects.reset();
      this.reloadingEndTime = 0;
      this.startChargingTime = -1;
    }

    override public function getResistanceProperty() : ItemProperty {
      return ItemProperty.ARTILLERY_RESISTANCE;
    }

    private function isLocalWeapon() : Boolean {
      return this.weaponObject.isLocal();
    }

    public function getInitialAngle() : Number {
      return this.params.initialTurretAngle;
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.buffed = param1;
      this.reloadTimeMs = this.weaponObject.getReloadTimeMS();
      this.extraReloadingTimeMs = this.reloadTimeMs;
      if(this.buffed) {
        this.effects.killChargingSound();
        this.effects.stopReloadSound();
      }
    }

    override public function fullyRecharge() : void {
      this.reloadingEndTime = 0;
      this.startChargingTime = -1;
      this.stunStatus = 1;
    }

    override public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      this.reloadingEndTime += param2 - param1 - this.extraReloadingTimeMs;
    }

    override public function stun() : void {
      this.stunStatus = this.isCharging() ? 1 : this.getStatus();
      this.stunned = true;
      this.effects.killChargingSound();
      this.effects.stopReloadSound();
    }

    override public function calm(param1:int) : void {
      var local2:Number = (1 - this.stunStatus) * (this.reloadTimeMs + this.extraReloadingTimeMs);
      if(this.isCharging()) {
        this.reloadingEndTime += getTimer();
      } else {
        this.reloadingEndTime += param1;
      }
      this.startChargingTime = 0;
      this.stunned = false;
      if(this.stunStatus < 1 && this.isLocalWeapon()) {
        this.effects.createReloadSoundEffect(getWeaponPlatform().getTurret3D(),local2);
      }
    }
  }
}
