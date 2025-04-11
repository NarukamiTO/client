package alternativa.tanks.view.battleinfo {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LocaleBattleInfo {
    [Inject]
    public static var localeService:ILocaleService;

    public function LocaleBattleInfo() {
      super();
    }

    public static function get fightButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLEINFO_PANEL_BUTTON_PLAY);
    }

    public static function get noNameText() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLEINFO_PANEL_NONAME_TEXT);
    }

    public static function get proBattleAlertLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_PRO_BATTLE_SUBSCRIBE);
    }

    public static function get returnToBattleButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_REARM_BATTLE_RETURN);
    }

    public static function get exitFromBattleButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_REARM_BATTLE_EXIT);
    }

    public static function get buyAbonementButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BUY_PRO_ABONEMENT);
    }
  }
}
