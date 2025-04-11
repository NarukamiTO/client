package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class SendNewPasswordAndEmailToChangeEvent extends Event {
    public static const SEND:String = "SendNewPasswordAndEmailToChangeEvent.SEND";

    public var password:String;
    public var email:String;

    public function SendNewPasswordAndEmailToChangeEvent(param1:String, param2:String) {
      this.password = param1;
      this.email = param2;
      super(SEND);
    }

    override public function clone() : Event {
      return new SendNewPasswordAndEmailToChangeEvent(this.password,this.email);
    }
  }
}
