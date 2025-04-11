package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class SetPasswordChangeResultEvent extends Event {
    public static const SET:String = "SetPasswordChangeResultEvent.SET";

    public var error:String;
    public var success:Boolean;

    public function SetPasswordChangeResultEvent(param1:Boolean, param2:String) {
      this.success = param1;
      this.error = param2;
      super(SET);
    }
  }
}
