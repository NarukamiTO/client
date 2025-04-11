package alternativa.tanks.models.weapon.shaft {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;

  public class TurnSpeedModificationTask extends BattleRunnerProvider implements LogicUnit {
    private var shaftCC:ShaftCC;
    private var time:int;
    private var killed:Boolean;
    private var turret:WeaponMount;
    private var savedTurnAcceleration:Number;
    private var speedCharacteristic:SpeedCharacteristics;

    public function TurnSpeedModificationTask(param1:ShaftCC, param2:WeaponMount, param3:SpeedCharacteristics) {
      super();
      this.shaftCC = param1;
      this.turret = param2;
      this.speedCharacteristic = param3;
      this.killed = false;
      this.time = 0;
    }

    public function start() : void {
      getBattleRunner().addLogicUnit(this);
      this.savedTurnAcceleration = this.turret.getTurnAcceleration();
    }

    public function stop() : void {
      getBattleRunner().removeLogicUnit(this);
      this.killed = true;
      this.turret.setMaxTurnSpeed(this.speedCharacteristic.getMaxTurretTurnSpeed(),true);
      this.turret.setTurnAcceleration(this.savedTurnAcceleration);
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:Number = NaN;
      if(!this.killed) {
        this.time += param2;
        local3 = this.shaftCC.dischargeRate * (this.time + this.shaftCC.targetingTransitionTime) / 1000 / this.shaftCC.maxEnergy;
        if(local3 > 1) {
          local3 = 1;
        }
        this.turret.setMaxTurnSpeed(this.getSpeedFactor(local3) * this.shaftCC.horizontalTargetingSpeed * this.speedCharacteristic.getTurretRotationCoefficient(),false);
        this.turret.setTurnAcceleration(this.shaftCC.targetingAcceleration);
      }
    }

    private function getSpeedFactor(param1:Number) : Number {
      var local2:Number = this.shaftCC.rotationCoeffT1;
      if(param1 < local2) {
        return 1;
      }
      var local3:Number = this.shaftCC.rotationCoeffT2;
      var local4:Number = this.shaftCC.rotationCoeffKmin;
      if(param1 < local3) {
        return 1 - (1 - local4) * (param1 - local2) / (local3 - local2);
      }
      return local4;
    }
  }
}
