package alternativa.tanks.models.statistics {
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class IStatisticsModelEvents implements IStatisticsModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IStatisticsModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBattleName() : String {
      var result:String = null;
      var i:int = 0;
      var m:IStatisticsModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          result = m.getBattleName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function userConnect(param1:ShortUserInfo) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var shortUserInfo:ShortUserInfo = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.userConnect(shortUserInfo);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function userDisconnect(param1:ShortUserInfo) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var shortUserInfo:ShortUserInfo = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.userDisconnect(shortUserInfo);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function updateUserKills(param1:Long, param2:int) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var userId:Long = param1;
      var userKills:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.updateUserKills(userId,userKills);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function changeTeamScore(param1:BattleTeam, param2:int) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var team:BattleTeam = param1;
      var score:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.changeTeamScore(team,score);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function turnOnTimerToRestoreBalance(param1:int) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var timeToRestoreBalanceInSec:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.turnOnTimerToRestoreBalance(timeToRestoreBalanceInSec);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function turnOffTimerToRestoreBalance() : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.turnOffTimerToRestoreBalance();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyAboutTraining(param1:int) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var durationInSec:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.notifyAboutTraining(durationInSec);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function notifyAboutBattle(param1:int) : void {
      var i:int = 0;
      var m:IStatisticsModel = null;
      var durationInSec:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          m.notifyAboutBattle(durationInSec);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getTimeLeftInSec() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IStatisticsModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticsModel(this.impl[i]);
          result = int(m.getTimeLeftInSec());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
