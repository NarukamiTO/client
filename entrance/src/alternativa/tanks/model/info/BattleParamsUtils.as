package alternativa.tanks.model.info {
  import alternativa.tanks.model.info.param.BattleParams;
  import alternativa.tanks.model.map.mapinfo.IMapInfo;
  import alternativa.tanks.service.battle.IBattleUserInfoService;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.types.Long;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;

  public class BattleParamsUtils {
    [Inject]
    public static var serverNameService:ServerNumberToLocaleServerService;

    [Inject]
    public static var battleUserInfoService:IBattleUserInfoService;

    [Inject]
    public static var friendsInfoService:IFriendInfoService;

    public function BattleParamsUtils() {
      super();
    }

    public static function setBattleInfoParams(param1:IGameObject, param2:BattleInfoBaseParams) : void {
      var local3:BattleInfoCC = IBattleInfo(param1.adapt(IBattleInfo)).getConstructor();
      var local4:BattleParamInfoCC = BattleParams(param1.adapt(BattleParams)).getConstructor();
      var local5:BattleCreateParameters = local4.params;
      param2.battle = Model.object;
      param2.createParams = local5;
      param2.mapName = IMapInfo(local4.map.adapt(IMapInfo)).getName();
      param2.customName = local4.params.name;
      param2.matchmakingMark = IMapInfo(local4.map.adapt(IMapInfo)).hasMatchmakingMark();
      param2.previewResource = IBattleInfo(param1.adapt(IBattleInfo)).getPreviewResource();
      param2.battleUrl = getBattleUrl(param2.battle.id);
      param2.endTime = getTimer() + local3.timeLeftInSec * 1000;
      param2.roundStarted = local3.roundStarted;
      param2.suspicionLevel = local3.suspicionLevel;
    }

    private static function getBattleUrl(param1:Long) : String {
      var local2:String = "battle=" + BattleInfoUtils.getBattleIdUhex(param1);
      var local3:String = BattleInfoUtils.getBattleBaseUrl();
      return (local3 + "#/" + local2).replace(/((.+)(\?.*)(#.*))/gi,"$2$4");
    }

    public static function registerUsers(param1:IGameObject, param2:Vector.<BattleInfoUser>, param3:BattleInfoBaseParams) : void {
      var local4:BattleInfoUser = null;
      for each(local4 in param2) {
        registerUser(local4,param3,param1);
      }
    }

    public static function registerUser(param1:BattleInfoUser, param2:BattleInfoBaseParams, param3:IGameObject) : void {
      var local4:Long = param1.user;
      param2.userToInfo.put(param1);
      battleUserInfoService.connect(local4,param3);
      if(friendsInfoService.isFriendsInState(local4,FriendState.ACCEPTED)) {
        ++param2.friends;
      }
    }

    public static function unregisterUser(param1:Long, param2:BattleInfoBaseParams) : void {
      param2.userToInfo.remove(param1);
      battleUserInfoService.disconnect(param1);
      if(friendsInfoService.isFriendsInState(param1,FriendState.ACCEPTED)) {
        --param2.friends;
      }
    }
  }
}
