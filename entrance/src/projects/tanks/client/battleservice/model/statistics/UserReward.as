package projects.tanks.client.battleservice.model.statistics {
  import alternativa.types.Long;

  public class UserReward {
    private var _newbiesAbonementBonusReward:int;
    private var _premiumBonusReward:int;
    private var _reward:int;
    private var _starsReward:int;
    private var _starsRewardForPremium:int;
    private var _userId:Long;

    public function UserReward(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:Long = null) {
      super();
      this._newbiesAbonementBonusReward = param1;
      this._premiumBonusReward = param2;
      this._reward = param3;
      this._starsReward = param4;
      this._starsRewardForPremium = param5;
      this._userId = param6;
    }

    public function get newbiesAbonementBonusReward() : int {
      return this._newbiesAbonementBonusReward;
    }

    public function set newbiesAbonementBonusReward(param1:int) : void {
      this._newbiesAbonementBonusReward = param1;
    }

    public function get premiumBonusReward() : int {
      return this._premiumBonusReward;
    }

    public function set premiumBonusReward(param1:int) : void {
      this._premiumBonusReward = param1;
    }

    public function get reward() : int {
      return this._reward;
    }

    public function set reward(param1:int) : void {
      this._reward = param1;
    }

    public function get starsReward() : int {
      return this._starsReward;
    }

    public function set starsReward(param1:int) : void {
      this._starsReward = param1;
    }

    public function get starsRewardForPremium() : int {
      return this._starsRewardForPremium;
    }

    public function set starsRewardForPremium(param1:int) : void {
      this._starsRewardForPremium = param1;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function toString() : String {
      var local1:String = "UserReward [";
      local1 += "newbiesAbonementBonusReward = " + this.newbiesAbonementBonusReward + " ";
      local1 += "premiumBonusReward = " + this.premiumBonusReward + " ";
      local1 += "reward = " + this.reward + " ";
      local1 += "starsReward = " + this.starsReward + " ";
      local1 += "starsRewardForPremium = " + this.starsRewardForPremium + " ";
      local1 += "userId = " + this.userId + " ";
      return local1 + "]";
    }
  }
}
