package alternativa.tanks.models.notifier {
  import alternativa.tanks.models.user.ClanUserService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.notifier.ClanNotifierData;
  import projects.tanks.client.clans.notifier.ClanNotifierModelBase;
  import projects.tanks.client.clans.notifier.IClanNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.UserClanInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class ClanNotifierModel extends ClanNotifierModelBase implements IClanNotifierModelBase, ObjectLoadListener {
    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    public function ClanNotifierModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:ClanNotifierData = getInitParam();
      var local2:UserClanInfo = new UserClanInfo(local1);
      clanUserInfoService.updateUserClanInfo(local2);
    }

    public function sendData(param1:Vector.<ClanNotifierData>) : void {
      var local2:ClanNotifierData = null;
      var local3:UserClanInfo = null;
      for each(local2 in param1) {
        local3 = new UserClanInfo(local2);
        clanUserInfoService.updateUserClanInfo(local3);
      }
      if(userInfoService.getCurrentUserId() == local2.userId && clanUserInfoService.updateFriendsClanButtonFunction != null) {
        clanUserInfoService.updateFriendsClanButtonFunction.call(null);
      }
    }
  }
}
