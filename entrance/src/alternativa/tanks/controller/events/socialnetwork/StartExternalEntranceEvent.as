package alternativa.tanks.controller.events.socialnetwork {
  import flash.events.Event;

  public class StartExternalEntranceEvent extends Event {
    public static const START_REGISTRATION:String = "StartExternalEntranceEvent.START_REGISTRATION";
    public static const START_LOGIN:String = "StartExternalEntranceEvent.START_LOGIN";

    public var rememberMe:Boolean;
    public var socialNetworkId:String;

    public function StartExternalEntranceEvent(param1:String, param2:String, param3:Boolean) {
      this.socialNetworkId = param2;
      this.rememberMe = param3;
      super(param1);
    }

    override public function clone() : Event {
      return new StartExternalEntranceEvent(type,this.socialNetworkId,this.rememberMe);
    }
  }
}
