package projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class BattleInviteService extends EventDispatcher implements IBattleInviteService {
    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var _receiveBattleInvite:Boolean;

    public function BattleInviteService() {
      super();
    }

    public function getAvailabilityInviteBattle(param1:Long) : Boolean {
      var local2:Boolean = lobbyLayoutService.getCurrentState() == LayoutState.BATTLE ? battleInfoService.hasCurrentBattleId() : battleInfoService.hasCurrentSelectionBattleId();
      return local2 && (friendInfoService.isFriendsInState(param1,FriendState.ACCEPTED) || Boolean(clanUserInfoService.inSameClan(param1)));
    }

    public function invite(param1:Long) : void {
      dispatchEvent(new BattleInviteServiceEvent(BattleInviteServiceEvent.INVITE,param1));
    }

    public function accept(param1:Long, param2:BattleInfoData) : void {
      var local3:BattleInviteServiceEvent = new BattleInviteServiceEvent(BattleInviteServiceEvent.ACCEPT,param1);
      local3.battleData = param2;
      dispatchEvent(local3);
    }

    public function reject(param1:Long) : void {
      dispatchEvent(new BattleInviteServiceEvent(BattleInviteServiceEvent.REJECT,param1));
    }

    public function get receiveBattleInvite() : Boolean {
      return this._receiveBattleInvite;
    }

    public function set receiveBattleInvite(param1:Boolean) : void {
      if(this._receiveBattleInvite != param1) {
        dispatchEvent(new BattleInviteEnableEvent(BattleInviteEnableEvent.UPDATE,param1));
      }
      this._receiveBattleInvite = param1;
    }

    public function removeInvite(param1:Long) : void {
      dispatchEvent(new BattleInviteServiceEvent(BattleInviteServiceEvent.REMOVE_INVITE,param1));
    }
  }
}
