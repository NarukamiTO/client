package projects.tanks.client.clans.panel.notification {
  public class ClanPanelNotificationCC {
    private var _numberNotifications:int;
    private var _restrictionTimeJoinClanInSec:int;

    public function ClanPanelNotificationCC(param1:int = 0, param2:int = 0) {
      super();
      this._numberNotifications = param1;
      this._restrictionTimeJoinClanInSec = param2;
    }

    public function get numberNotifications() : int {
      return this._numberNotifications;
    }

    public function set numberNotifications(param1:int) : void {
      this._numberNotifications = param1;
    }

    public function get restrictionTimeJoinClanInSec() : int {
      return this._restrictionTimeJoinClanInSec;
    }

    public function set restrictionTimeJoinClanInSec(param1:int) : void {
      this._restrictionTimeJoinClanInSec = param1;
    }

    public function toString() : String {
      var local1:String = "ClanPanelNotificationCC [";
      local1 += "numberNotifications = " + this.numberNotifications + " ";
      local1 += "restrictionTimeJoinClanInSec = " + this.restrictionTimeJoinClanInSec + " ";
      return local1 + "]";
    }
  }
}
