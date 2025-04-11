package alternativa.tanks.service.socialnetwork.vk {
  import flash.events.Event;

  public class SNFriendsServiceEvent extends Event {
    public static const GET_FRIENDS_COMPLETED:String = "SNFriendsServiceEvent.GET_FRIENDS_COMPLETED";

    private var result:SNFriendsServiceData;

    public function SNFriendsServiceEvent(param1:SNFriendsServiceData) {
      this.result = param1;
      super(GET_FRIENDS_COMPLETED);
    }

    public function getResult() : SNFriendsServiceData {
      return this.result;
    }
  }
}
