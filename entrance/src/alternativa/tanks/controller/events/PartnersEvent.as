package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class PartnersEvent extends Event {
    public static const START_REGISTRATION:String = "PartnersEvent.START_REGISTRATION";
    public static const START_LOGIN:String = "PartnersEvent.START_LOGIN";

    public function PartnersEvent(param1:String) {
      super(param1);
    }

    override public function clone() : Event {
      return new PartnersEvent(this.type);
    }
  }
}
