package alternativa.tanks.model.item {
  import alternativa.types.Long;

  [ModelInterface]
  public interface BattleFriendsListener {
    function onAddFriend(param1:Long) : void;
    function onDeleteFriend(param1:Long) : void;
  }
}
