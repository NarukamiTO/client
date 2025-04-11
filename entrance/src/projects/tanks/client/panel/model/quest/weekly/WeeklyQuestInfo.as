package projects.tanks.client.panel.model.quest.weekly {
  import projects.tanks.client.panel.model.quest.showing.QuestInfoWithLevel;

  public class WeeklyQuestInfo extends QuestInfoWithLevel {
    public function WeeklyQuestInfo() {
      super();
    }

    override public function toString() : String {
      var local1:String = "WeeklyQuestInfo [";
      local1 += super.toString();
      return local1 + "]";
    }
  }
}
