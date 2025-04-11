package projects.tanks.client.entrance.model.entrance.clienthalt {
  public class ServerHaltEntranceCC {
    private var _serverHalt:Boolean;

    public function ServerHaltEntranceCC(param1:Boolean = false) {
      super();
      this._serverHalt = param1;
    }

    public function get serverHalt() : Boolean {
      return this._serverHalt;
    }

    public function set serverHalt(param1:Boolean) : void {
      this._serverHalt = param1;
    }

    public function toString() : String {
      var local1:String = "ServerHaltEntranceCC [";
      local1 += "serverHalt = " + this.serverHalt + " ";
      return local1 + "]";
    }
  }
}
