package projects.tanks.client.battlefield.models.map {
  public class FogParams {
    private var _alpha:Number;
    private var _color:int;
    private var _farLimit:Number;
    private var _nearLimit:Number;

    public function FogParams(param1:Number = 0, param2:int = 0, param3:Number = 0, param4:Number = 0) {
      super();
      this._alpha = param1;
      this._color = param2;
      this._farLimit = param3;
      this._nearLimit = param4;
    }

    public function get alpha() : Number {
      return this._alpha;
    }

    public function set alpha(param1:Number) : void {
      this._alpha = param1;
    }

    public function get color() : int {
      return this._color;
    }

    public function set color(param1:int) : void {
      this._color = param1;
    }

    public function get farLimit() : Number {
      return this._farLimit;
    }

    public function set farLimit(param1:Number) : void {
      this._farLimit = param1;
    }

    public function get nearLimit() : Number {
      return this._nearLimit;
    }

    public function set nearLimit(param1:Number) : void {
      this._nearLimit = param1;
    }

    public function toString() : String {
      var local1:String = "FogParams [";
      local1 += "alpha = " + this.alpha + " ";
      local1 += "color = " + this.color + " ";
      local1 += "farLimit = " + this.farLimit + " ";
      local1 += "nearLimit = " + this.nearLimit + " ";
      return local1 + "]";
    }
  }
}
