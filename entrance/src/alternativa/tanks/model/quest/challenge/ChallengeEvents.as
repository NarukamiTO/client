package alternativa.tanks.model.quest.challenge {
  import flash.events.Event;

  public class ChallengeEvents extends Event {
    public static const REQUEST_DATA:String = "ChallengeEvents.REQUEST_DATA";

    public function ChallengeEvents(param1:String) {
      super(param1,true);
    }
  }
}
