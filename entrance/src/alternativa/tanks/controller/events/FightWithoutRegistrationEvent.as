package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class FightWithoutRegistrationEvent extends Event {
    public static const FIGHT_WITHOUT_REGISTRATION:String = "FIGHT_WITHOUT_REGISTRATION";

    public function FightWithoutRegistrationEvent() {
      super(FIGHT_WITHOUT_REGISTRATION);
    }

    override public function clone() : Event {
      return new FightWithoutRegistrationEvent();
    }
  }
}
