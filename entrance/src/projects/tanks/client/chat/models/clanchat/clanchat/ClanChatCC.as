package projects.tanks.client.chat.models.clanchat.clanchat {
  public class ClanChatCC {
    private var _inClan:Boolean;
    private var _selfName:String;

    public function ClanChatCC(param1:Boolean = false, param2:String = null) {
      super();
      this._inClan = param1;
      this._selfName = param2;
    }

    public function get inClan() : Boolean {
      return this._inClan;
    }

    public function set inClan(param1:Boolean) : void {
      this._inClan = param1;
    }

    public function get selfName() : String {
      return this._selfName;
    }

    public function set selfName(param1:String) : void {
      this._selfName = param1;
    }

    public function toString() : String {
      var local1:String = "ClanChatCC [";
      local1 += "inClan = " + this.inClan + " ";
      local1 += "selfName = " + this.selfName + " ";
      return local1 + "]";
    }
  }
}
