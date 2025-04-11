package alternativa.tanks.service.battle {
  import alternativa.tanks.model.item.BattleFriendsListener;
  import alternativa.types.Long;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendStateChangeEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;

  public class BattleFriendNotifier {
    [Inject]
    public static var friendsInfoService:IFriendInfoService;

    [Inject]
    public static var battleUserInfoService:IBattleUserInfoService;

    public function BattleFriendNotifier() {
      super();
      friendsInfoService.addEventListener(FriendStateChangeEvent.CHANGE,this.onChangeFriendState);
    }

    public function destroy() : void {
      friendsInfoService.removeEventListener(FriendStateChangeEvent.CHANGE,this.onChangeFriendState);
    }

    private function onChangeFriendState(param1:FriendStateChangeEvent) : void {
      var local5:BattleFriendsListener = null;
      var local2:Long = param1.userId;
      var local3:FriendState = param1.state;
      var local4:FriendState = param1.prevState;
      if(battleUserInfoService.userInBattle(local2)) {
        local5 = BattleFriendsListener(battleUserInfoService.getBattle(local2).adapt(BattleFriendsListener));
        if(local3 == FriendState.ACCEPTED) {
          local5.onAddFriend(local2);
        }
        if(local3 == FriendState.UNKNOWN && local4 == FriendState.ACCEPTED) {
          local5.onDeleteFriend(local2);
        }
      }
    }
  }
}
