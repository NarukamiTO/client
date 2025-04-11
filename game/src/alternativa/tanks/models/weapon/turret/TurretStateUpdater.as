package alternativa.tanks.models.weapon.turret {
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.controllers.Turret;
  import alternativa.tanks.utils.MathUtils;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public class TurretStateUpdater implements LogicUnit {
    private static const MAX_TARGET_DIRECTION_DELTA:Number = MathUtils.toRadians(5);
    private static const MAX_DIRECTION_DELTA:Number = Math.PI / 6;

    private var turret:Turret;

    private const lastSentState:TurretStateCommand = new TurretStateCommand();

    private var millisSinceLastUpdate:int;
    private var updateCallback:Function;

    public function TurretStateUpdater(param1:Turret, param2:Function) {
      super();
      this.turret = param1;
      this.updateCallback = param2;
    }

    public function reset() : void {
      this.millisSinceLastUpdate = 0;
      RotatingTurretModel.copyStateFromTurret(this.turret,this.lastSentState);
    }

    private function sendUpdate() : void {
      this.reset();
      this.updateCallback();
    }

    public function runLogic(param1:int, param2:int) : void {
      this.millisSinceLastUpdate += param2;
      if(this.turretStateChanged()) {
        this.sendUpdate();
      }
    }

    private function turretStateChanged() : Boolean {
      var local3:Number = NaN;
      var local1:TurretControlType = this.lastSentState.controlType;
      if(local1 != this.turret.getTurretRealControlType()) {
        return true;
      }
      switch(local1) {
        case TurretControlType.ROTATION_DIRECTION:
          if(this.lastSentState.controlInput != this.turret.getTurretRealControlInput()) {
            return true;
          }
          break;
        default:
          local3 = MathUtils.clampAngleDelta(this.turret.getTurretRealControlInput(),this.lastSentState.controlInput);
          if(Math.abs(local3) > MAX_TARGET_DIRECTION_DELTA) {
            return true;
          }
          break;
      }
      var local2:Number = MathUtils.clampAngleDelta(this.turret.getTurretPhysicsDirection(),this.lastSentState.direction);
      return Math.abs(local2) > MAX_DIRECTION_DELTA;
    }
  }
}
