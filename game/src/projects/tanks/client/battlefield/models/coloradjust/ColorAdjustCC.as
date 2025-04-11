package projects.tanks.client.battlefield.models.coloradjust {
  public class ColorAdjustCC {
    private var _frostParamsHW:ColorAdjustParams;
    private var _frostParamsSoft:ColorAdjustParams;
    private var _heatParamsHW:ColorAdjustParams;
    private var _heatParamsSoft:ColorAdjustParams;

    public function ColorAdjustCC(param1:ColorAdjustParams = null, param2:ColorAdjustParams = null, param3:ColorAdjustParams = null, param4:ColorAdjustParams = null) {
      super();
      this._frostParamsHW = param1;
      this._frostParamsSoft = param2;
      this._heatParamsHW = param3;
      this._heatParamsSoft = param4;
    }

    public function get frostParamsHW() : ColorAdjustParams {
      return this._frostParamsHW;
    }

    public function set frostParamsHW(param1:ColorAdjustParams) : void {
      this._frostParamsHW = param1;
    }

    public function get frostParamsSoft() : ColorAdjustParams {
      return this._frostParamsSoft;
    }

    public function set frostParamsSoft(param1:ColorAdjustParams) : void {
      this._frostParamsSoft = param1;
    }

    public function get heatParamsHW() : ColorAdjustParams {
      return this._heatParamsHW;
    }

    public function set heatParamsHW(param1:ColorAdjustParams) : void {
      this._heatParamsHW = param1;
    }

    public function get heatParamsSoft() : ColorAdjustParams {
      return this._heatParamsSoft;
    }

    public function set heatParamsSoft(param1:ColorAdjustParams) : void {
      this._heatParamsSoft = param1;
    }

    public function toString() : String {
      var local1:String = "ColorAdjustCC [";
      local1 += "frostParamsHW = " + this.frostParamsHW + " ";
      local1 += "frostParamsSoft = " + this.frostParamsSoft + " ";
      local1 += "heatParamsHW = " + this.heatParamsHW + " ";
      local1 += "heatParamsSoft = " + this.heatParamsSoft + " ";
      return local1 + "]";
    }
  }
}
