package projects.tanks.client.battlefield.types {
  public class TankState {
    private var _angularVelocity:Vector3d;
    private var _chassisControl:int;
    private var _chassisTurnSpeedNumber:int;
    private var _linearVelocity:Vector3d;
    private var _orientation:Vector3d;
    private var _position:Vector3d;

    public function TankState(param1:Vector3d = null, param2:int = 0, param3:int = 0, param4:Vector3d = null, param5:Vector3d = null, param6:Vector3d = null) {
      super();
      this._angularVelocity = param1;
      this._chassisControl = param2;
      this._chassisTurnSpeedNumber = param3;
      this._linearVelocity = param4;
      this._orientation = param5;
      this._position = param6;
    }

    public function get angularVelocity() : Vector3d {
      return this._angularVelocity;
    }

    public function set angularVelocity(param1:Vector3d) : void {
      this._angularVelocity = param1;
    }

    public function get chassisControl() : int {
      return this._chassisControl;
    }

    public function set chassisControl(param1:int) : void {
      this._chassisControl = param1;
    }

    public function get chassisTurnSpeedNumber() : int {
      return this._chassisTurnSpeedNumber;
    }

    public function set chassisTurnSpeedNumber(param1:int) : void {
      this._chassisTurnSpeedNumber = param1;
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

    public function toString() : String {
      var local1:String = "TankState [";
      local1 += "angularVelocity = " + this.angularVelocity + " ";
      local1 += "chassisControl = " + this.chassisControl + " ";
      local1 += "chassisTurnSpeedNumber = " + this.chassisTurnSpeedNumber + " ";
      local1 += "linearVelocity = " + this.linearVelocity + " ";
      local1 += "orientation = " + this.orientation + " ";
      local1 += "position = " + this.position + " ";
      return local1 + "]";
    }
  }
}
