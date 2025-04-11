package projects.tanks.client.panel.model.quest.notifier {
  public class QuestNotifierCC {
    private var _hasCompletedDailyQuests:Boolean;
    private var _hasCompletedWeeklyQuests:Boolean;
    private var _hasNewDailyQuests:Boolean;
    private var _hasNewWeeklyQuests:Boolean;
    private var _hasNotCompletedQuests:Boolean;

    public function QuestNotifierCC(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) {
      super();
      this._hasCompletedDailyQuests = param1;
      this._hasCompletedWeeklyQuests = param2;
      this._hasNewDailyQuests = param3;
      this._hasNewWeeklyQuests = param4;
      this._hasNotCompletedQuests = param5;
    }

    public function get hasCompletedDailyQuests() : Boolean {
      return this._hasCompletedDailyQuests;
    }

    public function set hasCompletedDailyQuests(param1:Boolean) : void {
      this._hasCompletedDailyQuests = param1;
    }

    public function get hasCompletedWeeklyQuests() : Boolean {
      return this._hasCompletedWeeklyQuests;
    }

    public function set hasCompletedWeeklyQuests(param1:Boolean) : void {
      this._hasCompletedWeeklyQuests = param1;
    }

    public function get hasNewDailyQuests() : Boolean {
      return this._hasNewDailyQuests;
    }

    public function set hasNewDailyQuests(param1:Boolean) : void {
      this._hasNewDailyQuests = param1;
    }

    public function get hasNewWeeklyQuests() : Boolean {
      return this._hasNewWeeklyQuests;
    }

    public function set hasNewWeeklyQuests(param1:Boolean) : void {
      this._hasNewWeeklyQuests = param1;
    }

    public function get hasNotCompletedQuests() : Boolean {
      return this._hasNotCompletedQuests;
    }

    public function set hasNotCompletedQuests(param1:Boolean) : void {
      this._hasNotCompletedQuests = param1;
    }

    public function toString() : String {
      var local1:String = "QuestNotifierCC [";
      local1 += "hasCompletedDailyQuests = " + this.hasCompletedDailyQuests + " ";
      local1 += "hasCompletedWeeklyQuests = " + this.hasCompletedWeeklyQuests + " ";
      local1 += "hasNewDailyQuests = " + this.hasNewDailyQuests + " ";
      local1 += "hasNewWeeklyQuests = " + this.hasNewWeeklyQuests + " ";
      local1 += "hasNotCompletedQuests = " + this.hasNotCompletedQuests + " ";
      return local1 + "]";
    }
  }
}
