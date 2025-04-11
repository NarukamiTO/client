package projects.tanks.client.panel.model.payment.modes.qiwi {
  public class QiwiPaymentCC {
    private var _countryPhoneCodes:Vector.<CountryPhoneInfo>;

    public function QiwiPaymentCC(param1:Vector.<CountryPhoneInfo> = null) {
      super();
      this._countryPhoneCodes = param1;
    }

    public function get countryPhoneCodes() : Vector.<CountryPhoneInfo> {
      return this._countryPhoneCodes;
    }

    public function set countryPhoneCodes(param1:Vector.<CountryPhoneInfo>) : void {
      this._countryPhoneCodes = param1;
    }

    public function toString() : String {
      var local1:String = "QiwiPaymentCC [";
      local1 += "countryPhoneCodes = " + this.countryPhoneCodes + " ";
      return local1 + "]";
    }
  }
}
