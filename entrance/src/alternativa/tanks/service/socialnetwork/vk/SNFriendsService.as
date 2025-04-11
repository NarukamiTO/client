package alternativa.tanks.service.socialnetwork.vk {
  import flash.events.IEventDispatcher;

  public interface SNFriendsService extends IEventDispatcher {
    function requestFriends() : void;
  }
}
