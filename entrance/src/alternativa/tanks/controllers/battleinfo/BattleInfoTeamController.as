package alternativa.tanks.controllers.battleinfo {
  import alternativa.tanks.view.battleinfo.BattleInfoUserList;
  import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
  import alternativa.tanks.view.battleinfo.team.BattleInfoTeamView;
  import alternativa.types.Long;
  import fl.data.DataProvider;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class BattleInfoTeamController extends AbstractBattleInfoController {
    [Inject]
    public static var userInfoService:IUserInfoService;

    private var userId2userList:Dictionary = new Dictionary();
    private var autoBalance:Boolean;

    public function BattleInfoTeamController() {
      super();
      view = new BattleInfoTeamView();
    }

    override protected function updateUserLists() : void {
      var local1:BattleInfoTeamParams = BattleInfoTeamParams(initParams);
      this.updateUserList(maxPeopleCount,local1.usersRed,this.teamView.redUserList);
      this.updateUserList(maxPeopleCount,local1.usersBlue,this.teamView.blueUserList);
      this.autoBalance = initParams.createParams.autoBalance;
      this.updateAvailableEnterInBattle();
    }

    private function updateUserList(param1:int, param2:Vector.<BattleInfoUser>, param3:BattleInfoUserList) : void {
      param3.update(param1,param2);
      this.updateUserId2userList(param3);
    }

    override protected function updateAvailableEnterInBattle() : void {
      this.teamView.redFightButton.enabled = this.isFightButtonEnabledForTeam(this.teamView.redUserList,this.teamView.blueUserList) && this.isAvailableEnterInClanBattleForTeam(this.teamView.redUserList,this.teamView.blueUserList);
      this.teamView.blueFightButton.enabled = this.isFightButtonEnabledForTeam(this.teamView.blueUserList,this.teamView.redUserList) && this.isAvailableEnterInClanBattleForTeam(this.teamView.blueUserList,this.teamView.redUserList);
    }

    private function isFightButtonEnabledForTeam(param1:BattleInfoUserList, param2:BattleInfoUserList) : Boolean {
      return availableByRank && initParams.createParams.proBattle && param1.usersCount < maxPeopleCount && (!this.autoBalance || param1.usersCount <= param2.usersCount);
    }

    private function isAvailableEnterInClanBattleForTeam(param1:BattleInfoUserList, param2:BattleInfoUserList) : Boolean {
      var local6:Long = null;
      var local7:Long = null;
      if(!initParams.createParams.clanBattle) {
        return true;
      }
      if(!clanUserInfoService.clanMember) {
        return false;
      }
      var local3:Boolean = true;
      if(param1.usersCount == 0) {
        local3 = true;
      }
      var local4:Long = userInfoService.getCurrentUserId();
      var local5:Long = clanUserInfoService.userClanInfoByUserId(local4).clanId;
      if(param2.usersCount > 0) {
        local6 = param2.getTeamClanId();
        if(local6 == local5) {
          local3 = false;
        }
      }
      if(param1.usersCount > 0) {
        local7 = param1.getTeamClanId();
        return local3 && local7 == local5;
      }
      return local3;
    }

    public function addUserToTeam(param1:BattleInfoUser, param2:BattleTeam) : void {
      var local3:BattleInfoUserList = this.getTeamUserList(param2);
      local3.addUser(param1);
      this.userId2userList[param1.user] = local3;
      this.updateAvailableEnterInBattle();
    }

    override public function removeUser(param1:Long) : void {
      this.userId2userList[param1].removeUser(param1);
      delete this.userId2userList[param1];
      this.updateAvailableEnterInBattle();
    }

    public function updateTeamScore(param1:BattleTeam, param2:int) : void {
      this.teamView.updateScore(param1,param2);
    }

    override public function updateUserScore(param1:Long, param2:int) : void {
      this.userId2userList[param1].updateUserScore(param1,param2);
      this.teamView.invalidateUserList();
    }

    override public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
      this.userId2userList[param1].updateUserSuspiciousState(param1,param2);
      this.teamView.invalidateUserList();
    }

    override public function destroy() : void {
      super.destroy();
      this.userId2userList = null;
    }

    public function swapTeams() : void {
      var local1:DataProvider = this.teamView.blueUserList.dataProvider;
      this.teamView.blueUserList.dataProvider = this.teamView.redUserList.dataProvider;
      this.teamView.redUserList.dataProvider = local1;
      var local2:int = this.teamView.blueUserList.usersCount;
      this.teamView.blueUserList.usersCount = this.teamView.redUserList.usersCount;
      this.teamView.redUserList.usersCount = local2;
      this.updateUserId2userList(this.teamView.redUserList);
      this.updateUserId2userList(this.teamView.blueUserList);
      this.updateAvailableEnterInBattle();
    }

    private function updateUserId2userList(param1:BattleInfoUserList) : void {
      var local3:Object = null;
      var local2:int = 0;
      while(local2 < param1.dataProvider.length) {
        local3 = param1.dataProvider.getItemAt(local2);
        if(local3.id == null) {
          break;
        }
        this.userId2userList[local3.id] = param1;
        local2++;
      }
    }

    private function get teamView() : BattleInfoTeamView {
      return BattleInfoTeamView(view);
    }

    private function getTeamUserList(param1:BattleTeam) : BattleInfoUserList {
      return param1 == BattleTeam.RED ? this.teamView.redUserList : this.teamView.blueUserList;
    }

    override protected function updateControlPanel() : void {
      this.teamView.updateScore(BattleTeam.RED,BattleInfoTeamParams(initParams).scoreRed);
      this.teamView.updateScore(BattleTeam.BLUE,BattleInfoTeamParams(initParams).scoreBlue);
    }
  }
}
