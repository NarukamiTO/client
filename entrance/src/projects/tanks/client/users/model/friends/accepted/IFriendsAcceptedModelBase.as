package projects.tanks.client.users.model.friends.accepted {
  import alternativa.types.Long;

  public interface IFriendsAcceptedModelBase {
    function onAdding(param1:Long) : void;
    function onRemoved(param1:Long) : void;
  }
}
