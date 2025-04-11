package projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity {
  public class LightEffectItem {
    private var _attenuationBegin:Number;
    private var _attenuationEnd:Number;
    private var _color:String;
    private var _intensity:Number;
    private var _time:int;

    public function LightEffectItem(param1:Number = 0, param2:Number = 0, param3:String = null, param4:Number = 0, param5:int = 0) {
      super();
      this._attenuationBegin = param1;
      this._attenuationEnd = param2;
      this._color = param3;
      this._intensity = param4;
      this._time = param5;
    }

    public function get attenuationBegin() : Number {
      return this._attenuationBegin;
    }

    public function set attenuationBegin(param1:Number) : void {
      this._attenuationBegin = param1;
    }

    public function get attenuationEnd() : Number {
      return this._attenuationEnd;
    }

    public function set attenuationEnd(param1:Number) : void {
      this._attenuationEnd = param1;
    }

    public function get color() : String {
      return this._color;
    }

    public function set color(param1:String) : void {
      this._color = param1;
    }

    public function get intensity() : Number {
      return this._intensity;
    }

    public function set intensity(param1:Number) : void {
      this._intensity = param1;
    }

    public function get time() : int {
      return this._time;
    }

    public function set time(param1:int) : void {
      this._time = param1;
    }

    public function toString() : String {
      var local1:String = "LightEffectItem [";
      local1 += "attenuationBegin = " + this.attenuationBegin + " ";
      local1 += "attenuationEnd = " + this.attenuationEnd + " ";
      local1 += "color = " + this.color + " ";
      local1 += "intensity = " + this.intensity + " ";
      local1 += "time = " + this.time + " ";
      return local1 + "]";
    }
  }
}
