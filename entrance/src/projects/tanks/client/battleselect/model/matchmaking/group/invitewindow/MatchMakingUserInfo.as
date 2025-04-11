package projects.tanks.client.battleselect.model.matchmaking.group.invitewindow {
  import alternativa.types.Long;

  public class MatchMakingUserInfo {
    private var _friend:Boolean;
    private var _id:Long;
    private var _onLine:Boolean;
    private var _rank:int;
    private var _sameClan:Boolean;
    private var _uid:String;

    public function MatchMakingUserInfo(param1:Boolean = false, param2:Long = null, param3:Boolean = false, param4:int = 0, param5:Boolean = false, param6:String = null) {
      super();
      this._friend = param1;
      this._id = param2;
      this._onLine = param3;
      this._rank = param4;
      this._sameClan = param5;
      this._uid = param6;
    }

    public function get friend() : Boolean {
      return this._friend;
    }

    public function set friend(param1:Boolean) : void {
      this._friend = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get onLine() : Boolean {
      return this._onLine;
    }

    public function set onLine(param1:Boolean) : void {
      this._onLine = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }

    public function get sameClan() : Boolean {
      return this._sameClan;
    }

    public function set sameClan(param1:Boolean) : void {
      this._sameClan = param1;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }

    public function toString() : String {
      var local1:String = "MatchMakingUserInfo [";
      local1 += "friend = " + this.friend + " ";
      local1 += "id = " + this.id + " ";
      local1 += "onLine = " + this.onLine + " ";
      local1 += "rank = " + this.rank + " ";
      local1 += "sameClan = " + this.sameClan + " ";
      local1 += "uid = " + this.uid + " ";
      return local1 + "]";
    }
  }
}
