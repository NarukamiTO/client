package projects.tanks.client.battlefield.models.mapbonuslight {
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustParams;

  public class MapBonusLightCC {
    private var _bonusLightIntensity:Number;
    private var _hwColorAdjust:ColorAdjustParams;
    private var _softColorAdjust:ColorAdjustParams;

    public function MapBonusLightCC(param1:Number = 0, param2:ColorAdjustParams = null, param3:ColorAdjustParams = null) {
      super();
      this._bonusLightIntensity = param1;
      this._hwColorAdjust = param2;
      this._softColorAdjust = param3;
    }

    public function get bonusLightIntensity() : Number {
      return this._bonusLightIntensity;
    }

    public function set bonusLightIntensity(param1:Number) : void {
      this._bonusLightIntensity = param1;
    }

    public function get hwColorAdjust() : ColorAdjustParams {
      return this._hwColorAdjust;
    }

    public function set hwColorAdjust(param1:ColorAdjustParams) : void {
      this._hwColorAdjust = param1;
    }

    public function get softColorAdjust() : ColorAdjustParams {
      return this._softColorAdjust;
    }

    public function set softColorAdjust(param1:ColorAdjustParams) : void {
      this._softColorAdjust = param1;
    }

    public function toString() : String {
      var local1:String = "MapBonusLightCC [";
      local1 += "bonusLightIntensity = " + this.bonusLightIntensity + " ";
      local1 += "hwColorAdjust = " + this.hwColorAdjust + " ";
      local1 += "softColorAdjust = " + this.softColorAdjust + " ";
      return local1 + "]";
    }
  }
}
