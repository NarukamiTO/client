package projects.tanks.clients.fp10.libraries.tanksservices.service.probattle {
  import flash.events.Event;

  public class ProBattleEvent extends Event {
    public static const OVER:String = "ProBattleEvent.ABONEMENT_OVER";

    public function ProBattleEvent(param1:String) {
      super(param1);
    }
  }
}
