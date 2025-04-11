package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties {
  import flash.events.Event;

  public class UserPropertiesServiceEvent extends Event {
    public static const UPDATE_RANK:String = "UserPropertiesServiceEvent.UPDATE_RANK";
    public static const UPDATE_SCORE:String = "UserPropertiesServiceEvent.UPDATE_SCORE";
    public static const ON_INIT_USER_PROPERTIES:String = "UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES";

    public var userProperties:UserProperties;

    public function UserPropertiesServiceEvent(param1:String, param2:UserProperties = null) {
      super(param1);
      this.userProperties = param2;
    }
  }
}
