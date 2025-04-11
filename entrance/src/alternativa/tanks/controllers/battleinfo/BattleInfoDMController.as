package alternativa.tanks.controllers.battleinfo {
  import alternativa.tanks.view.battleinfo.dm.BattleInfoDMView;
  import alternativa.tanks.view.battleinfo.dm.BattleInfoDmParams;
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class BattleInfoDMController extends AbstractBattleInfoController {
    public function BattleInfoDMController() {
      super();
      view = new BattleInfoDMView();
    }

    override protected function updateUserLists() : void {
      this.dmView.userList.update(maxPeopleCount,BattleInfoDmParams(initParams).users);
      this.updateAvailableEnterInBattle();
    }

    override protected function updateAvailableEnterInBattle() : void {
      this.dmView.fightButton.enabled = availableByRank && initParams.createParams.proBattle && this.dmView.userList.usersCount < maxPeopleCount;
    }

    public function addUser(param1:BattleInfoUser) : void {
      this.dmView.userList.addUser(param1);
      this.updateAvailableEnterInBattle();
    }

    override public function removeUser(param1:Long) : void {
      this.dmView.userList.removeUser(param1);
      this.updateAvailableEnterInBattle();
    }

    override public function updateUserScore(param1:Long, param2:int) : void {
      this.dmView.userList.updateUserScore(param1,param2);
      this.dmView.invalidateUserList();
    }

    override public function updateUserSuspiciousState(param1:Long, param2:Boolean) : void {
      this.dmView.userList.updateUserSuspiciousState(param1,param2);
      this.dmView.invalidateUserList();
    }

    private function get dmView() : BattleInfoDMView {
      return BattleInfoDMView(view);
    }
  }
}
