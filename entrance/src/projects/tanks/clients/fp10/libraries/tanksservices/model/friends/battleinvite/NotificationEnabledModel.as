package projects.tanks.clients.fp10.libraries.tanksservices.model.friends.battleinvite {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.users.model.switchbattleinvite.INotificationEnabledModelBase;
  import projects.tanks.client.users.model.switchbattleinvite.NotificationEnabledModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.BattleInviteEnableEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;

  [ModelInfo]
  public class NotificationEnabledModel extends NotificationEnabledModelBase implements INotificationEnabledModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var battleInviteService:IBattleInviteService;

    public function NotificationEnabledModel() {
      super();
    }

    public function objectLoaded() : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        battleInviteService.receiveBattleInvite = getInitParam().receiveBattleInvite;
        battleInviteService.addEventListener(BattleInviteEnableEvent.UPDATE,getFunctionWrapper(this.onUpdateBattleInviteEnable));
      }
    }

    private function onUpdateBattleInviteEnable(param1:BattleInviteEnableEvent) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        server.enable(param1.enable);
      }
    }

    public function objectUnloaded() : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        battleInviteService.removeEventListener(BattleInviteEnableEvent.UPDATE,getFunctionWrapper(this.onUpdateBattleInviteEnable));
      }
    }
  }
}
