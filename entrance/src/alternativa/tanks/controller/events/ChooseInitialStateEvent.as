package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class ChooseInitialStateEvent extends Event {
    public static const CHOOSE_INITIAL_STATE:String = "CHOOSE_INITIAL_STATE";

    public function ChooseInitialStateEvent() {
      super(CHOOSE_INITIAL_STATE);
    }
  }
}
