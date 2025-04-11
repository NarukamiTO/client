package alternativa.tanks.models.user {
  import alternativa.tanks.models.clan.info.IClanInfoModel;
  import alternativa.tanks.models.user.incoming.IClanUserIncomingModel;
  import alternativa.tanks.models.user.outgoing.IClanUserOutgoingModel;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class ClanUserServiceImpl extends EventDispatcher implements ClanUserService {
    private var _userObject:IGameObject;
    private var _hasClanLicense:Boolean;
    private var _licenseGarageObject:IGameObject;
    private var _otherClan:Boolean;
    private var _showBuyLicenseButton:Boolean;

    public function ClanUserServiceImpl() {
      super();
    }

    public function get userObject() : IGameObject {
      return this._userObject;
    }

    public function set userObject(param1:IGameObject) : void {
      this._userObject = param1;
    }

    public function getObjectById(param1:Long) : IGameObject {
      return this.userObject.space.getObject(param1);
    }

    public function get hasClanLicense() : Boolean {
      return this._hasClanLicense;
    }

    public function set hasClanLicense(param1:Boolean) : void {
      this._hasClanLicense = param1;
    }

    public function get licenseGarageObject() : IGameObject {
      return this._licenseGarageObject;
    }

    public function set licenseGarageObject(param1:IGameObject) : void {
      this._licenseGarageObject = param1;
    }

    public function get otherClan() : Boolean {
      return this._otherClan;
    }

    public function set otherClan(param1:Boolean) : void {
      this._otherClan = param1;
    }

    public function get showBuyLicenseButton() : Boolean {
      return this._showBuyLicenseButton;
    }

    public function set showBuyLicenseButton(param1:Boolean) : void {
      this._showBuyLicenseButton = param1;
    }

    public function containsClanInOutgoing(param1:String) : Boolean {
      var local2:Vector.<Long> = IClanUserOutgoingModel(this._userObject.adapt(IClanUserOutgoingModel)).getOutgoingClans();
      return this.containsClan(local2,param1);
    }

    public function getIncomingClanNames(param1:String) : Boolean {
      var local2:Vector.<Long> = IClanUserIncomingModel(this._userObject.adapt(IClanUserIncomingModel)).getIncomingClans();
      return this.containsClan(local2,param1);
    }

    private function containsClan(param1:Vector.<Long>, param2:String) : Boolean {
      var local4:Long = null;
      var local5:String = null;
      var local3:ISpace = this._userObject.space;
      for each(local4 in param1) {
        local5 = IClanInfoModel(local3.getObject(local4).adapt(IClanInfoModel)).getClanName();
        if(param2 == local5) {
          return true;
        }
      }
      return false;
    }

    public function hideNotInClanPanel() : void {
      dispatchEvent(new ClanUserServiceEvent(ClanUserServiceEvent.HIDE_CLAN_WINDOW));
    }
  }
}
