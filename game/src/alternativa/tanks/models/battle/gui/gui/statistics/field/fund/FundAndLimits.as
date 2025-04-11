package alternativa.tanks.models.battle.gui.gui.statistics.field.fund {
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.IconField;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.timelimit.RedTimeLimitField;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.timelimit.TimeLimitField;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkManager;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkingField;
  import assets.icons.BattleInfoIcons;
  import controls.resultassets.WhiteFrame;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;

  public class FundAndLimits extends Sprite {
    private static const asIconClass:Class = FundAndLimits_asIconClass;
    private static const rugbyIconClass:Class = FundAndLimits_rugbyIconClass;
    private static const CTF_SCORE_WINK_LIMIT:int = 1;
    private static const DOMINATION_SCORE_WINK_LIMIT:int = 1;
    private static const SCORE_WINK_LIMIT:int = 3;
    private static const TIME_WINK_LIMIT:int = 30;

    private var battleType:BattleType;
    private var whiteFrame:WhiteFrame;
    private var fundField:FundField;
    private var scoreLimitField:WinkingField;
    private var timeLimitField:TimeLimitField;
    private var timeRestoreBalanceField:RedTimeLimitField;
    private var timeLimit:int;
    private var scoreLimit:int;

    public function FundAndLimits(param1:BattleType, param2:int, param3:BattleLimits, param4:int, param5:Boolean, param6:Boolean) {
      super();
      this.battleType = param1;
      this.timeLimit = param3.timeLimitInSec;
      this.scoreLimit = param3.scoreLimit;
      this.whiteFrame = new WhiteFrame();
      addChild(this.whiteFrame);
      if(param6) {
        this.fundField = new FundField(IconField.getIcon(BattleInfoIcons.MONEY));
        this.fundField.initFund(param2);
        addChild(this.fundField);
      }
      this.initScoreLimitField(param5);
      if(this.timeLimit > 0) {
        this.timeLimitField = new TimeLimitField(TIME_WINK_LIMIT,IconField.getIcon(BattleInfoIcons.TIME_LIMIT),WinkManager.instance,false);
        this.timeLimitField.value = param4;
        addChild(this.timeLimitField);
      }
    }

    private function getIcon() : DisplayObject {
      switch(this.battleType) {
        case BattleType.CTF:
          return IconField.getIcon(BattleInfoIcons.CTF);
        case BattleType.DOMINATION:
          return IconField.getIcon(BattleInfoIcons.TEAM_SCORE);
        case BattleType.AS:
          return new asIconClass();
        case BattleType.RUGBY:
          return new rugbyIconClass();
        default:
          return IconField.getIcon(BattleInfoIcons.KILL_LIMIT);
      }
    }

    public function onScoreChanged(param1:int) : void {
      if(this.scoreLimitField != null) {
        if(param1 >= this.scoreLimit - this.getScoreWinkLimit()) {
          this.scoreLimitField.startWink();
        }
      }
    }

    private function getScoreWinkLimit() : int {
      switch(this.battleType) {
        case BattleType.CTF:
          return CTF_SCORE_WINK_LIMIT;
        case BattleType.DOMINATION:
          return DOMINATION_SCORE_WINK_LIMIT;
        default:
          return SCORE_WINK_LIMIT;
      }
    }

    public function setFund(param1:int) : void {
      this.fundField.initFund(param1);
    }

    public function reset() : void {
      if(this.scoreLimitField != null) {
        this.scoreLimitField.value = this.scoreLimit;
      }
      if(this.timeLimitField != null) {
        this.timeLimitField.value = this.timeLimit;
      }
      if(this.timeRestoreBalanceField != null) {
        this.turnOffTimerToRestoreBalance();
      }
    }

    public function stopWink() : void {
      if(this.scoreLimitField != null) {
        this.scoreLimitField.stopWink();
      }
      if(this.timeLimitField != null) {
        this.timeLimitField.value = 0;
        this.timeLimitField.stopWink();
      }
      if(this.timeRestoreBalanceField != null) {
        this.timeRestoreBalanceField.value = 0;
        this.timeRestoreBalanceField.stopWink();
      }
    }

    public function adjustFields() : void {
      var local1:Number = 0;
      if(this.fundField != null) {
        this.fundField.x = 14;
        this.fundField.y = 11;
        local1 = this.fundField.width + this.fundField.x;
      }
      if(this.scoreLimitField != null) {
        this.scoreLimitField.x = local1 + 6;
        this.scoreLimitField.y = 11;
        local1 = this.scoreLimitField.width + this.scoreLimitField.x;
      }
      if(this.timeLimitField != null) {
        this.timeLimitField.x = local1 + 10;
        this.timeLimitField.y = 11;
        local1 = this.timeLimitField.width + this.timeLimitField.x;
      }
      if(this.timeRestoreBalanceField != null) {
        if(this.timeLimitField != null) {
          this.timeRestoreBalanceField.x = this.timeLimitField.x;
          this.timeRestoreBalanceField.y = this.timeLimitField.y;
        } else {
          this.timeRestoreBalanceField.x = local1 + 10;
          this.timeRestoreBalanceField.y = 11;
          local1 = this.timeRestoreBalanceField.width + this.timeRestoreBalanceField.x;
        }
      }
      this.whiteFrame.width = 12 + local1;
    }

    public function turnOnTimerToRestoreBalance(param1:int) : void {
      if(this.timeLimitField != null) {
        this.timeLimitField.visible = false;
      }
      this.timeRestoreBalanceField = new RedTimeLimitField(TIME_WINK_LIMIT,IconField.getIcon(BattleInfoIcons.TIME_LIMIT),WinkManager.instance,false);
      this.timeRestoreBalanceField.startCountdown(param1);
      addChild(this.timeRestoreBalanceField);
    }

    public function turnOffTimerToRestoreBalance() : void {
      if(this.timeLimitField != null) {
        this.timeLimitField.visible = true;
      }
      removeChild(this.timeRestoreBalanceField);
      this.timeRestoreBalanceField = null;
    }

    public function startCountdownTimeLimit(param1:int) : void {
      this.timeLimitField.startCountdown(param1);
    }

    public function stopCountdownTimeLimit() : void {
      this.timeLimitField.stopCountdown();
    }

    public function initScoreLimitField(param1:Boolean) : void {
      if(this.scoreLimitField == null && param1 && this.scoreLimit > 0) {
        this.scoreLimitField = new WinkingField(this.getScoreWinkLimit(),this.getIcon(),WinkManager.instance);
        this.scoreLimitField.value = this.scoreLimit;
        addChild(this.scoreLimitField);
      }
    }
  }
}
