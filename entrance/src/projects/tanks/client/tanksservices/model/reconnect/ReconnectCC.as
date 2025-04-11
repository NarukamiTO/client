package projects.tanks.client.tanksservices.model.reconnect {
  public class ReconnectCC {
    private var _configUrlTemplate:String;
    private var _serverNumber:int;

    public function ReconnectCC(param1:String = null, param2:int = 0) {
      super();
      this._configUrlTemplate = param1;
      this._serverNumber = param2;
    }

    public function get configUrlTemplate() : String {
      return this._configUrlTemplate;
    }

    public function set configUrlTemplate(param1:String) : void {
      this._configUrlTemplate = param1;
    }

    public function get serverNumber() : int {
      return this._serverNumber;
    }

    public function set serverNumber(param1:int) : void {
      this._serverNumber = param1;
    }

    public function toString() : String {
      var local1:String = "ReconnectCC [";
      local1 += "configUrlTemplate = " + this.configUrlTemplate + " ";
      local1 += "serverNumber = " + this.serverNumber + " ";
      return local1 + "]";
    }
  }
}
