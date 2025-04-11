package projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct {
  public class ColorTransformStruct {
    private var _alphaMultiplier:Number;
    private var _alphaOffset:int;
    private var _blueMultiplier:Number;
    private var _blueOffset:int;
    private var _greenMultiplier:Number;
    private var _greenOffset:int;
    private var _redMultiplier:Number;
    private var _redOffset:int;
    private var _t:Number;

    public function ColorTransformStruct(param1:Number = 0, param2:int = 0, param3:Number = 0, param4:int = 0, param5:Number = 0, param6:int = 0, param7:Number = 0, param8:int = 0, param9:Number = 0) {
      super();
      this._alphaMultiplier = param1;
      this._alphaOffset = param2;
      this._blueMultiplier = param3;
      this._blueOffset = param4;
      this._greenMultiplier = param5;
      this._greenOffset = param6;
      this._redMultiplier = param7;
      this._redOffset = param8;
      this._t = param9;
    }

    public function get alphaMultiplier() : Number {
      return this._alphaMultiplier;
    }

    public function set alphaMultiplier(param1:Number) : void {
      this._alphaMultiplier = param1;
    }

    public function get alphaOffset() : int {
      return this._alphaOffset;
    }

    public function set alphaOffset(param1:int) : void {
      this._alphaOffset = param1;
    }

    public function get blueMultiplier() : Number {
      return this._blueMultiplier;
    }

    public function set blueMultiplier(param1:Number) : void {
      this._blueMultiplier = param1;
    }

    public function get blueOffset() : int {
      return this._blueOffset;
    }

    public function set blueOffset(param1:int) : void {
      this._blueOffset = param1;
    }

    public function get greenMultiplier() : Number {
      return this._greenMultiplier;
    }

    public function set greenMultiplier(param1:Number) : void {
      this._greenMultiplier = param1;
    }

    public function get greenOffset() : int {
      return this._greenOffset;
    }

    public function set greenOffset(param1:int) : void {
      this._greenOffset = param1;
    }

    public function get redMultiplier() : Number {
      return this._redMultiplier;
    }

    public function set redMultiplier(param1:Number) : void {
      this._redMultiplier = param1;
    }

    public function get redOffset() : int {
      return this._redOffset;
    }

    public function set redOffset(param1:int) : void {
      this._redOffset = param1;
    }

    public function get t() : Number {
      return this._t;
    }

    public function set t(param1:Number) : void {
      this._t = param1;
    }

    public function toString() : String {
      var local1:String = "ColorTransformStruct [";
      local1 += "alphaMultiplier = " + this.alphaMultiplier + " ";
      local1 += "alphaOffset = " + this.alphaOffset + " ";
      local1 += "blueMultiplier = " + this.blueMultiplier + " ";
      local1 += "blueOffset = " + this.blueOffset + " ";
      local1 += "greenMultiplier = " + this.greenMultiplier + " ";
      local1 += "greenOffset = " + this.greenOffset + " ";
      local1 += "redMultiplier = " + this.redMultiplier + " ";
      local1 += "redOffset = " + this.redOffset + " ";
      local1 += "t = " + this.t + " ";
      return local1 + "]";
    }
  }
}
