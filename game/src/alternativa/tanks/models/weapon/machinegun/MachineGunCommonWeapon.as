package alternativa.tanks.models.weapon.machinegun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunEffects;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class MachineGunCommonWeapon implements Weapon {
    [Inject]
    public static var battleService:BattleService;

    private static var gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private static const MAX_GYROSCOPE_COEFF:Number = 0.5;

    private var tank:Tank;
    private var speedCharacteristics:SpeedCharacteristics;
    private var spinUpTime:int;
    private var spinUpSpeed:Number;
    private var spinDownSpeed:Number;
    private var _state:Number = 0;
    private var weaponPlatform:WeaponPlatform;
    private var weaponCommonParams:WeaponCommonData;
    private var tankModel:ITankModel;
    private var params:MachineGunCC;
    private var sfxData:MachineGunSFXData;
    private var effects:MachineGunEffects;

    public function MachineGunCommonWeapon(param1:IGameObject, param2:MachineGunCC, param3:MachineGunSFXData, param4:WeaponCommonData) {
      super();
      this.tankModel = ITankModel(param1.adapt(ITankModel));
      this.speedCharacteristics = SpeedCharacteristics(param1.adapt(SpeedCharacteristics));
      this.sfxData = param3;
      this.spinUpTime = param2.spinUpTime;
      this.spinUpSpeed = 1 / param2.spinUpTime;
      this.spinDownSpeed = 1 / param2.spinDownTime;
      this.params = param2;
      this.weaponCommonParams = param4;
      this._state = this.params.state;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.effects = new MachineGunEffects(param1,this.params,this.sfxData);
    }

    public function activate() : void {
      this.tank = this.tankModel.getTank();
    }

    public function start() : void {
    }

    public function stop() : void {
    }

    public function get state() : Number {
      return this._state;
    }

    public function stopEffects() : void {
      this.effects.update(0,0,false);
    }

    public function updateCharacteristicsAndEffects(param1:int, param2:Boolean) : void {
      this.updateState(param1,param2);
      this.updateSpeed();
      this.effects.update(param1,this.state,param2);
    }

    public function updateGunParams() : AllGlobalGunParams {
      this.weaponPlatform.getAllGunParams(gunParams);
      return gunParams;
    }

    public function addRecoilForShooter(param1:Vector3, param2:Number) : void {
      this.applyForce(this.tank.getBody(),gunParams.muzzlePosition,param1,-this.weaponCommonParams.getRecoilForce() * param2);
    }

    public function addImpactForTarget(param1:Body, param2:Vector3, param3:Vector3, param4:Number) : void {
      this.applyForce(param1,param2,param3,this.weaponCommonParams.getImpactForce() * param4);
    }

    public function getPowerCoeff(param1:int, param2:int, param3:int) : Number {
      return Math.max(param1 + Math.min(param2 - param3,0),0) / 1000;
    }

    public function setTargetPosition(param1:Vector3, param2:Boolean) : void {
      if(this.isTurretAboveGround()) {
        this.effects.setTargetPosition(param1,param2);
      } else {
        this.effects.clearTargetPosition(true);
      }
    }

    public function clearTargetPosition() : void {
      this.effects.clearTargetPosition(!this.isTurretAboveGround());
    }

    public function reset() : void {
      this._state = 0;
      if(this.tank != null) {
        this.tank.getWeaponMount().setGyroscopePower(0);
      }
    }

    public function destroy() : void {
      this.effects.destroy();
      this.effects = null;
      if(this.weaponPlatform != null) {
        this.weaponPlatform = null;
      }
      if(this.tank != null) {
        this.tank = null;
      }
      this.tankModel = null;
      this.speedCharacteristics = null;
      this.sfxData = null;
      this.params = null;
      this.weaponCommonParams = null;
    }

    public function deactivate() : void {
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
    }

    public function getStatus() : Number {
      return 0;
    }

    private function applyForce(param1:Body, param2:Vector3, param3:Vector3, param4:Number) : void {
      param1.addWorldForceScaled(param2,param3,param4);
      var local5:Tank = param1.tank;
      var local6:int = local5.getLeftTrack().numContacts + local5.getRightTrack().numContacts;
      if(local6 == 0 || BattleUtils.isTurnedOver(param1)) {
        param1.addScaledForce(param3,-param4);
      }
    }

    private function isTurretAboveGround() : Boolean {
      return BattleUtils.isTurretAboveGround(this.weaponPlatform.getBody(),gunParams);
    }

    private function updateState(param1:int, param2:Boolean) : void {
      if(param2) {
        this._state = Math.min(1,this.state + param1 * this.spinUpSpeed);
      } else {
        this._state = Math.max(0,this.state - param1 * this.spinDownSpeed);
      }
    }

    private function updateSpeed() : void {
      var local2:WeaponMount = null;
      var local1:Number = this.params.weaponTurnDecelerationCoeff + this.rotationCoeff() * (1 - this.params.weaponTurnDecelerationCoeff);
      if(this.tank != null) {
        local2 = this.tank.getWeaponMount();
        local2.setMaxTurnSpeed(this.speedCharacteristics.getMaxTurretTurnSpeed() * local1,true);
        local2.setTurnAcceleration(this.weaponCommonParams.getTurretRotationAcceleration() * local1);
        local2.setGyroscopePower(MAX_GYROSCOPE_COEFF * this.state);
      }
    }

    private function rotationCoeff() : Number {
      return 1 - this.state;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.MACHINE_GUN_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.weaponCommonParams.setRecoilForce(param1);
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function updateSpinTimes(param1:int, param2:int) : void {
      this.spinUpTime = param1;
      this.spinUpSpeed = 1 / param1;
      this.spinDownSpeed = 1 / param2;
    }

    public function getCurrentSpinUpTime() : int {
      return this.spinUpTime;
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }

    public function spin() : void {
      this._state = 1;
    }
  }
}
