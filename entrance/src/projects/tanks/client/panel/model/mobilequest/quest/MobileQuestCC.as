package projects.tanks.client.panel.model.mobilequest.quest {
  import alternativa.types.Long;

  public class MobileQuestCC {
    private var _countSteps:int;
    private var _rewards:Vector.<MobileQuestReward>;
    private var _skipStepShopItemId:Long;

    public function MobileQuestCC(param1:int = 0, param2:Vector.<MobileQuestReward> = null, param3:Long = null) {
      super();
      this._countSteps = param1;
      this._rewards = param2;
      this._skipStepShopItemId = param3;
    }

    public function get countSteps() : int {
      return this._countSteps;
    }

    public function set countSteps(param1:int) : void {
      this._countSteps = param1;
    }

    public function get rewards() : Vector.<MobileQuestReward> {
      return this._rewards;
    }

    public function set rewards(param1:Vector.<MobileQuestReward>) : void {
      this._rewards = param1;
    }

    public function get skipStepShopItemId() : Long {
      return this._skipStepShopItemId;
    }

    public function set skipStepShopItemId(param1:Long) : void {
      this._skipStepShopItemId = param1;
    }

    public function toString() : String {
      var local1:String = "MobileQuestCC [";
      local1 += "countSteps = " + this.countSteps + " ";
      local1 += "rewards = " + this.rewards + " ";
      local1 += "skipStepShopItemId = " + this.skipStepShopItemId + " ";
      return local1 + "]";
    }
  }
}
