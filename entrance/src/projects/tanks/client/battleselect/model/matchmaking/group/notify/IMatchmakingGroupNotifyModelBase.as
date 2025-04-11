package projects.tanks.client.battleselect.model.matchmaking.group.notify {
  import alternativa.types.Long;

  public interface IMatchmakingGroupNotifyModelBase {
    function addUser(param1:MatchmakingUserData) : void;
    function removeUser(param1:Long) : void;
    function userMountedItem(param1:MountItemsUserData) : void;
    function userNotReady(param1:Long) : void;
    function userReady(param1:Long) : void;
  }
}
