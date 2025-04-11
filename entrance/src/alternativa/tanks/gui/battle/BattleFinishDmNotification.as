package alternativa.tanks.gui.battle {
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class BattleFinishDmNotification extends BattleFinishNotification {
    private var _position:int;
    private var _places:int;
    private var _reward:int;
    private var _stars:int;

    public function BattleFinishDmNotification(param1:int, param2:int, param3:int, param4:int, param5:Boolean) {
      this._position = param1;
      this._places = param2;
      this._reward = param3;
      this._stars = param4;
      _showStars = param5;
      super();
    }

    override public function get message() : String {
      if(_showStars) {
        return this.getMainMessage() + "\n" + localeService.getText(TanksLocale.TEXT_REARM_BATTLE_STARS_PRIZE).replace(NotificationPatterns.STARS_REPLACE_PATTER,getStarsRewardText(this._stars));
      }
      return this.getMainMessage();
    }

    private function getMainMessage() : String {
      return localeService.getText(TanksLocale.TEXT_REARM_DM_END_BATTLE) + "\n" + localeService.getText(TanksLocale.TEXT_REARM_BATTLE_PLACE).replace(NotificationPatterns.YOUR_PLACE_REPLACE_PATTERN,this._position).replace(NotificationPatterns.PLACES_REPLACE_PATTERN,this._places) + "\n" + localeService.getText(TanksLocale.TEXT_REARM_BATTLE_PRIZE).replace(NotificationPatterns.CRYSTALS_REPLACE_PATTERN,String(this._reward));
    }
  }
}
