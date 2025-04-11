package projects.tanks.client.battlefield.models.map {
  public class DynamicShadowParams {
    private var _angleX:Number;
    private var _angleZ:Number;
    private var _lightColor:int;
    private var _shadowColor:int;

    public function DynamicShadowParams(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:int = 0) {
      super();
      this._angleX = param1;
      this._angleZ = param2;
      this._lightColor = param3;
      this._shadowColor = param4;
    }

    public function get angleX() : Number {
      return this._angleX;
    }

    public function set angleX(param1:Number) : void {
      this._angleX = param1;
    }

    public function get angleZ() : Number {
      return this._angleZ;
    }

    public function set angleZ(param1:Number) : void {
      this._angleZ = param1;
    }

    public function get lightColor() : int {
      return this._lightColor;
    }

    public function set lightColor(param1:int) : void {
      this._lightColor = param1;
    }

    public function get shadowColor() : int {
      return this._shadowColor;
    }

    public function set shadowColor(param1:int) : void {
      this._shadowColor = param1;
    }

    public function toString() : String {
      var local1:String = "DynamicShadowParams [";
      local1 += "angleX = " + this.angleX + " ";
      local1 += "angleZ = " + this.angleZ + " ";
      local1 += "lightColor = " + this.lightColor + " ";
      local1 += "shadowColor = " + this.shadowColor + " ";
      return local1 + "]";
    }
  }
}
