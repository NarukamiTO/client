package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import flash.events.IEventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;

  public interface IFriendsInfoLabelUpdater extends IEventDispatcher {
    function get state() : FriendState;
    function incrementVisibleLabelsCounter() : void;
    function decrementVisibleLabelsCounter() : void;
    function updateLastAccessTime() : void;
  }
}
