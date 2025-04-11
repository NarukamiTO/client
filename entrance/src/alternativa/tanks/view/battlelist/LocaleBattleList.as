package alternativa.tanks.view.battlelist {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LocaleBattleList {
    [Inject]
    public static var localeService:ILocaleService;

    public function LocaleBattleList() {
      super();
    }

    public static function get showBattleCreateFormLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLELIST_PANEL_BUTTON_CREATE);
    }

    public static function get battleSelectLockedMapHelperName() : String {
      return localeService.getText(TanksLocale.TEXT_HELP_BATTLE_SELECT_LOCKED_MAP_HELPER_TEXT);
    }

    public static function get findBattleText() : String {
      return localeService.getText(TanksLocale.TEXT_FIND_BATTLE_BUTTON_TEXT);
    }

    public static function get battleSelectLockedMapHelperArrowLength() : int {
      return int(localeService.getText(TanksLocale.TEXT_HELP_BATTLE_SELECT_LOCKED_MAP_HELPER_ARROW_LENGTH));
    }
  }
}
