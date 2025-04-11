package alternativa.tanks.models.tank.speedcharacteristics {
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.LocalTankParams;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.user.speedcharacteristics.ISpeedCharacteristicsModelBase;
  import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsCC;
  import projects.tanks.client.battlefield.models.user.speedcharacteristics.SpeedCharacteristicsModelBase;

  [ModelInfo]
  public class SpeedCharacteristicsModel extends SpeedCharacteristicsModelBase implements ISpeedCharacteristicsModelBase, ObjectLoadListener, SpeedCharacteristics {
    public function SpeedCharacteristicsModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:SpeedCharacteristicsCC = getInitParam();
      var local2:CurrentSpeedValues = new CurrentSpeedValues();
      local2.speed = local1.currentSpeed;
      local2.turnSpeed = local1.currentTurnSpeed;
      local2.turretRotationSpeed = local1.currentTurretRotationSpeed;
      local2.acceleration = local1.currentAcceleration;
      putData(CurrentSpeedValues,local2);
    }

    public function getMaxTurretTurnSpeed() : Number {
      var local1:CurrentSpeedValues = this.getCurrentValues();
      return local1.turretRotationSpeed;
    }

    public function getMaxHullTurnSpeed() : Number {
      var local1:CurrentSpeedValues = this.getCurrentValues();
      return local1.turnSpeed;
    }

    public function getTurretRotationCoefficient() : Number {
      var local1:CurrentSpeedValues = this.getCurrentValues();
      if(getInitParam().baseTurretRotationSpeed == 0) {
        return 0;
      }
      return local1.turretRotationSpeed / getInitParam().baseTurretRotationSpeed;
    }

    public function setInitialTankState() : void {
      var local1:ITankModel = ITankModel(object.adapt(ITankModel));
      var local2:Tank = local1.getTank();
      local2.setReverseAcceleration(BattleUtils.toClientScale(getInitParam().reverseAcceleration));
      local2.setSideAcceleration(BattleUtils.toClientScale(getInitParam().sideAcceleration));
      local2.setTurnAcceleration(getInitParam().turnAcceleration);
      local2.setReverseTurnAcceleration(getInitParam().reverseTurnAcceleration);
      local2.setStabilizationAcceleration(getInitParam().turnStabilizationAcceleration);
      this.setTankSpec(local1,getInitParam().currentSpeed,getInitParam().currentTurnSpeed,getInitParam().currentTurretRotationSpeed,getInitParam().currentAcceleration,true);
    }

    [Obfuscation(rename="false")]
    public function setSpecification(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Boolean) : void {
      var local7:* = param6 || this.getCurrentValues().acceleration == 0;
      var local8:ITankModel = ITankModel(object.adapt(ITankModel));
      this.setTankSpec(local8,param1,param2,param3,param4,local7);
      if(local8.isLocal()) {
        LocalTankParams.setSpecificationId(param5);
      }
    }

    private function setTankSpec(param1:ITankModel, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean) : void {
      var local7:CurrentSpeedValues = new CurrentSpeedValues();
      local7.speed = param2;
      local7.turnSpeed = param3;
      local7.turretRotationSpeed = param4;
      local7.acceleration = param5;
      putData(CurrentSpeedValues,local7);
      var local8:Tank = param1.getTank();
      local8.setMaxSpeed(BattleUtils.toClientScale(param2),param6);
      local8.setMaxTurnSpeed(param3,param6);
      local8.setAcceleration(BattleUtils.toClientScale(param5));
      local8.getWeaponMount().setMaxTurnSpeed(param4,param6);
    }

    private function getCurrentValues() : CurrentSpeedValues {
      return CurrentSpeedValues(getData(CurrentSpeedValues));
    }
  }
}

class CurrentSpeedValues {
  public var speed:Number;
  public var turnSpeed:Number;
  public var turretRotationSpeed:Number;
  public var acceleration:Number;

  public function CurrentSpeedValues() {
    super();
  }
}
