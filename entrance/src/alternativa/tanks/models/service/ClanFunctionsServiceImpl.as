package alternativa.tanks.models.service {
  import alternativa.tanks.models.clan.IClanModel;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanFunctionsService;

  public class ClanFunctionsServiceImpl extends EventDispatcher implements ClanFunctionsService {
    [Inject]
    public static var clanService:ClanService;

    public function ClanFunctionsServiceImpl() {
      super();
    }

    public function invite(param1:Long) : void {
      clanService.clanPanelModel.sendInviteToClan(param1);
    }

    public function leave() : void {
      this.clanModel().leaveClan();
    }

    public function exclude(param1:Long) : void {
      this.clanModel().excludeClanMember(param1);
    }

    public function revokeRequest(param1:Long) : void {
      this.clanModel().revokeRequest(param1);
    }

    public function acceptRequest(param1:Long) : void {
      this.clanModel().acceptRequest(param1);
    }

    public function rejectRequest(param1:Long) : void {
      this.clanModel().rejectRequest(param1);
    }

    public function rejectAllRequests() : void {
      this.clanModel().rejectAllRequests();
    }

    private function clanModel() : IClanModel {
      return IClanModel(clanService.clanObject.adapt(IClanModel));
    }
  }
}
