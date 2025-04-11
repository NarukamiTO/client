package projects.tanks.client.panel.model.payment.modes.sms.types {
  public class SMSOperator {
    private var _id:int;
    private var _name:String;

    public function SMSOperator(param1:int = 0, param2:String = null) {
      super();
      this._id = param1;
      this._name = param2;
    }

    public function get id() : int {
      return this._id;
    }

    public function set id(param1:int) : void {
      this._id = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "SMSOperator [";
      local1 += "id = " + this.id + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
