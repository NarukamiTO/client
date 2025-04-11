package alternativa.tanks.controller.events.partners {
  import flash.events.Event;

  public class FinishPartnerRegisterEvent extends Event {
    public static const FINISH_REGISTRATION:String = "FinishPartnerRegisterEvent.FINISH_REGISTRATION";

    public var uid:String;

    public function FinishPartnerRegisterEvent(param1:String) {
      super(FINISH_REGISTRATION);
      this.uid = param1;
    }

    override public function clone() : Event {
      return new FinishPartnerRegisterEvent(this.uid);
    }
  }
}
