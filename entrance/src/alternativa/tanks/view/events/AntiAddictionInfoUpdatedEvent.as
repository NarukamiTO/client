package alternativa.tanks.view.events {
  import flash.events.Event;

  public class AntiAddictionInfoUpdatedEvent extends Event {
    public static const EVENT:String = "AntiAddictionInfoUpdatedEvent.EVENT";

    public function AntiAddictionInfoUpdatedEvent() {
      super(EVENT);
    }
  }
}
