package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell {
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ShellState {
    private var _clientTime:int;
    private var _direction:Vector3d;
    private var _position:Vector3d;

    public function ShellState(param1:int = 0, param2:Vector3d = null, param3:Vector3d = null) {
      super();
      this._clientTime = param1;
      this._direction = param2;
      this._position = param3;
    }

    public function get clientTime() : int {
      return this._clientTime;
    }

    public function set clientTime(param1:int) : void {
      this._clientTime = param1;
    }

    public function get direction() : Vector3d {
      return this._direction;
    }

    public function set direction(param1:Vector3d) : void {
      this._direction = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function toString() : String {
      var local1:String = "ShellState [";
      local1 += "clientTime = " + this.clientTime + " ";
      local1 += "direction = " + this.direction + " ";
      local1 += "position = " + this.position + " ";
      return local1 + "]";
    }
  }
}
