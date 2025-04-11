package projects.tanks.client.commons.models.challenge.time {
  public class ChallengesTimeCC {
    private var _timeLeftSec:int;

    public function ChallengesTimeCC(param1:int = 0) {
      super();
      this._timeLeftSec = param1;
    }

    public function get timeLeftSec() : int {
      return this._timeLeftSec;
    }

    public function set timeLeftSec(param1:int) : void {
      this._timeLeftSec = param1;
    }

    public function toString() : String {
      var local1:String = "ChallengesTimeCC [";
      local1 += "timeLeftSec = " + this.timeLeftSec + " ";
      return local1 + "]";
    }
  }
}
