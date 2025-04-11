package projects.tanks.client.battlefield.models.battle.pointbased.flag {
  import projects.tanks.client.battlefield.types.Vector3d;

  public class FlagFlyPoint {
    private var _mode:FlyingMode;
    private var _position:Vector3d;
    private var _rotation_w:Number;
    private var _rotation_x:Number;
    private var _rotation_y:Number;
    private var _rotation_z:Number;
    private var _time:int;

    public function FlagFlyPoint(param1:FlyingMode = null, param2:Vector3d = null, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:int = 0) {
      super();
      this._mode = param1;
      this._position = param2;
      this._rotation_w = param3;
      this._rotation_x = param4;
      this._rotation_y = param5;
      this._rotation_z = param6;
      this._time = param7;
    }

    public function get mode() : FlyingMode {
      return this._mode;
    }

    public function set mode(param1:FlyingMode) : void {
      this._mode = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function get rotation_w() : Number {
      return this._rotation_w;
    }

    public function set rotation_w(param1:Number) : void {
      this._rotation_w = param1;
    }

    public function get rotation_x() : Number {
      return this._rotation_x;
    }

    public function set rotation_x(param1:Number) : void {
      this._rotation_x = param1;
    }

    public function get rotation_y() : Number {
      return this._rotation_y;
    }

    public function set rotation_y(param1:Number) : void {
      this._rotation_y = param1;
    }

    public function get rotation_z() : Number {
      return this._rotation_z;
    }

    public function set rotation_z(param1:Number) : void {
      this._rotation_z = param1;
    }

    public function get time() : int {
      return this._time;
    }

    public function set time(param1:int) : void {
      this._time = param1;
    }

    public function toString() : String {
      var local1:String = "FlagFlyPoint [";
      local1 += "mode = " + this.mode + " ";
      local1 += "position = " + this.position + " ";
      local1 += "rotation_w = " + this.rotation_w + " ";
      local1 += "rotation_x = " + this.rotation_x + " ";
      local1 += "rotation_y = " + this.rotation_y + " ";
      local1 += "rotation_z = " + this.rotation_z + " ";
      local1 += "time = " + this.time + " ";
      return local1 + "]";
    }
  }
}
