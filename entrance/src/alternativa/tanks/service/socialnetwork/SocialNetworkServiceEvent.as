package alternativa.tanks.service.socialnetwork {
  import flash.events.Event;

  public class SocialNetworkServiceEvent extends Event {
    public static const CREATE_LINK:String = "SocialNetworkServiceEvent.CREATE_LINK";
    public static const UNLINK:String = "SocialNetworkServiceEvent.UNLINK";
    public static const LINK_SUCCESS:String = "SocialNetworkServiceEvent.LINK_SUCCESS";
    public static const UNLINK_SUCCESS:String = "SocialNetworkServiceEvent.UNLINK_SUCCESS";

    public var socialNetworkId:String;

    public function SocialNetworkServiceEvent(param1:String, param2:String) {
      this.socialNetworkId = param2;
      super(param1);
    }
  }
}
