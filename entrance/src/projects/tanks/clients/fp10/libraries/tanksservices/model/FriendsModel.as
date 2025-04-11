package projects.tanks.clients.fp10.libraries.tanksservices.model {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.users.model.friends.FriendsModelBase;
  import projects.tanks.client.users.model.friends.IFriendsModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendActionServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendActionServiceUidEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;

  [ModelInfo]
  public class FriendsModel extends FriendsModelBase implements IFriendsModelBase, ObjectLoadListener, ObjectUnloadListener, IFriends {
    [Inject]
    public static var friendsActionService:IFriendActionService;

    public function FriendsModel() {
      super();
    }

    public function objectLoaded() : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        friendsActionService.addEventListener(FriendActionServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
        friendsActionService.addEventListener(FriendActionServiceEvent.ADD,getFunctionWrapper(this.onAdd));
        friendsActionService.addEventListener(FriendActionServiceUidEvent.ADD,getFunctionWrapper(this.onAddByUid));
        friendsActionService.addEventListener(FriendActionServiceEvent.BREAK_OFF,getFunctionWrapper(this.onBreakItOff));
        friendsActionService.addEventListener(FriendActionServiceEvent.REJECT,getFunctionWrapper(this.onReject));
        friendsActionService.addEventListener(FriendActionServiceEvent.REJECT_ALL_INCOMING,getFunctionWrapper(this.onRejectAllIncoming));
      }
    }

    private function onAccept(param1:FriendActionServiceEvent) : void {
      server.accept(param1.userId);
    }

    private function onAddByUid(param1:FriendActionServiceUidEvent) : void {
      server.addByUid(param1.uid);
    }

    private function onAdd(param1:FriendActionServiceEvent) : void {
      server.add(param1.userId);
    }

    private function onBreakItOff(param1:FriendActionServiceEvent) : void {
      server.breakItOff(param1.userId);
    }

    private function onReject(param1:FriendActionServiceEvent) : void {
      server.reject(param1.userId);
    }

    private function onRejectAllIncoming(param1:FriendActionServiceEvent) : void {
      server.rejectAll();
    }

    public function objectUnloaded() : void {
      if(IFriends(object.adapt(IFriends)).isLocal()) {
        friendsActionService.removeEventListener(FriendActionServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
        friendsActionService.removeEventListener(FriendActionServiceEvent.ADD,getFunctionWrapper(this.onAdd));
        friendsActionService.removeEventListener(FriendActionServiceUidEvent.ADD,getFunctionWrapper(this.onAddByUid));
        friendsActionService.removeEventListener(FriendActionServiceEvent.BREAK_OFF,getFunctionWrapper(this.onBreakItOff));
        friendsActionService.removeEventListener(FriendActionServiceEvent.REJECT,getFunctionWrapper(this.onReject));
        friendsActionService.removeEventListener(FriendActionServiceEvent.REJECT_ALL_INCOMING,getFunctionWrapper(this.onRejectAllIncoming));
      }
    }

    public function isLocal() : Boolean {
      return getInitParam().local;
    }

    public function alreadyInAcceptedFriends(param1:String) : void {
      friendsActionService.alreadyInAcceptedFriends(param1);
    }

    public function alreadyInIncomingFriends(param1:String, param2:Long) : void {
      friendsActionService.alreadyInIncomingFriends(param1,param2);
    }

    public function alreadyInOutgoingFriends(param1:String) : void {
      friendsActionService.alreadyInOutgoingFriends(param1);
    }

    public function yourAcceptedLimitExceeded() : void {
      friendsActionService.yourAcceptedLimitExceeded();
    }

    public function acceptedLimitExceeded(param1:String) : void {
      friendsActionService.acceptedLimitExceeded(param1);
    }

    public function incomingLimitExceeded() : void {
      friendsActionService.incomingLimitExceeded();
    }

    public function acceptSuccess(param1:Long) : void {
      friendsActionService.requestAccepted(param1);
    }
  }
}
