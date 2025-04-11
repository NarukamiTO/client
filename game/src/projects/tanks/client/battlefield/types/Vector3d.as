package projects.tanks.client.battlefield.types {
  public class Vector3d {
    private var _x:Number;
    private var _y:Number;
    private var _z:Number;

    public function Vector3d(param1:Number = 0, param2:Number = 0, param3:Number = 0) {
      super();
      this._x = param1;
      this._y = param2;
      this._z = param3;
    }

    public function get x() : Number {
      return this._x;
    }

    public function set x(param1:Number) : void {
      this._x = param1;
    }

    public function get y() : Number {
      return this._y;
    }

    public function set y(param1:Number) : void {
      this._y = param1;
    }

    public function get z() : Number {
      return this._z;
    }

    public function set z(param1:Number) : void {
      this._z = param1;
    }

    public function toString() : String {
      var local1:String = "Vector3d [";
      local1 += "x = " + this.x + " ";
      local1 += "y = " + this.y + " ";
      local1 += "z = " + this.z + " ";
      return local1 + "]";
    }
  }
}
