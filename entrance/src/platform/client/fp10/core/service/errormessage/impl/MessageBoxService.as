package platform.client.fp10.core.service.errormessage.impl {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.IMessageBox;
  import platform.client.fp10.core.service.errormessage.errors.ErrorType;

  public class MessageBoxService implements IErrorMessageService {
    private var osgi:OSGi;
    private var window:IMessageBox;

    public function MessageBoxService(param1:OSGi) {
      super();
      this.osgi = param1;
      this.window = new DefaultMessageWindow();
    }

    public function showMessage(param1:ErrorType) : void {
      var local2:IDisplay = IDisplay(this.osgi.getService(IDisplay));
      local2.stage.addChild(this.window.getDisplayObject(param1));
    }

    public function hideMessage() : void {
      this.window.hide();
    }

    public function setMessageBox(param1:IMessageBox) : void {
      this.window = param1;
    }
  }
}
