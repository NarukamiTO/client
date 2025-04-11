package projects.tanks.client.users.model.friends.incoming {
  import alternativa.types.Long;

  public interface IFriendsIncomingModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
