package alternativa.tanks.model.info.dm {
  import alternativa.tanks.controllers.BattleSelectVectorUtil;
  import alternativa.tanks.model.info.BattleInfoParams;
  import alternativa.tanks.model.info.BattleParamsUtils;
  import alternativa.tanks.model.info.ShowInfo;
  import alternativa.tanks.model.item.dm.IBattleDMItem;
  import alternativa.tanks.service.battle.IBattleUserInfoService;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.service.battlelist.IBattleListFormService;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.tanks.view.battleinfo.dm.BattleInfoDmParams;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battleselect.model.battle.dm.BattleDMInfoModelBase;
  import projects.tanks.client.battleselect.model.battle.dm.IBattleDMInfoModelBase;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;

  [ModelInfo]
  public class BattleDmInfoModel extends BattleDMInfoModelBase implements IBattleDMInfoModelBase, ShowInfo, ObjectLoadListener, IBattleDMItem, BattleInfoParams {
    [Inject]
    public static var battleListFormService:IBattleListFormService;

    [Inject]
    public static var friendsInfoService:IFriendInfoService;

    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    [Inject]
    public static var battleUserInfoService:IBattleUserInfoService;

    public function BattleDmInfoModel() {
      super();
    }

    public function removeUser(param1:Long) : void {
      BattleSelectVectorUtil.deleteElementInUsersVector(this.data().users,param1);
      BattleParamsUtils.unregisterUser(param1,this.data());
      this.updateUsersCount();
      battleInfoFormService.removeUser(param1);
    }

    public function addUser(param1:BattleInfoUser) : void {
      this.data().users.push(param1);
      BattleParamsUtils.registerUser(param1,this.data(),object);
      battleInfoFormService.addUser(param1);
      this.updateUsersCount();
    }

    public function showInfo() : void {
      battleInfoFormService.showDmForm(this.data());
    }

    public function updateUserScore(param1:Long, param2:int) : void {
      this.data().userToInfo.get(param1).score = param2;
      battleInfoFormService.updateUserScore(param1,param2);
    }

    public function objectLoaded() : void {
      var local1:BattleInfoDmParams = new BattleInfoDmParams();
      putData(BattleInfoDmParams,local1);
      local1.users = getInitParam().users.concat();
      BattleParamsUtils.setBattleInfoParams(object,local1);
      BattleParamsUtils.registerUsers(object,local1.users,local1);
      battleListFormService.battleItemRecord(this.data());
    }

    private function data() : BattleInfoDmParams {
      return BattleInfoDmParams(getData(BattleInfoDmParams));
    }

    public function getParams() : BattleInfoBaseParams {
      return this.data();
    }

    public function getUsersCount() : int {
      return this.data().users.length;
    }

    private function updateUsersCount() : void {
      battleListFormService.updateUsersCount(object.id);
    }
  }
}
