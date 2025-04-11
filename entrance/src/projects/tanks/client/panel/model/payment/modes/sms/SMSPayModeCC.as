package projects.tanks.client.panel.model.payment.modes.sms {
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;

  public class SMSPayModeCC {
    private var _countries:Vector.<Country>;

    public function SMSPayModeCC(param1:Vector.<Country> = null) {
      super();
      this._countries = param1;
    }

    public function get countries() : Vector.<Country> {
      return this._countries;
    }

    public function set countries(param1:Vector.<Country>) : void {
      this._countries = param1;
    }

    public function toString() : String {
      var local1:String = "SMSPayModeCC [";
      local1 += "countries = " + this.countries + " ";
      return local1 + "]";
    }
  }
}
