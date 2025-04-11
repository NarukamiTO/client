package projects.tanks.client.garage.models.item.videoads {
  public class VideoAdsItemUpgradeCC {
    private var _cooldownTimeInSec:int;
    private var _timeToReduceUpdateInMin:int;

    public function VideoAdsItemUpgradeCC(param1:int = 0, param2:int = 0) {
      super();
      this._cooldownTimeInSec = param1;
      this._timeToReduceUpdateInMin = param2;
    }

    public function get cooldownTimeInSec() : int {
      return this._cooldownTimeInSec;
    }

    public function set cooldownTimeInSec(param1:int) : void {
      this._cooldownTimeInSec = param1;
    }

    public function get timeToReduceUpdateInMin() : int {
      return this._timeToReduceUpdateInMin;
    }

    public function set timeToReduceUpdateInMin(param1:int) : void {
      this._timeToReduceUpdateInMin = param1;
    }

    public function toString() : String {
      var local1:String = "VideoAdsItemUpgradeCC [";
      local1 += "cooldownTimeInSec = " + this.cooldownTimeInSec + " ";
      local1 += "timeToReduceUpdateInMin = " + this.timeToReduceUpdateInMin + " ";
      return local1 + "]";
    }
  }
}
