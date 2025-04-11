package alternativa.tanks.model.quest.daily {
  import flash.events.Event;

  public class DailyQuestEvent extends Event {
    public static const REQUEST_DATA:String = "DailyQuestEvent.REQUEST_DATA";

    public function DailyQuestEvent(param1:String) {
      super(param1,true);
    }
  }
}
