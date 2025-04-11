package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class IStatisticsModelAdapt implements IStatisticsModel {
    private var object:IGameObject;
    private var impl:IStatisticsModel;

    public function IStatisticsModelAdapt(param1:IGameObject, param2:IStatisticsModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBattleName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getBattleName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function userConnect(param1:ShortUserInfo) : void {
      var shortUserInfo:ShortUserInfo = param1;
      try {
        Model.object = this.object;
        this.impl.userConnect(shortUserInfo);
      }
      finally {
        Model.popObject();
      }
    }

    public function userDisconnect(param1:ShortUserInfo) : void {
      var shortUserInfo:ShortUserInfo = param1;
      try {
        Model.object = this.object;
        this.impl.userDisconnect(shortUserInfo);
      }
      finally {
        Model.popObject();
      }
    }

    public function updateUserKills(param1:Long, param2:int) : void {
      var userId:Long = param1;
      var userKills:int = param2;
      try {
        Model.object = this.object;
        this.impl.updateUserKills(userId,userKills);
      }
      finally {
        Model.popObject();
      }
    }

    public function changeTeamScore(param1:BattleTeam, param2:int) : void {
      var team:BattleTeam = param1;
      var score:int = param2;
      try {
        Model.object = this.object;
        this.impl.changeTeamScore(team,score);
      }
      finally {
        Model.popObject();
      }
    }

    public function turnOnTimerToRestoreBalance(param1:int) : void {
      var timeToRestoreBalanceInSec:int = param1;
      try {
        Model.object = this.object;
        this.impl.turnOnTimerToRestoreBalance(timeToRestoreBalanceInSec);
      }
      finally {
        Model.popObject();
      }
    }

    public function turnOffTimerToRestoreBalance() : void {
      try {
        Model.object = this.object;
        this.impl.turnOffTimerToRestoreBalance();
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyAboutTraining(param1:int) : void {
      var durationInSec:int = param1;
      try {
        Model.object = this.object;
        this.impl.notifyAboutTraining(durationInSec);
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyAboutBattle(param1:int) : void {
      var durationInSec:int = param1;
      try {
        Model.object = this.object;
        this.impl.notifyAboutBattle(durationInSec);
      }
      finally {
        Model.popObject();
      }
    }

    public function getTimeLeftInSec() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getTimeLeftInSec());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
