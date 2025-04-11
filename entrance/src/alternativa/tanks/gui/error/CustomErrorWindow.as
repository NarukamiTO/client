package alternativa.tanks.gui.error {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.DisplayObject;
  import platform.client.fp10.core.service.errormessage.IMessageBox;
  import platform.client.fp10.core.service.errormessage.errors.ConnectionClosedError;
  import platform.client.fp10.core.service.errormessage.errors.ErrorType;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class CustomErrorWindow implements IMessageBox {
    private static var localeService:ILocaleService;

    private var errorForm:ErrorForm;

    public function CustomErrorWindow(param1:OSGi) {
      super();
      localeService = ILocaleService(param1.getService(ILocaleService));
      this.errorForm = new ErrorForm(localeService);
      this.errorForm.setSupportUrl(localeService.getText(TanksLocale.TEXT_CONNECTION_CLOSED_WIKI_LINK));
    }

    public function getDisplayObject(param1:ErrorType) : DisplayObject {
      var local2:String = this.getErrorText(param1);
      this.errorForm.setErrorText(local2);
      return this.errorForm;
    }

    private function getErrorText(param1:ErrorType) : String {
      if(param1 is ConnectionClosedError) {
        return localeService.getText(TanksLocale.TEXT_CONNECTION_CLOSED_MESSAGE);
      }
      return param1.getMessage();
    }

    public function hide() : void {
      if(this.errorForm.parent != null) {
        this.errorForm.parent.removeChild(this.errorForm);
      }
    }
  }
}
