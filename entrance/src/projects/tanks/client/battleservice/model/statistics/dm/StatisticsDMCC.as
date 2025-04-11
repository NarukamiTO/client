package projects.tanks.client.battleservice.model.statistics.dm {
  import projects.tanks.client.battleservice.model.statistics.UserInfo;

  public class StatisticsDMCC {
    private var _usersInfo:Vector.<UserInfo>;

    public function StatisticsDMCC(param1:Vector.<UserInfo> = null) {
      super();
      this._usersInfo = param1;
    }

    public function get usersInfo() : Vector.<UserInfo> {
      return this._usersInfo;
    }

    public function set usersInfo(param1:Vector.<UserInfo>) : void {
      this._usersInfo = param1;
    }

    public function toString() : String {
      var local1:String = "StatisticsDMCC [";
      local1 += "usersInfo = " + this.usersInfo + " ";
      return local1 + "]";
    }
  }
}
