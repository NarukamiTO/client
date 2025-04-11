package projects.tanks.client.panel.model.shop.emailrequired {
  public class EmailRequiredCC {
    private var _emailRequired:Boolean;

    public function EmailRequiredCC(param1:Boolean = false) {
      super();
      this._emailRequired = param1;
    }

    public function get emailRequired() : Boolean {
      return this._emailRequired;
    }

    public function set emailRequired(param1:Boolean) : void {
      this._emailRequired = param1;
    }

    public function toString() : String {
      var local1:String = "EmailRequiredCC [";
      local1 += "emailRequired = " + this.emailRequired + " ";
      return local1 + "]";
    }
  }
}
