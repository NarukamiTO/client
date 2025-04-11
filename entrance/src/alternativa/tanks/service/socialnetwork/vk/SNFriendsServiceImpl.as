package alternativa.tanks.service.socialnetwork.vk {
  import flash.events.EventDispatcher;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;

  public class SNFriendsServiceImpl extends EventDispatcher implements SNFriendsService {
    [Inject]
    public static var partnerService:IPartnerService;

    public function SNFriendsServiceImpl() {
      super();
    }

    public function requestFriends() : void {
      if(!partnerService.isRunningInsidePartnerEnvironment()) {
        return;
      }
      this.requestFriend();
    }

    private function requestFriend() : void {
      if(ExternalInterface.available) {
        Security.allowDomain("*");
        ExternalInterface.addCallback("onReceiveFriendsList",this.onReceiveFriendsList);
        ExternalInterface.call("getFriendsInApp");
      }
    }

    private function onReceiveFriendsList(param1:String) : void {
      dispatchEvent(new SNFriendsServiceEvent(new SNFriendsServiceData(param1)));
    }
  }
}
