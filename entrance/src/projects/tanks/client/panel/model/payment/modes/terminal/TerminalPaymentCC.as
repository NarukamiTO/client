package projects.tanks.client.panel.model.payment.modes.terminal {
  public class TerminalPaymentCC {
    private var _terminals:Vector.<TerminalInstance>;
    private var _text:String;
    private var _withCalculator:Boolean;

    public function TerminalPaymentCC(param1:Vector.<TerminalInstance> = null, param2:String = null, param3:Boolean = false) {
      super();
      this._terminals = param1;
      this._text = param2;
      this._withCalculator = param3;
    }

    public function get terminals() : Vector.<TerminalInstance> {
      return this._terminals;
    }

    public function set terminals(param1:Vector.<TerminalInstance>) : void {
      this._terminals = param1;
    }

    public function get text() : String {
      return this._text;
    }

    public function set text(param1:String) : void {
      this._text = param1;
    }

    public function get withCalculator() : Boolean {
      return this._withCalculator;
    }

    public function set withCalculator(param1:Boolean) : void {
      this._withCalculator = param1;
    }

    public function toString() : String {
      var local1:String = "TerminalPaymentCC [";
      local1 += "terminals = " + this.terminals + " ";
      local1 += "text = " + this.text + " ";
      local1 += "withCalculator = " + this.withCalculator + " ";
      return local1 + "]";
    }
  }
}
