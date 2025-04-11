package projects.tanks.client.battlefield.models.bonus.bonuslight {
  public class BonusLightCC {
    private var _attenuationBegin:Number;
    private var _attenuationEnd:Number;
    private var _intensity:Number;
    private var _lightColor:String;

    public function BonusLightCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:String = null) {
      super();
      this._attenuationBegin = param1;
      this._attenuationEnd = param2;
      this._intensity = param3;
      this._lightColor = param4;
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

    public function get intensity() : Number {
      return this._intensity;
    }

    public function set intensity(param1:Number) : void {
      this._intensity = param1;
    }

    public function get lightColor() : String {
      return this._lightColor;
    }

    public function set lightColor(param1:String) : void {
      this._lightColor = param1;
    }

    public function toString() : String {
      var local1:String = "BonusLightCC [";
      local1 += "attenuationBegin = " + this.attenuationBegin + " ";
      local1 += "attenuationEnd = " + this.attenuationEnd + " ";
      local1 += "intensity = " + this.intensity + " ";
      local1 += "lightColor = " + this.lightColor + " ";
      return local1 + "]";
    }
  }
}
