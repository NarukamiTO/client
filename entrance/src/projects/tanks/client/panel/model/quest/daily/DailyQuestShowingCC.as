package projects.tanks.client.panel.model.quest.daily {
  public class DailyQuestShowingCC {
    private var _hasNewQuests:Boolean;
    private var _timeToNextQuest:int;

    public function DailyQuestShowingCC(param1:Boolean = false, param2:int = 0) {
      super();
      this._hasNewQuests = param1;
      this._timeToNextQuest = param2;
    }

    public function get hasNewQuests() : Boolean {
      return this._hasNewQuests;
    }

    public function set hasNewQuests(param1:Boolean) : void {
      this._hasNewQuests = param1;
    }

    public function get timeToNextQuest() : int {
      return this._timeToNextQuest;
    }

    public function set timeToNextQuest(param1:int) : void {
      this._timeToNextQuest = param1;
    }

    public function toString() : String {
      var local1:String = "DailyQuestShowingCC [";
      local1 += "hasNewQuests = " + this.hasNewQuests + " ";
      local1 += "timeToNextQuest = " + this.timeToNextQuest + " ";
      return local1 + "]";
    }
  }
}
