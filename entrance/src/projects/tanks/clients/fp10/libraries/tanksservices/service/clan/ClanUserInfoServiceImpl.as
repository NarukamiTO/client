package projects.tanks.clients.fp10.libraries.tanksservices.service.clan {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class ClanUserInfoServiceImpl extends EventDispatcher implements ClanUserInfoService {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var userClanInfos:Dictionary = new Dictionary();
    private var updateClanButtonFunction:Function;
    private var _actions:Vector.<ClanAction>;
    private var _restrictionTime:int;
    private var _selfClan:Boolean;
    private var _clanMember:Boolean;
    private var _initRestrictionTimer:int;
    private var _giveBonusesClan:Boolean;

    public function ClanUserInfoServiceImpl() {
      super();
    }

    public function updateUserClanInfo(param1:UserClanInfo) : void {
      this.userClanInfos[param1.userId] = param1;
    }

    public function userClanInfoByUserId(param1:Long) : UserClanInfo {
      return param1 in this.userClanInfos ? this.userClanInfos[param1] : null;
    }

    public function get updateFriendsClanButtonFunction() : Function {
      return this.updateClanButtonFunction;
    }

    public function set updateFriendsClanButtonFunction(param1:Function) : void {
      this.updateClanButtonFunction = param1;
    }

    public function hasAction(param1:ClanAction) : Boolean {
      var local2:ClanAction = null;
      for each(local2 in this.actions) {
        if(local2.value == param1.value) {
          return true;
        }
      }
      return false;
    }

    public function get actions() : Vector.<ClanAction> {
      return this._actions;
    }

    public function set actions(param1:Vector.<ClanAction>) : void {
      this._actions = param1;
    }

    public function inSameClan(param1:Long) : Boolean {
      var local4:Long = null;
      var local5:Long = null;
      var local2:UserClanInfo = this.userClanInfoByUserId(param1);
      var local3:UserClanInfo = this.userClanInfoByUserId(userPropertiesService.userId);
      if(!local3.isInClan) {
        return false;
      }
      if(local2 != null && local3 != null) {
        local4 = local2.clanId;
        local5 = local3.clanId;
        return local4 == local5;
      }
      return false;
    }

    public function get restrictionTime() : int {
      return this._restrictionTime - (getTimer() - this._initRestrictionTimer) / 1000;
    }

    public function set restrictionTime(param1:int) : void {
      this._restrictionTime = param1;
      this._initRestrictionTimer = getTimer();
      if(this._restrictionTime > 0) {
        setTimeout(this.scheduleRestrictionTime,this._restrictionTime * 1000);
      }
    }

    private function scheduleRestrictionTime() : void {
      dispatchEvent(new RestrictionJoinClanEvent(RestrictionJoinClanEvent.UPDATE));
    }

    public function get selfClan() : Boolean {
      return this._selfClan;
    }

    public function set selfClan(param1:Boolean) : void {
      this._selfClan = param1;
    }

    public function get clanMember() : Boolean {
      return this._clanMember;
    }

    public function set clanMember(param1:Boolean) : void {
      this._clanMember = param1;
    }

    public function get giveBonusesClan() : Boolean {
      return this._giveBonusesClan;
    }

    public function set giveBonusesClan(param1:Boolean) : void {
      this._giveBonusesClan = param1;
      dispatchEvent(new ClanUserInfoEvent(ClanUserInfoEvent.UPDATE_GIVE_BONUSES_CLAN));
    }

    public function onLeaveClan() : void {
      dispatchEvent(new ClanUserInfoEvent(ClanUserInfoEvent.ON_LEAVE_CLAN));
    }

    public function onJoinClan() : void {
      dispatchEvent(new ClanUserInfoEvent(ClanUserInfoEvent.ON_JOIN_CLAN));
    }
  }
}
