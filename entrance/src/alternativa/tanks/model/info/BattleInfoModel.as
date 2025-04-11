package alternativa.tanks.model.info {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.model.info.param.BattleParams;
  import alternativa.tanks.model.item.BattleFriendsListener;
  import alternativa.tanks.model.map.mapinfo.IMapInfo;
  import alternativa.tanks.service.battle.IBattleUserInfoService;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.service.battlelist.IBattleListFormService;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.types.Long;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.ObjectUnloadPostListener;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;
  import projects.tanks.client.battleselect.model.battle.BattleInfoModelBase;
  import projects.tanks.client.battleselect.model.battle.IBattleInfoModelBase;
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;

  [ModelInfo]
  public class BattleInfoModel extends BattleInfoModelBase implements IBattleInfoModelBase, ObjectUnloadListener, ObjectUnloadPostListener, IBattleInfo, BattleFriendsListener {
    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    [Inject]
    public static var battleAlertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var userBattleSelectActionsService:UserBattleSelectActionsService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var battleListFormService:IBattleListFormService;

    [Inject]
    public static var battleUserInfoService:IBattleUserInfoService;

    public function BattleInfoModel() {
      super();
    }

    public function roundFinished() : void {
      this.data().roundStarted = false;
      this.data().endTime = 0;
      battleInfoFormService.roundFinish();
    }

    public function roundStarted(param1:int) : void {
      this.data().roundStarted = true;
      this.data().endTime = getTimer() + param1 * 1000;
      this.data().userToInfo.resetScore();
      battleInfoFormService.roundStart(param1);
    }

    public function updateSuspicion(param1:BattleSuspicionLevel) : void {
      battleListFormService.updateSuspicious(object.id,param1);
    }

    public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
      battleInfoFormService.updateUserSuspiciousState(param1,param2);
    }

    public function objectUnloaded() : void {
      if(battleInfoFormService.getSelectedBattle() == object) {
        battleInfoFormService.hideBattleForms();
      }
    }

    public function getConstructor() : BattleInfoCC {
      return getInitParam();
    }

    public function getPreviewResource() : ImageResource {
      var local1:BattleParamInfoCC = BattleParams(object.adapt(BattleParams)).getConstructor();
      return IMapInfo(local1.map.adapt(IMapInfo)).getPreviewResource();
    }

    public function objectUnloadedPost() : void {
      battleUserInfoService.deleteBattleItem(object);
      battleListFormService.removeBattleItem(object.id);
    }

    public function onAddFriend(param1:Long) : void {
      ++this.data().friends;
      this.updateUsersCount();
    }

    public function onDeleteFriend(param1:Long) : void {
      --this.data().friends;
      this.updateUsersCount();
    }

    private function data() : BattleInfoBaseParams {
      return BattleInfoParams(object.adapt(BattleInfoParams)).getParams();
    }

    private function updateUsersCount() : void {
      battleListFormService.updateUsersCount(object.id);
    }

    public function setBattleName(param1:String) : void {
      this.data().customName = param1;
      this.updateBattleName();
    }

    private function updateBattleName() : void {
      battleListFormService.updateBattleName(object.id);
      battleInfoFormService.updateBattleName();
    }

    public function resetBattleName() : void {
      this.data().customName = null;
      this.updateBattleName();
    }
  }
}
