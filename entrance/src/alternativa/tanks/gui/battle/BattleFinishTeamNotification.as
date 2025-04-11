package alternativa.tanks.gui.battle {
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class BattleFinishTeamNotification extends BattleFinishNotification {
    private var _isVictory:Boolean;
    private var _isDefeat:Boolean;
    private var _position:int;
    private var _places:int;
    private var _crystals:int;
    private var _stars:int;

    public function BattleFinishTeamNotification(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int, param6:int, param7:Boolean) {
      this._isVictory = param1;
      this._isDefeat = param2;
      this._position = param3;
      this._places = param4;
      this._crystals = param5;
      this._stars = param6;
      _showStars = param7;
      super();
    }

    override public function get message() : String {
      if(_showStars) {
        return this.getMainMessage() + "\n" + localeService.getText(TanksLocale.TEXT_REARM_BATTLE_STARS_PRIZE).replace(NotificationPatterns.STARS_REPLACE_PATTER,getStarsRewardText(this._stars));
      }
      return this.getMainMessage();
    }

    private function getMainMessage() : String {
      return this.getTotalRoundLabel() + "\n" + localeService.getText(TanksLocale.TEXT_REARM_BATTLE_PLACE).replace(NotificationPatterns.YOUR_PLACE_REPLACE_PATTERN,this._position).replace(NotificationPatterns.PLACES_REPLACE_PATTERN,this._places) + "\n" + localeService.getText(TanksLocale.TEXT_REARM_BATTLE_PRIZE).replace(NotificationPatterns.CRYSTALS_REPLACE_PATTERN,String(this._crystals));
    }

    protected function getTotalRoundLabel() : String {
      if(this._isVictory) {
        return localeService.getText(TanksLocale.TEXT_REARM_TEAM_WIN);
      }
      if(this._isDefeat) {
        return localeService.getText(TanksLocale.TEXT_REARM_TEAM_LOOSE);
      }
      return localeService.getText(TanksLocale.TEXT_REARM_TEAM_TIE);
    }
  }
}
