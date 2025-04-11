package alternativa.tanks.gui.upgrade {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.DefaultButtonBase;
  import flash.events.MouseEvent;
  import forms.base.BaseForm;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class UpgradeWindowBase extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const VERTICAL_MARGIN:int = 8;
    private static const HORIZONTAL_MARGIN:int = 12;

    private var baseForm:BaseForm;

    protected var cancelButton:DefaultButtonBase;

    public function UpgradeWindowBase(param1:int, param2:int) {
      super();
      this.baseForm = new BaseForm(param1,param2);
      addChild(this.baseForm);
      this.baseForm.window.setHeaderId(TanksLocale.TEXT_HEADER_UPGRADE);
      this.cancelButton = new DefaultButtonBase();
      this.cancelButton.width = 95;
      this.cancelButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_CLOSE_TEXT);
      this.cancelButton.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      this.baseForm.window.addChild(this.cancelButton);
      this.align();
    }

    private function align() : void {
      this.cancelButton.y = this.baseForm.window.height - 5 - this.cancelButton.height - VERTICAL_MARGIN;
      this.cancelButton.x = this.baseForm.window.width - this.cancelButton.width - HORIZONTAL_MARGIN;
    }

    override public function set width(param1:Number) : void {
      this.baseForm.window.width = int(param1);
      this.align();
    }

    override public function set height(param1:Number) : void {
      this.baseForm.window.height = int(param1);
      this.align();
    }

    private function onMouseClick(param1:MouseEvent) : void {
      this.onClose();
    }

    override protected function cancelKeyPressed() : void {
      this.onClose();
    }

    protected function onClose() : void {
    }

    protected function removeEvents() : void {
      this.cancelButton.removeEventListener(MouseEvent.CLICK,this.onClose);
    }
  }
}
