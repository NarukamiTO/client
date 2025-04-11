package projects.tanks.client.tanksservices.model.logging {
  public class UserActionsLoggerCC {
    private var _loggingEnabled:Boolean;

    public function UserActionsLoggerCC(param1:Boolean = false) {
      super();
      this._loggingEnabled = param1;
    }

    public function get loggingEnabled() : Boolean {
      return this._loggingEnabled;
    }

    public function set loggingEnabled(param1:Boolean) : void {
      this._loggingEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "UserActionsLoggerCC [";
      local1 += "loggingEnabled = " + this.loggingEnabled + " ";
      return local1 + "]";
    }
  }
}
