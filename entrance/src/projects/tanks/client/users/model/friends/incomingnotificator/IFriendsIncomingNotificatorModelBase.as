package projects.tanks.client.users.model.friends.incomingnotificator {
  import alternativa.types.Long;

  public interface IFriendsIncomingNotificatorModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
