package projects.tanks.clients.flash.commons.services.serverhalt {
  public class ServerHaltService implements IServerHaltService {
    private var _isServerHalt:Boolean;

    public function ServerHaltService() {
      super();
    }

    public function setServerHalt(param1:Boolean) : void {
      this._isServerHalt = param1;
    }

    public function get isServerHalt() : Boolean {
      return this._isServerHalt;
    }
  }
}
