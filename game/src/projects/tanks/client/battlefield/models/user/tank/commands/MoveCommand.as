package projects.tanks.client.battlefield.models.user.tank.commands {
  import projects.tanks.client.battlefield.types.Vector3d;

  public class MoveCommand {
    private var _angularVelocity:Vector3d;
    private var _control:int;
    private var _linearVelocity:Vector3d;
    private var _orientation:Vector3d;
    private var _position:Vector3d;
    private var _turnSpeedNumber:int;

    public function MoveCommand(param1:Vector3d = null, param2:int = 0, param3:Vector3d = null, param4:Vector3d = null, param5:Vector3d = null, param6:int = 0) {
      super();
      this._angularVelocity = param1;
      this._control = param2;
      this._linearVelocity = param3;
      this._orientation = param4;
      this._position = param5;
      this._turnSpeedNumber = param6;
    }

    public function get angularVelocity() : Vector3d {
      return this._angularVelocity;
    }

    public function set angularVelocity(param1:Vector3d) : void {
      this._angularVelocity = param1;
    }

    public function get control() : int {
      return this._control;
    }

    public function set control(param1:int) : void {
      this._control = param1;
    }

    public function get linearVelocity() : Vector3d {
      return this._linearVelocity;
    }

    public function set linearVelocity(param1:Vector3d) : void {
      this._linearVelocity = param1;
    }

    public function get orientation() : Vector3d {
      return this._orientation;
    }

    public function set orientation(param1:Vector3d) : void {
      this._orientation = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function get turnSpeedNumber() : int {
      return this._turnSpeedNumber;
    }

    public function set turnSpeedNumber(param1:int) : void {
      this._turnSpeedNumber = param1;
    }

    public function toString() : String {
      var local1:String = "MoveCommand [";
      local1 += "angularVelocity = " + this.angularVelocity + " ";
      local1 += "control = " + this.control + " ";
      local1 += "linearVelocity = " + this.linearVelocity + " ";
      local1 += "orientation = " + this.orientation + " ";
      local1 += "position = " + this.position + " ";
      local1 += "turnSpeedNumber = " + this.turnSpeedNumber + " ";
      return local1 + "]";
    }
  }
}
