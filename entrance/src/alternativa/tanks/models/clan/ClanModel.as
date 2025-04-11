package alternativa.tanks.models.clan {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.ClanPermissionsManager;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ISearchInput;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ISourceData;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.clan.ClanModelBase;
  import projects.tanks.client.clans.clan.IClanModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  [ModelInfo]
  public class ClanModel extends ClanModelBase implements IClanModelBase, IClanModel, ISourceData, ObjectUnloadListener, ObjectLoadPostListener {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var localeService:ILocaleService;

    public static const USER_NAME_PATTERN:String = "%USERNAME%";

    private var _searchInput:ISearchInput;

    public function ClanModel() {
      super();
    }

    public function objectLoadedPost() : void {
      clanService.clanObject = object;
    }

    public function alreadyInAccepted(param1:String) : void {
      var local2:String = null;
      if(this._searchInput != null) {
        local2 = localeService.getText(TanksLocale.TEXT_CLAN_PLAYER_IS_CLAN_MAMBER);
        local2 = local2.replace(USER_NAME_PATTERN,param1);
        this._searchInput.onAlreadyInAccepted(local2);
      }
    }

    public function alreadyInClanIncoming(param1:String, param2:Long) : void {
      var local3:String = null;
      if(this._searchInput != null) {
        local3 = localeService.getText(TanksLocale.TEXT_CLAN_PLAYER_IS_REQUEST_LIST);
        local3 = local3.replace(USER_NAME_PATTERN,param1);
        this._searchInput.onAlreadyInIncoming(param2,local3);
      }
    }

    public function alreadyInClanOutgoing(param1:String) : void {
      var local2:String = null;
      if(this._searchInput != null) {
        local2 = localeService.getText(TanksLocale.TEXT_CLAN_PLAYER_IS_INVITE_LIST);
        local2 = local2.replace(USER_NAME_PATTERN,param1);
        this._searchInput.onAlreadyInOutgoing(local2);
      }
    }

    public function alreadyInClan(param1:String) : void {
      var local2:String = null;
      if(clanService.clanManagementPanel != null) {
        local2 = localeService.getText(TanksLocale.TEXT_CLAN_PLAYER_ALREADY_IN_CLAN);
        local2 = local2.replace(USER_NAME_PATTERN,param1);
        this._searchInput.onAlreadyInClan(local2);
      }
    }

    public function alreadyInUserOutgoing(param1:String, param2:Long) : void {
    }

    public function maxMembers() : void {
      clanService.maxMembers();
    }

    public function userLowRank() : void {
      var local1:String = localeService.getText(TanksLocale.TEXT_CLAN_PLAYER_RANK_TOO_LOW);
      this._searchInput.onUserLowRank(local1);
    }

    public function userExist() : void {
      if(this._searchInput != null) {
        this._searchInput.onUidExist();
      }
    }

    public function userNotExist() : void {
      if(this._searchInput != null) {
        this._searchInput.onUidNotExist();
      }
    }

    public function accept(param1:Long) : void {
      this.acceptRequest(param1);
    }

    public function addByUid(param1:String) : void {
      server.addInClanByUid(param1);
    }

    public function addClanMember(param1:Long) : void {
      server.add(param1);
    }

    public function excludeClanMember(param1:Long) : void {
      server.removeUserFromClan(param1);
    }

    public function inviteByUid(param1:String) : void {
      server.addInClanByUid(param1);
    }

    public function revokeRequest(param1:Long) : void {
      server.revoke(param1);
    }

    public function acceptRequest(param1:Long) : void {
      server.accept(param1);
    }

    public function rejectRequest(param1:Long) : void {
      server.reject(param1);
    }

    public function rejectAllRequests() : void {
      server.rejectAll();
    }

    public function checkUid(param1:String) : void {
      server.checkUid(param1);
    }

    public function leaveClan() : void {
      server.userLeavesClan();
    }

    public function objectUnloaded() : void {
      ClanPermissionsManager.removePositionListeners();
      clanService.objectUnloaded();
    }

    public function setSearchInput(param1:ISearchInput) : void {
      this._searchInput = param1;
    }
  }
}
