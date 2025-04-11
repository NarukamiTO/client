package projects.tanks.client.users.model.friends {
  public class FriendsCC {
    private var _acceptedLimit:int;
    private var _incomingLimit:int;
    private var _local:Boolean;

    public function FriendsCC(param1:int = 0, param2:int = 0, param3:Boolean = false) {
      super();
      this._acceptedLimit = param1;
      this._incomingLimit = param2;
      this._local = param3;
    }

    public function get acceptedLimit() : int {
      return this._acceptedLimit;
    }

    public function set acceptedLimit(param1:int) : void {
      this._acceptedLimit = param1;
    }

    public function get incomingLimit() : int {
      return this._incomingLimit;
    }

    public function set incomingLimit(param1:int) : void {
      this._incomingLimit = param1;
    }

    public function get local() : Boolean {
      return this._local;
    }

    public function set local(param1:Boolean) : void {
      this._local = param1;
    }

    public function toString() : String {
      var local1:String = "FriendsCC [";
      local1 += "acceptedLimit = " + this.acceptedLimit + " ";
      local1 += "incomingLimit = " + this.incomingLimit + " ";
      local1 += "local = " + this.local + " ";
      return local1 + "]";
    }
  }
}
