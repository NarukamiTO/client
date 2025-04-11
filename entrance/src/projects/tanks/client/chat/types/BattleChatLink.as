package projects.tanks.client.chat.types {
  public class BattleChatLink {
    private var _battleIdHex:String;
    private var _battleMode:String;
    private var _battleName:String;
    private var _link:String;

    public function BattleChatLink(param1:String = null, param2:String = null, param3:String = null, param4:String = null) {
      super();
      this._battleIdHex = param1;
      this._battleMode = param2;
      this._battleName = param3;
      this._link = param4;
    }

    public function get battleIdHex() : String {
      return this._battleIdHex;
    }

    public function set battleIdHex(param1:String) : void {
      this._battleIdHex = param1;
    }

    public function get battleMode() : String {
      return this._battleMode;
    }

    public function set battleMode(param1:String) : void {
      this._battleMode = param1;
    }

    public function get battleName() : String {
      return this._battleName;
    }

    public function set battleName(param1:String) : void {
      this._battleName = param1;
    }

    public function get link() : String {
      return this._link;
    }

    public function set link(param1:String) : void {
      this._link = param1;
    }

    public function toString() : String {
      var local1:String = "BattleChatLink [";
      local1 += "battleIdHex = " + this.battleIdHex + " ";
      local1 += "battleMode = " + this.battleMode + " ";
      local1 += "battleName = " + this.battleName + " ";
      local1 += "link = " + this.link + " ";
      return local1 + "]";
    }
  }
}
