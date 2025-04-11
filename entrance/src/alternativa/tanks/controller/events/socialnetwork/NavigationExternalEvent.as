package alternativa.tanks.controller.events.socialnetwork {
  import flash.events.Event;

  public class NavigationExternalEvent extends Event {
    public static const GO_TO_EXTERNAL_REGISTRATION_FORM:String = "NavigationExternalEvent.GO_TO_EXTERNAL_REGISTRATION_FORM";
    public static const GO_TO_EXTERNAL_LOGIN_FORM:String = "NavigationExternalEvent.GO_TO_EXTERNAL_LOGIN_FORM";

    public var socialNetworkId:String;

    public function NavigationExternalEvent(param1:String, param2:String) {
      this.socialNetworkId = param2;
      super(param1);
    }

    override public function clone() : Event {
      return new NavigationExternalEvent(type,this.socialNetworkId);
    }
  }
}
