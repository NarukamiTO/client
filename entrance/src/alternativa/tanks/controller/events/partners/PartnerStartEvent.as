package alternativa.tanks.controller.events.partners {
  import flash.events.Event;

  public class PartnerStartEvent extends Event {
    public static const START_REGISTRATION:String = "PartnerStartEvent.START_REGISTRATION";
    public static const START_LOGIN:String = "PartnerStartEvent.START_LOGIN";

    public var rememberMe:Boolean;

    public function PartnerStartEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false) {
      this.rememberMe = param2;
      super(param1,param3,param4);
    }

    override public function clone() : Event {
      return new PartnerStartEvent(type,this.rememberMe,bubbles,cancelable);
    }
  }
}
