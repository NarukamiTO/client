package projects.tanks.client.panel.model.quest.showing {
  import projects.tanks.client.panel.model.quest.common.specification.QuestLevel;

  public class QuestInfoWithLevel extends CommonQuestInfo {
    private var _level:QuestLevel;

    public function QuestInfoWithLevel(param1:QuestLevel = null) {
      super();
      this._level = param1;
    }

    public function get level() : QuestLevel {
      return this._level;
    }

    public function set level(param1:QuestLevel) : void {
      this._level = param1;
    }

    override public function toString() : String {
      var local1:String = "QuestInfoWithLevel [";
      local1 += "level = " + this.level + " ";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
