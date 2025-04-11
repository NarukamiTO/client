package projects.tanks.clients.fp10.libraries.tanksservices.service.blur {
  import flash.events.Event;

  public class BlurServiceEvent extends Event {
    public static const CLICK_OVERLAY_BATTLE_CONTENT:String = "BlurServiceEvent.CLICK_OVERLAY_BATTLE_CONTENT";

    public function BlurServiceEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
