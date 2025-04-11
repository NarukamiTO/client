package alternativa.tanks.gui.presents {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.IModalLoaderService;
  import controls.base.DefaultButtonBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import forms.alert.AlertDialogWindow;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class NewPresentsAlert extends AlertDialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    private static var bitmapDataClass:Class = NewPresentsAlert_bitmapDataClass;
    private static var bitmapData:BitmapData = Bitmap(new bitmapDataClass()).bitmapData;

    private var acceptButton:DefaultButtonBase;

    public function NewPresentsAlert() {
      super(localeService.getText(TanksLocale.TEXT_HEADER_NEW_PRESENTS_ALERT),localeService.getText(TanksLocale.TEXT_CLOSE_LABEL));
      var local1:Bitmap = new Bitmap(bitmapData);
      setContentPlaceSize(400,240);
      _contentPlace.addChild(local1);
      local1.x = (_contentPlace.width - local1.width) / 2;
      local1.y = (_contentPlace.height - local1.height) / 2;
      this.acceptButton = new DefaultButtonBase();
      this.acceptButton.label = localeService.getText(TanksLocale.TEXT_NEW_PRESENTS_ALERT_ACCEPT_BUTTON);
      var local2:int = Math.max(this.acceptButton.width,_cancelButton.width);
      this.acceptButton.x = (_buttonPlace.width - local2) / 2;
      this.acceptButton.width = local2;
      _cancelButton.x = _buttonPlace.width - local2;
      _cancelButton.width = local2;
      _buttonPlace.addChild(this.acceptButton);
      _cancelButton.addEventListener(MouseEvent.CLICK,this.cancel);
      this.acceptButton.addEventListener(MouseEvent.CLICK,this.accept);
      enqueueDialog();
    }

    private function accept(param1:MouseEvent) : void {
      modalLoaderService.show();
      dispatchEvent(new NewPresentsAlertEvent(NewPresentsAlertEvent.ACCEPT));
      this.destroyAlert();
    }

    private function cancel(param1:MouseEvent) : void {
      dispatchEvent(new NewPresentsAlertEvent(NewPresentsAlertEvent.CANCEL));
      this.destroyAlert();
    }

    private function destroyAlert() : void {
      _cancelButton.removeEventListener(MouseEvent.CLICK,this.cancel);
      this.acceptButton.removeEventListener(MouseEvent.CLICK,this.accept);
      destroy();
    }
  }
}
