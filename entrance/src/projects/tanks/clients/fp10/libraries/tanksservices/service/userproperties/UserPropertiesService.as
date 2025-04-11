package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;

  public class UserPropertiesService extends EventDispatcher implements IUserPropertiesService {
    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var rankService:RankService;

    private var _userId:Long;
    private var _userName:String;
    private var _score:int;
    private var _rank:int;
    private var _userProfileUrl:String;
    private var _registrationTimestamp:int;
    private var _hasSpectatorPermissions:Boolean;
    private var _canUseGroup:Boolean;
    private var inited:Boolean;

    public function UserPropertiesService() {
      super();
    }

    public function isInited() : Boolean {
      return this.inited;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function get userName() : String {
      return this._userName;
    }

    public function set userName(param1:String) : void {
      this._userName = param1;
    }

    public function get rank() : int {
      return rankService.getNormalizedRankIndex(this._rank);
    }

    public function get fullRank() : int {
      return this._rank;
    }

    public function get score() : int {
      return this._score;
    }

    public function getUserProfileUrl(param1:String) : String {
      return this._userProfileUrl + UidUtil.userNameWithoutClanTag(param1) + (!!partnerService.hasRatings() ? "?partners=1" : "");
    }

    public function get registrationTimestamp() : int {
      return this._registrationTimestamp;
    }

    public function updateRank(param1:int) : void {
      this._rank = param1;
      dispatchEvent(new UserPropertiesServiceEvent(UserPropertiesServiceEvent.UPDATE_RANK,new UserProperties(this._userId,this._userName,this._score,this._rank)));
    }

    public function updateCanUseGroup(param1:Boolean) : void {
      this._canUseGroup = param1;
    }

    public function updateScore(param1:int) : void {
      this._score = param1;
      dispatchEvent(new UserPropertiesServiceEvent(UserPropertiesServiceEvent.UPDATE_SCORE,new UserProperties(this._userId,this._userName,this._score,this._rank)));
    }

    public function init(param1:Long, param2:String, param3:int, param4:int, param5:String, param6:int, param7:Boolean, param8:Boolean) : void {
      this._userId = param1;
      this._userName = param2;
      this._score = param3;
      this._rank = param4;
      this._userProfileUrl = param5;
      this._registrationTimestamp = param6;
      this._hasSpectatorPermissions = param7;
      this._canUseGroup = param8;
      this.inited = true;
      dispatchEvent(new UserPropertiesServiceEvent(UserPropertiesServiceEvent.ON_INIT_USER_PROPERTIES));
    }

    public function initRank(param1:int) : void {
      this._rank = param1;
    }

    public function hasSpectatorPermissions() : Boolean {
      return this._hasSpectatorPermissions;
    }

    public function canUseGroup() : Boolean {
      return this._canUseGroup;
    }

    public function isQuestsAvailableByRank() : Boolean {
      return this._rank >= 0;
    }
  }
}
