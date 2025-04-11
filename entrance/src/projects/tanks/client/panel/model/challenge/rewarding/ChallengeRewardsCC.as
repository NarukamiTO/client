package projects.tanks.client.panel.model.challenge.rewarding {
  public class ChallengeRewardsCC {
    private var _tiers:Vector.<Tier>;

    public function ChallengeRewardsCC(param1:Vector.<Tier> = null) {
      super();
      this._tiers = param1;
    }

    public function get tiers() : Vector.<Tier> {
      return this._tiers;
    }

    public function set tiers(param1:Vector.<Tier>) : void {
      this._tiers = param1;
    }

    public function toString() : String {
      var local1:String = "ChallengeRewardsCC [";
      local1 += "tiers = " + this.tiers + " ";
      return local1 + "]";
    }
  }
}
