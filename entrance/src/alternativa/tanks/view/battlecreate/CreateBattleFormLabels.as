package alternativa.tanks.view.battlecreate {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class CreateBattleFormLabels {
    [Inject]
    public static var localeService:ILocaleService;

    public function CreateBattleFormLabels() {
      super();
    }

    public static function get mapNameLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_MAP_TYPE_LABEL);
    }

    public static function get themeMapNameLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_MAP_THEME_LABEL);
    }

    public static function get stepperMaxPlayersLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_STEPPER_MAX_PLAYERS);
    }

    public static function get stepperMaxTeamPlayersLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_STEPPER_MAX_TEAM_SIZE);
    }

    public static function get stepperTimeLimitLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_STEPPER_TIME_LIMIT);
    }

    public static function get stepperKillsLimitLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_STEPPER_KILLS_LIMIT);
    }

    public static function get stepperFlagsLimitLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_STEPPER_FLAG_LIMIT);
    }

    public static function get checkBoxAutoBalanceLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_CHECKBOX_AUTOBALANCE);
    }

    public static function get checkBoxFriendlyFireLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_CHECKBOX_FRIENDLY_FIRE);
    }

    public static function get checkBoxDronesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_DRONES);
    }

    public static function get checkBoxNoSuppliesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_SUPPLIES_TEXT);
    }

    public static function get checkBoxDependentCooldownLabel() : String {
      return localeService.getText(TanksLocale.TEXT_SMART_SUPPLIES);
    }

    public static function get checkBoxBonusesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_BONUS_BOX_TEXT);
    }

    public static function get checkBoxGoldBoxesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_CREATE_BATTLE_PANEL_GOLD_BOXES);
    }

    public static function get checkBoxUpgradesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_UPGRADES_TEXT);
    }

    public static function get checkBoxPrivateBattleLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_CHECKBOX_PRIVATE_BATTLE);
    }

    public static function get startButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_START);
    }

    public static function get deathMatchButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_DEATHMATCH);
    }

    public static function get teamDeathMatchButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_TEAM_DEATHMATCH);
    }

    public static function get captureTheFlagButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_CAPTURE_THE_FLAG);
    }

    public static function get dominationButtonLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_CONTROL_THE_POINT);
    }

    public static function get deathMatchButtonShortLabel() : String {
      return localeService.getText(TanksLocale.TEXT_DM_SHORT_NAME);
    }

    public static function get teamDeathMatchButtonShortLabel() : String {
      return localeService.getText(TanksLocale.TEXT_TDM_SHORT_NAME);
    }

    public static function get captureTheFlagButtonShortLabel() : String {
      return localeService.getText(TanksLocale.TEXT_CTF_SHORT_NAME);
    }

    public static function get dominationButtonShortLabel() : String {
      return localeService.getText(TanksLocale.TEXT_CP_SHORT_NAME);
    }

    public static function get stepperDominationLimitLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_STEPPER_TEAM_SCORE_LIMIT);
    }

    public static function get checkBoxReArmorLabel() : String {
      return localeService.getText(TanksLocale.TEXT_REARM_OPTION_TEXT);
    }

    public static function get checkBoxAutoCompletionLabel() : String {
      return localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_CHECKBOX_AUTO_COMPLETION);
    }

    public static function get checkBoxDevicesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_DEVICES);
    }

    public static function get checkBoxClanLabel() : String {
      return localeService.getText(TanksLocale.TEXT_CLAN_VS_CLAN);
    }

    public static function get checkBoxUltimatesLabel() : String {
      return localeService.getText(TanksLocale.TEXT_ULTIMATES);
    }

    public static function getThemeName(param1:MapTheme) : String {
      switch(param1.value) {
        case MapTheme.SUMMER.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_SUMMER);
        case MapTheme.WINTER.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_WINTER);
        case MapTheme.SPACE.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_SPACE);
        case MapTheme.DAY.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_DAY);
        case MapTheme.NIGHT.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_NIGHT);
        case MapTheme.SUMMER_DAY.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_SUMMER_DAY);
        case MapTheme.SUMMER_NIGHT.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_SUMMER_NIGHT);
        case MapTheme.WINTER_DAY.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_WINTER_DAY);
        case MapTheme.WINTER_NIGHT.value:
          return localeService.getText(TanksLocale.TEXT_MAP_THEME_NAME_WINTER_NIGHT);
        default:
          return null;
      }
    }
  }
}
