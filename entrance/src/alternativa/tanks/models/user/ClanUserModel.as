package alternativa.tanks.models.user {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ISearchInput;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ISourceData;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.user.ClanUserModelBase;
  import projects.tanks.client.clans.user.IClanUserModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class ClanUserModel extends ClanUserModelBase implements IClanUserModelBase, IClanUserModel, ObjectLoadListener, ObjectLoadPostListener, ISourceData {
    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const CLAN_NAME_PATTERN:String = "%CLANNAME%";

    private var _searchInput:ISearchInput;

    public function ClanUserModel() {
      super();
    }

    public function objectLoaded() : void {
      if(!getInitParam().loadingInServiceSpace) {
        return;
      }
      clanUserService.userObject = object;
      clanUserInfoService.restrictionTime = getInitParam().restrictionTimeJoinClanInSec;
      clanUserInfoService.clanMember = getInitParam().clan;
      clanUserInfoService.giveBonusesClan = getInitParam().giveBonusesClan;
      clanUserService.otherClan = getInitParam().showOtherClan;
      clanUserService.showBuyLicenseButton = getInitParam().showBuyLicenseButton;
    }

    public function loadingInServiceSpace() : Boolean {
      return getInitParam().loadingInServiceSpace;
    }

    public function objectLoadedPost() : void {
      clanUserInfoService.selfClan = !getInitParam().showOtherClan;
      if(!getInitParam().loadingInServiceSpace) {
        return;
      }
    }

    public function leftClan(param1:int) : void {
      clanUserInfoService.clanMember = false;
      if(clanService.clanManagementPanel != null) {
        clanService.clanManagementPanel.destroy();
      }
      clanUserInfoService.restrictionTime = param1;
    }

    public function alreadyInAccepted(param1:String) : void {
    }

    public function rejectAll() : void {
      server.rejectAll();
    }

    public function revoke(param1:IGameObject) : void {
      server.revoke(param1);
    }

    public function reject(param1:IGameObject) : void {
      server.reject(param1);
    }

    public function addInClan(param1:IGameObject) : void {
      server.add(param1);
    }

    public function acceptRequest(param1:IGameObject) : void {
      server.accept(param1);
    }

    public function accept(param1:Long) : void {
      var local2:IGameObject = object.space.getObject(param1);
      server.accept(local2);
    }

    public function addByUid(param1:String) : void {
      server.addInClanByName(param1);
    }

    public function checkUid(param1:String) : void {
      server.checkClanName(param1);
    }

    public function setSearchInput(param1:ISearchInput) : void {
      this._searchInput = param1;
    }

    public function clanExist() : void {
      this._searchInput.onUidExist();
    }

    public function clanNotExist() : void {
      this._searchInput.onUidNotExist();
    }

    public function userLowRank() : void {
      var local1:String = localeService.getText(TanksLocale.TEXT_CLAN_YOUR_RANK_TOO_LOW);
      this._searchInput.onUserLowRank(local1);
    }

    public function clanBlocked() : void {
      var local1:String = localeService.getText(TanksLocale.TEXT_CLAN_BLOCK);
      this._searchInput.clanBlocked(local1);
    }

    public function clanIncomingRequestDisabled() : void {
      var local1:String = localeService.getText(TanksLocale.TEXT_CLAN_DOES_NOT_ACDEPT_REQUEST);
      this._searchInput.incomingRequestDisabled(local1);
    }

    public function alreadyInIncoming(param1:String, param2:IGameObject) : void {
      var local3:String = localeService.getText(TanksLocale.TEXT_CLAN_IS_ALREADY_IN_INVITE_LIST);
      local3 = local3.replace(CLAN_NAME_PATTERN,param1);
      this._searchInput.onAlreadyInIncoming(param2.id,local3);
    }

    public function alreadyInOutgoing(param1:String) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_CLAN_IS_ALREADY_IN_REQUEST_LIST);
      local2 = local2.replace(CLAN_NAME_PATTERN,param1);
      this._searchInput.onAlreadyInOutgoing(local2);
    }

    public function acceptedIntoClan(param1:IGameObject) : void {
    }

    public function creatorLeaveOfClanIfEmptyClan() : void {
    }

    public function alreadyInClan() : void {
      var local1:String = localeService.getText(TanksLocale.TEXT_CLAN_YOU_ALREADY_IN_CLAN);
      this._searchInput.onAlreadyInClan(local1);
    }

    public function alreadyInClanOutgoing(param1:String, param2:IGameObject) : void {
      var local3:String = localeService.getText(TanksLocale.TEXT_CLAN_IS_ALREADY_IN_REQUEST_LIST);
      local3 = local3.replace(CLAN_NAME_PATTERN,param1);
      this._searchInput.onAlreadyInOutgoing(local3);
    }

    public function joinClan() : void {
      if(clanService.notInClanPanel != null) {
        clanService.notInClanPanel.destroy();
      }
      clanUserInfoService.clanMember = true;
    }

    public function removeClanBonuses() : void {
      clanUserInfoService.giveBonusesClan = false;
    }

    public function updateStatusBonusesClan(param1:Boolean) : void {
      clanUserInfoService.giveBonusesClan = param1;
    }

    public function showAlertFullClan() : void {
      clanService.notInClanPanel.showAlertFullClan();
    }
  }
}
