package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.IconField;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.LayoutManager;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.fund.FundAndLimits;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.CTFScoreIndicator;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.ComplexTeamScoreIndicator;
  import alternativa.types.Long;
  import assets.icons.BattleInfoIcons;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;
  import projects.tanks.client.battleservice.model.statistics.StatisticsModelCC;

  public class BattleStatistics extends Sprite implements Widget {
    private var battleType:BattleType;
    private var fundAndLimits:FundAndLimits;
    private var playerScoreField:PlayerScoreField;
    private var teamScoreField:TeamScoreIndicator;
    private var localUserId:Long;
    private var layoutManager:LayoutManager;
    private var showFund:Boolean;

    public function BattleStatistics(param1:Long, param2:StatisticsModelCC, param3:BattleType, param4:Boolean) {
      super();
      this.battleType = param3;
      this.localUserId = param1;
      this.showFund = Boolean(param2.valuableRound) && !param2.matchBattle;
      this.initFields(param2.fund,param2.limits,param2.timeLeft,param4);
    }

    public function setLayoutManager(param1:LayoutManager) : void {
      this.layoutManager = param1;
      this.adjustFields();
    }

    public function setIndicatorState(param1:BattleTeam, param2:int) : void {
      ComplexTeamScoreIndicator(this.teamScoreField).setIndicatorState(param1,param2);
    }

    public function setBothIndicatorsState(param1:int, param2:int) : void {
      ComplexTeamScoreIndicator(this.teamScoreField).setBothIndicatorsState(param1,param2);
    }

    private function initFields(param1:int, param2:BattleLimits, param3:int, param4:Boolean) : void {
      this.createFundAndLimits(param1,param2,param3,param4);
      this.createScoreField(0,0);
      this.adjustFields();
    }

    private function createFundAndLimits(param1:int, param2:BattleLimits, param3:int, param4:Boolean) : void {
      this.fundAndLimits = new FundAndLimits(this.battleType,param1,param2,param3,param4,this.showFund);
      addChild(this.fundAndLimits);
    }

    private function createScoreField(param1:int, param2:int) : void {
      if(!this.battleType.isTeam()) {
        this.playerScoreField = new PlayerScoreField(IconField.getIcon(BattleInfoIcons.KILL_LIMIT));
        addChild(this.playerScoreField);
      } else {
        this.teamScoreField = this.createTeamScoreField();
        this.setTeamScore(BattleTeam.BLUE,param1);
        this.setTeamScore(BattleTeam.RED,param2);
        addChild(DisplayObject(this.teamScoreField));
      }
    }

    private function createTeamScoreField() : TeamScoreIndicator {
      switch(this.battleType) {
        case BattleType.TDM:
          return new TDMScoreField();
        case BattleType.CTF:
          return new CTFScoreIndicator();
        case BattleType.DOMINATION:
          return new DominationScoreField();
        case BattleType.AS:
          return new ASScoreIndicator();
        case BattleType.RUGBY:
          return new RugbyScoreIndicator();
        default:
          throw new Error();
      }
    }

    public function updateUserKills(param1:Long, param2:int) : void {
      if(this.battleType == BattleType.DM || this.battleType == BattleType.TDM || this.battleType == BattleType.JGR) {
        this.fundAndLimits.onScoreChanged(param2);
        if(!this.battleType.isTeam() && param1 == this.localUserId) {
          this.playerScoreField.setScore(param2);
        }
        this.adjustFields();
      }
    }

    public function setTeamScore(param1:BattleTeam, param2:int) : void {
      this.teamScoreField.setTeamScore(param1,param2);
      this.fundAndLimits.onScoreChanged(param2);
      this.adjustFields();
    }

    public function updateFund(param1:int) : void {
      this.fundAndLimits.setFund(param1);
      this.adjustFields();
    }

    public function resetFields() : void {
      this.fundAndLimits.reset();
      if(this.battleType.isTeam()) {
        this.teamScoreField.setScore(0,0);
      } else {
        this.playerScoreField.setScore(0);
      }
      this.adjustFields();
    }

    public function initOnRoundStart(param1:Boolean) : void {
      this.resetFields();
      this.fundAndLimits.initScoreLimitField(param1);
      this.adjustFields();
    }

    public function finish() : void {
      this.fundAndLimits.stopWink();
      this.adjustFields();
    }

    public function adjustFields() : void {
      this.fundAndLimits.adjustFields();
      var local1:DisplayObject = this.battleType.isTeam() ? DisplayObject(this.teamScoreField) : this.playerScoreField;
      local1.x = this.fundAndLimits.width + 10;
      if(this.layoutManager != null) {
        this.layoutManager.onWidgetChanged(this);
      }
    }

    public function turnOnTimerToRestoreBalance(param1:int) : void {
      this.fundAndLimits.turnOnTimerToRestoreBalance(param1);
      this.adjustFields();
    }

    public function turnOffTimerToRestoreBalance() : void {
      this.fundAndLimits.turnOffTimerToRestoreBalance();
      this.adjustFields();
    }

    public function startCountdownTimeLimit(param1:int) : void {
      this.fundAndLimits.startCountdownTimeLimit(param1);
    }

    public function stopCountdownTimeLimit() : void {
      this.fundAndLimits.stopCountdownTimeLimit();
    }
  }
}
