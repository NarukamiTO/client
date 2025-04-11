package projects.tanks.client.panel.model.payment.modes.sms.types {
  public class SMSNumber {
    private var _cost:Number;
    private var _crystals:int;
    private var _currency:String;
    private var _number:String;
    private var _smsText:String;

    public function SMSNumber(param1:Number = 0, param2:int = 0, param3:String = null, param4:String = null, param5:String = null) {
      super();
      this._cost = param1;
      this._crystals = param2;
      this._currency = param3;
      this._number = param4;
      this._smsText = param5;
    }

    public function get cost() : Number {
      return this._cost;
    }

    public function set cost(param1:Number) : void {
      this._cost = param1;
    }

    public function get crystals() : int {
      return this._crystals;
    }

    public function set crystals(param1:int) : void {
      this._crystals = param1;
    }

    public function get currency() : String {
      return this._currency;
    }

    public function set currency(param1:String) : void {
      this._currency = param1;
    }

    public function get number() : String {
      return this._number;
    }

    public function set number(param1:String) : void {
      this._number = param1;
    }

    public function get smsText() : String {
      return this._smsText;
    }

    public function set smsText(param1:String) : void {
      this._smsText = param1;
    }

    public function toString() : String {
      var local1:String = "SMSNumber [";
      local1 += "cost = " + this.cost + " ";
      local1 += "crystals = " + this.crystals + " ";
      local1 += "currency = " + this.currency + " ";
      local1 += "number = " + this.number + " ";
      local1 += "smsText = " + this.smsText + " ";
      return local1 + "]";
    }
  }
}
