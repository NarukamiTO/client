package projects.tanks.clients.fp10.libraries.tanksservices.model.friends.acceptednotificator {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.users.model.friends.acceptednotificator.FriendsAcceptedNotificatorModelBase;
  import projects.tanks.client.users.model.friends.acceptednotificator.IFriendsAcceptedNotificatorModelBase;
  import projects.tanks.client.users.model.friends.container.UserContainerCC;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.NewFriendRemoveEvent;

  [ModelInfo]
  public class FriendsAcceptedNotificatorModel extends FriendsAcceptedNotificatorModelBase implements IFriendsAcceptedNotificatorModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var friendsInfoService:IFriendInfoService;

    public function FriendsAcceptedNotificatorModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:UserContainerCC = null;
      var local2:Long = null;
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        local1 = getInitParam();
        for each(local2 in local1.users) {
          logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel newFriendsAccepted userId=%1",[local2]);
          friendsInfoService.onAddNewAcceptedFriend(local2);
        }
        friendsInfoService.addEventListener(NewFriendRemoveEvent.ACCEPTED,getFunctionWrapper(this.remove));
      }
    }

    private function remove(param1:NewFriendRemoveEvent) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel remove userId=%1",[param1.userId]);
        server.remove(param1.userId);
      }
    }

    public function onAdding(param1:Long) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel onAdding userId=%1",[param1]);
        friendsInfoService.onAddNewAcceptedFriend(param1);
      }
    }

    public function onRemoved(param1:Long) : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel onRemoved userId=%1",[param1]);
        friendsInfoService.onRemoveNewAcceptedFriend(param1);
      }
    }

    public function objectUnloaded() : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        logService.getLogger("fcounter").debug("FriendsAcceptedNotificatorModel objectUnloaded");
        friendsInfoService.removeEventListener(NewFriendRemoveEvent.ACCEPTED,getFunctionWrapper(this.remove));
      }
    }
  }
}
