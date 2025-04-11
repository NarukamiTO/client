package alternativa.tanks.help {
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class MainMenuHelper extends PanelBubbleHelper {
    public function MainMenuHelper(param1:Number, param2:Number, param3:Number) {
      super(param1,param2,param3);
      text = localeService.getText(TanksLocale.TEXT_HELP_PANEL_MAIN_MENU_HELPER_TEXT);
      arrowLehgth = int(localeService.getText(TanksLocale.TEXT_HELP_PANEL_MAIN_MENU_HELPER_ARROW_LENGTH));
      arrowAlign = HelperAlign.TOP_LEFT;
    }
  }
}
