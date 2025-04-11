package alternativa.tanks.model.quest.common.gui.window.events {
  import alternativa.types.Long;
  import flash.events.Event;

  public class QuestGetPrizeEvent extends Event {
    public static const GET_QUEST_PRIZE:String = "QuestGetPrize";

    public var questId:Long;

    public function QuestGetPrizeEvent(param1:String, param2:Long) {
      super(param1,true);
      this.questId = param2;
    }
  }
}
