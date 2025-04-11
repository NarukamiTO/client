package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class AuthorizationFailedEvent extends Event {
    public static const PASSWORD_AUTHORIZATION_FAILED:String = "AuthorizationFailedEvent.PASSWORD_AUTHORIZATION_FAILED";
    public static const HASH_AUTHORIZATION_FAILED:String = "AuthorizationFailedEvent.HASH_AUTHORIZATION_FAILED";
    public static const PASSWORD_EXTERNAL_AUTHORIZATION_FAILED:String = "AuthorizationFailedEvent.PASSWORD_EXTERNAL_AUTHORIZATION_FAILED";
    public static const EXTERNAL_LINK_ALREADY_EXISTS:String = "AuthorizationFailedEvent.EXTERNAL_LINK_ALREADY_EXISTS";
    public static const EXTERNAL_VALIDATION_FAILED:String = "AuthorizationFailedEvent.EXTERNAL_VALIDATION_FAILED";
    public static const PARTNER_PASSWORD_AUTHORIZATION_FAILED:String = "AuthorizationFailedEvent.PARTNER_PASSWORD_AUTHORIZATION_FAILED";
    public static const PARTNER_LINK_ALREADY_EXISTS:String = "AuthorizationFailedEvent.PARTNER_LINK_ALREADY_EXISTS";

    public function AuthorizationFailedEvent(param1:String) {
      super(param1);
    }

    override public function clone() : Event {
      return new AuthorizationFailedEvent(type);
    }
  }
}
