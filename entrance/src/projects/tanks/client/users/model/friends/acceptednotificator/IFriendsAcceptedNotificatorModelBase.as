package projects.tanks.client.users.model.friends.acceptednotificator {
  import alternativa.types.Long;

  public interface IFriendsAcceptedNotificatorModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
