package alternativa.tanks.model.quest.weekly {
  import flash.events.Event;

  public class WeeklyQuestEvent extends Event {
    public static const REQUEST_DATA:String = "WeeklyQuestEvent.REQUEST_DATA";

    public function WeeklyQuestEvent(param1:String) {
      super(param1,true);
    }
  }
}
