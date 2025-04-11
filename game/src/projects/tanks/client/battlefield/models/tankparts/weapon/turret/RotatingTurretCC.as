package projects.tanks.client.battlefield.models.tankparts.weapon.turret {
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public class RotatingTurretCC {
    private var _turretState:TurretStateCommand;

    public function RotatingTurretCC(param1:TurretStateCommand = null) {
      super();
      this._turretState = param1;
    }

    public function get turretState() : TurretStateCommand {
      return this._turretState;
    }

    public function set turretState(param1:TurretStateCommand) : void {
      this._turretState = param1;
    }

    public function toString() : String {
      var local1:String = "RotatingTurretCC [";
      local1 += "turretState = " + this.turretState + " ";
      return local1 + "]";
    }
  }
}
