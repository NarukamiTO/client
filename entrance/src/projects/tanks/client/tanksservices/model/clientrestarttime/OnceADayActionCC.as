package projects.tanks.client.tanksservices.model.clientrestarttime {
  public class OnceADayActionCC {
    private var _todayRestartTime:int;

    public function OnceADayActionCC(param1:int = 0) {
      super();
      this._todayRestartTime = param1;
    }

    public function get todayRestartTime() : int {
      return this._todayRestartTime;
    }

    public function set todayRestartTime(param1:int) : void {
      this._todayRestartTime = param1;
    }

    public function toString() : String {
      var local1:String = "OnceADayActionCC [";
      local1 += "todayRestartTime = " + this.todayRestartTime + " ";
      return local1 + "]";
    }
  }
}
