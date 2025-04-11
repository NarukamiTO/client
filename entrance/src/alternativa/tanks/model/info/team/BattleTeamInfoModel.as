package alternativa.tanks.model.info.team {
  import alternativa.tanks.controllers.BattleSelectVectorUtil;
  import alternativa.tanks.model.info.BattleInfoParams;
  import alternativa.tanks.model.info.BattleParamsUtils;
  import alternativa.tanks.model.info.ShowInfo;
  import alternativa.tanks.service.battle.IBattleUserInfoService;
  import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
  import alternativa.tanks.service.battlelist.IBattleListFormService;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleselect.model.battle.team.ITeamBattleInfoModelBase;
  import projects.tanks.client.battleselect.model.battle.team.TeamBattleInfoModelBase;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;

  [ModelInfo]
  public class BattleTeamInfoModel extends TeamBattleInfoModelBase implements ITeamBattleInfoModelBase, BattleTeamInfo, ShowInfo, ObjectLoadListener, BattleInfoParams {
    [Inject]
    public static var battleListFormService:IBattleListFormService;

    [Inject]
    public static var friendsInfoService:IFriendInfoService;

    [Inject]
    public static var battleUserInfoService:IBattleUserInfoService;

    [Inject]
    public static var battleInfoFormService:IBattleInfoFormService;

    public function BattleTeamInfoModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:BattleInfoTeamParams = null;
      local1 = new BattleInfoTeamParams();
      putData(BattleInfoTeamParams,local1);
      BattleParamsUtils.setBattleInfoParams(object,local1);
      local1.usersBlue = getInitParam().usersBlue.concat();
      local1.usersRed = getInitParam().usersRed.concat();
      BattleParamsUtils.registerUsers(object,local1.usersBlue,local1);
      BattleParamsUtils.registerUsers(object,local1.usersRed,local1);
      local1.scoreBlue = getInitParam().scoreBlue;
      local1.scoreRed = getInitParam().scoreRed;
      battleListFormService.battleItemRecord(this.data());
    }

    public function updateTeamScore(param1:BattleTeam, param2:int) : void {
      if(param1 == BattleTeam.RED) {
        this.data().scoreRed = param2;
      } else {
        this.data().scoreBlue = param2;
      }
      battleInfoFormService.updateTeamScore(param1,param2);
    }

    public function swapTeams() : void {
      var local1:BattleInfoTeamParams = this.data();
      var local2:Vector.<BattleInfoUser> = local1.usersBlue;
      var local3:Vector.<BattleInfoUser> = local1.usersRed;
      local1.usersRed = local2;
      local1.usersBlue = local3;
      local1.scoreBlue = local1.scoreRed = 0;
      battleListFormService.swapTeams(object.id);
      battleInfoFormService.swapTeams();
    }

    public function addUser(param1:BattleInfoUser, param2:BattleTeam) : void {
      var local3:BattleInfoTeamParams = this.data();
      var local4:Vector.<BattleInfoUser> = param2 == BattleTeam.RED ? local3.usersRed : local3.usersBlue;
      local4.push(param1);
      BattleParamsUtils.registerUser(param1,local3,object);
      battleInfoFormService.addUser(param1,param2);
      this.updateUsersCount();
    }

    public function removeUser(param1:Long) : void {
      BattleSelectVectorUtil.deleteElementInUsersVector(this.data().usersBlue,param1);
      BattleSelectVectorUtil.deleteElementInUsersVector(this.data().usersRed,param1);
      BattleParamsUtils.unregisterUser(param1,this.data());
      this.updateUsersCount();
      battleInfoFormService.removeUser(param1);
    }

    public function showInfo() : void {
      battleInfoFormService.showTeamForm(this.data());
    }

    public function updateUserScore(param1:Long, param2:int) : void {
      this.data().userToInfo.get(param1).score = param2;
      battleInfoFormService.updateUserScore(param1,param2);
    }

    public function getUsersCountBlue() : int {
      return this.data().usersBlue.length;
    }

    public function getUsersCountRed() : int {
      return this.data().usersRed.length;
    }

    private function data() : BattleInfoTeamParams {
      return BattleInfoTeamParams(getData(BattleInfoTeamParams));
    }

    public function getParams() : BattleInfoBaseParams {
      return this.data();
    }

    private function updateUsersCount() : void {
      battleListFormService.updateUsersCount(object.id);
    }
  }
}
