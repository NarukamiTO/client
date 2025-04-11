package alternativa.tanks.models.foreignclan {
  import alternativa.tanks.models.panel.create.ClanCreateService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.panel.foreignclan.ForeignClanData;
  import projects.tanks.client.clans.panel.foreignclan.ForeignClanModelBase;
  import projects.tanks.client.clans.panel.foreignclan.IForeignClanModelBase;

  [ModelInfo]
  public class ForeignClanModel extends ForeignClanModelBase implements IForeignClanModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var foreignClanService:ForeignClanService;

    [Inject]
    public static var createClanService:ClanCreateService;

    public function ForeignClanModel() {
      super();
    }

    public function objectLoaded() : void {
      createClanService.flags = getInitParam().flags;
      foreignClanService.addEventListener(ForeignClanEvent.SEND_REQUEST,getFunctionWrapper(this.onSendRequest));
      foreignClanService.addEventListener(ForeignClanEvent.ACCEPT_REQUEST,getFunctionWrapper(this.onAcceptRequest));
      foreignClanService.addEventListener(ForeignClanEvent.REVOKE_REQUEST,getFunctionWrapper(this.onRevokeRequest));
    }

    private function onSendRequest(param1:ForeignClanEvent) : void {
      server.sendRequest();
    }

    private function onAcceptRequest(param1:ForeignClanEvent) : void {
      server.acceptRequest();
    }

    private function onRevokeRequest(param1:ForeignClanEvent) : void {
      server.revokeRequest();
    }

    public function showForeignClan(param1:ForeignClanData) : void {
      foreignClanService.showForeignClan(param1);
    }

    public function userSmallRankForAddClan() : void {
      foreignClanService.userSmallRankForAddClan();
    }

    public function onJoinClan(param1:String) : void {
      foreignClanService.onJoinClan(param1);
    }

    public function alreadyInClanOutgoing(param1:String) : void {
      foreignClanService.alreadyInClanOutgoing();
    }

    public function alreadyInIncoming(param1:String) : void {
      foreignClanService.alreadyInIncoming();
    }

    public function clanBlocked(param1:String) : void {
      foreignClanService.clanBlocked(param1);
    }

    public function objectUnloaded() : void {
      foreignClanService.removeEventListener(ForeignClanEvent.SEND_REQUEST,getFunctionWrapper(this.onSendRequest));
      foreignClanService.removeEventListener(ForeignClanEvent.ACCEPT_REQUEST,getFunctionWrapper(this.onAcceptRequest));
      foreignClanService.removeEventListener(ForeignClanEvent.REVOKE_REQUEST,getFunctionWrapper(this.onRevokeRequest));
    }
  }
}
