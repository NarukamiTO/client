package alternativa.tanks.gui.panel.helpers {
  import alternativa.tanks.help.PanelBubbleHelper;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class ChangeServerHelper extends PanelBubbleHelper {
    public function ChangeServerHelper(param1:int) {
      super(1,param1,0);
      text = localeService.getText(TanksLocale.TEXT_CHANGE_SERVER_HELPER);
      arrowLehgth = 36;
      arrowAlign = HelperAlign.TOP_RIGHT;
    }
  }
}
