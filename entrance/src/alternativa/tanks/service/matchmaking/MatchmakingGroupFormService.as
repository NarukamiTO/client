package alternativa.tanks.service.matchmaking {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;

  public interface MatchmakingGroupFormService extends IEventDispatcher {
    function showGroupView(param1:Vector.<MatchmakingUserData>, param2:Boolean) : void;
    function hideGroupView() : void;
    function addUserToGroup(param1:MatchmakingUserData) : void;
    function removeUserFromGroup(param1:Long) : void;
    function showUserReady(param1:Long) : void;
    function showUserNotReady(param1:Long) : void;
    function updateMountedItem(param1:MountItemsUserData) : void;
  }
}
