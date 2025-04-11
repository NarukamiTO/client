package alternativa.tanks.gui.premiumaccount {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import forms.alert.AlertDialogWindow;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PremiumAccountWelcomeAlert extends AlertDialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private var _welcomeText:String;

    public function PremiumAccountWelcomeAlert(param1:String) {
      this._welcomeText = param1;
      super(localeService.getText(TanksLocale.TEXT_HEADER_PREMIUM),localeService.getText(TanksLocale.TEXT_CLOSE_LABEL));
    }

    override protected function init() : void {
      var local1:Bitmap = null;
      super.init();
      local1 = new Bitmap(PremiumAccountIcons.premiumIconForWelcomeAlert);
      _contentPlace.addChild(local1);
      var local2:LabelBase = this.createLabel();
      local2.width = local1.width;
      _contentPlace.addChild(local2);
      local2.y = local1.height + GAP_11;
      var local3:int = Math.max(local1.width,local2.width + 2 * GAP_11);
      local1.x = local3 - local1.width >> 1;
      local2.x = local3 - local2.width >> 1;
      var local4:int = local1.height + GAP_11 + local2.height + GAP_11;
      setContentPlaceSize(local3,local4);
    }

    private function createLabel() : LabelBase {
      var local1:LabelBase = new LabelBase();
      local1.autoSize = TextFieldAutoSize.CENTER;
      local1.align = TextFormatAlign.CENTER;
      local1.multiline = true;
      local1.text = this._welcomeText;
      local1.size = 18;
      local1.color = ColorConstants.GREEN_TEXT;
      return local1;
    }
  }
}
