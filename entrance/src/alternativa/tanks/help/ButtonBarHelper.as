package alternativa.tanks.help {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;

  public class ButtonBarHelper extends PanelBubbleHelper {
    public function ButtonBarHelper(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) {
      super(param1,param2,param3);
      var local6:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      var local7:String = local6.getText(param4 ? TanksLocale.TEXT_PARTNER_HELP_PANEL_BUTTON_BAR_HELPER_TEXT : TanksLocale.TEXT_HELP_PANEL_BUTTON_BAR_HELPER_TEXT);
      if(param5) {
        local7 += local6.getText(TanksLocale.TEXT_HELP_PANEL_BUTTON_BAR_FULLSCREEN_TEXT);
      }
      text = local7;
      arrowLehgth = int(local6.getText(TanksLocale.TEXT_HELP_PANEL_BUTTON_BAR_HELPER_ARROW_LENGTH));
      arrowAlign = HelperAlign.TOP_RIGHT;
    }
  }
}
