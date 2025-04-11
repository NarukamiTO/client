package projects.tanks.clients.fp10.libraries.tanksservices.model.friends.incomingnotificator {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.users.model.friends.container.UserContainerCC;
  import projects.tanks.client.users.model.friends.incomingnotificator.FriendsIncomingNotificatorModelBase;
  import projects.tanks.client.users.model.friends.incomingnotificator.IFriendsIncomingNotificatorModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.NewFriendRemoveEvent;

  [ModelInfo]
  public class FriendsIncomingNotificatorModel extends FriendsIncomingNotificatorModelBase implements IFriendsIncomingNotificatorModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var friendsInfoService:IFriendInfoService;

    public function FriendsIncomingNotificatorModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:UserContainerCC = null;
      var local2:Long = null;
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        local1 = getInitParam();
        for each(local2 in local1.users) {
          logService.getLogger("fcounter").debug("FriendsIncomingNotificatorModel newFriendsIncoming userId=%1",[local2]);
          friendsInfoService.onAddNewIncomingFriend(local2);
        }
        friendsInfoService.addEventListener(NewFriendRemoveEvent.INCOMING,getFunctionWrapper(this.remove));
      }
    }

    private function remove(param1:NewFriendRemoveEvent) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsIncomingNotificatorModel remove userId=%1",[param1.userId]);
        server.remove(param1.userId);
      }
    }

    public function onAdding(param1:Long) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsIncomingNotificatorModel onAdding userId=%1",[param1]);
        friendsInfoService.onAddNewIncomingFriend(param1);
      }
    }

    public function onRemoved(param1:Long) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsIncomingNotificatorModel onRemoved userId=%1",[param1]);
        friendsInfoService.onRemoveNewIncomingFriend(param1);
      }
    }

    public function objectUnloaded() : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsIncomingNotificatorModel objectUnloaded");
        friendsInfoService.removeEventListener(NewFriendRemoveEvent.INCOMING,getFunctionWrapper(this.remove));
      }
    }
  }
}
