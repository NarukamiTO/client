package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class EmailReminderWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static var enterEmailReminderBitmapDataClass:Class = EmailReminderWindow_enterEmailReminderBitmapDataClass;
    private static var enterEmailReminderBitmapData:BitmapData = Bitmap(new enterEmailReminderBitmapDataClass()).bitmapData;
    private static var confirmEmailReminderBitmapDataClass:Class = EmailReminderWindow_confirmEmailReminderBitmapDataClass;

    protected static var confirmEmailReminderBitmapData:BitmapData = Bitmap(new confirmEmailReminderBitmapDataClass()).bitmapData;

    protected static const WINDOW_WIDTH:int = 350;
    protected static const WINDOW_MARGIN:int = 11;
    protected static const GAP:int = 5;

    protected var window:TankWindowWithHeader;
    protected var labelInnerWindow:TankWindowInner;
    protected var closeButton:DefaultButtonBase;

    private var imageInnerWindow:TankWindowInner;
    private var emailBlock:EmailBlock;
    private var saveButton:DefaultButtonBase;

    public function EmailReminderWindow() {
      super();
      this.addWindow();
    }

    public function showEnterEmailReminder() : void {
      this.addCautionImage(enterEmailReminderBitmapData);
      this.addCautionLabel(localeService.getText(TanksLocale.TEXT_NEED_OF_EMAIL_SET));
      this.addOtherElements();
      this.show();
    }

    public function showConfirmEmailReminder(param1:String) : void {
      this.addCautionImage(confirmEmailReminderBitmapData);
      this.addCautionLabel(localeService.getText(TanksLocale.TEXT_NEED_OF_EMAIL_CONFIRMATION));
      this.addOtherElements();
      this.emailBlock.email = param1;
      this.saveButton.enable = true;
      this.show();
    }

    public function showNeedEmailAlert() : void {
      this.addCautionImage(enterEmailReminderBitmapData);
      this.addCautionLabel(localeService.getText(TanksLocale.TEXT_NEED_EMAIL_ALERT_MESSAGE));
      this.addCloseButton(this.labelInnerWindow);
      this.setWindowSize();
      this.show();
    }

    private function addOtherElements() : void {
      this.addEmailBlock();
      this.addCloseButton(this.emailBlock);
      this.addSaveButton();
      this.setWindowSize();
    }

    private function addWindow() : void {
      this.window = new TankWindowWithHeader(localeService.getText(TanksLocale.TEXT_HEADER_SECURITY));
      this.window.width = WINDOW_WIDTH;
      addChild(this.window);
    }

    protected function addCautionImage(param1:BitmapData) : void {
      var local2:Bitmap = null;
      local2 = new Bitmap(param1);
      local2.x = WINDOW_MARGIN;
      this.imageInnerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.imageInnerWindow.x = WINDOW_MARGIN;
      this.imageInnerWindow.y = WINDOW_MARGIN;
      this.imageInnerWindow.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this.imageInnerWindow.height = local2.height;
      this.window.addChild(this.imageInnerWindow);
      this.imageInnerWindow.addChild(local2);
    }

    protected function addCautionLabel(param1:String) : void {
      this.labelInnerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.labelInnerWindow.x = WINDOW_MARGIN;
      this.labelInnerWindow.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this.window.addChild(this.labelInnerWindow);
      var local2:LabelBase = new LabelBase();
      local2.wordWrap = true;
      local2.multiline = true;
      local2.htmlText = param1;
      local2.size = 12;
      local2.x = WINDOW_MARGIN;
      local2.y = WINDOW_MARGIN;
      local2.width = WINDOW_WIDTH - WINDOW_MARGIN * 4;
      this.labelInnerWindow.addChild(local2);
      this.labelInnerWindow.height = local2.height + WINDOW_MARGIN * 2;
      this.labelInnerWindow.y = this.imageInnerWindow.y + this.imageInnerWindow.height + GAP;
    }

    private function addEmailBlock() : void {
      this.emailBlock = new EmailBlock(WINDOW_WIDTH,WINDOW_MARGIN);
      this.emailBlock.addEventListener(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.onEmailValidationEvent);
      this.emailBlock.y = this.labelInnerWindow.y + this.labelInnerWindow.height + GAP;
      this.window.addChild(this.emailBlock);
    }

    private function onEmailValidationEvent(param1:EmailBlockValidationEvent) : void {
      this.saveButton.enable = param1.isValid;
    }

    private function addCloseButton(param1:DisplayObject) : void {
      this.closeButton = new DefaultButtonBase();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = WINDOW_WIDTH - WINDOW_MARGIN - this.closeButton.width;
      this.closeButton.y = param1.y + param1.height + GAP;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.window.addChild(this.closeButton);
    }

    private function addSaveButton() : void {
      this.saveButton = new DefaultButtonBase();
      this.saveButton.enable = false;
      this.saveButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_SAVE_TEXT);
      this.saveButton.x = this.closeButton.x - WINDOW_MARGIN - this.saveButton.width;
      this.saveButton.y = this.closeButton.y;
      this.saveButton.addEventListener(MouseEvent.CLICK,this.onSaveButtonClick);
      this.window.addChild(this.saveButton);
    }

    private function onSaveButtonClick(param1:MouseEvent = null) : void {
      var local2:String = this.emailBlock.email;
      dispatchEvent(local2.indexOf("*") != -1 ? new EnterEmailReminderWindowEvent(EnterEmailReminderWindowEvent.EMAIL_CONFIRMATION) : new EnterEmailReminderWindowEvent(EnterEmailReminderWindowEvent.EMAIL_SAVING_AND_CONFIRMATION,local2));
      this.onCloseButtonClick();
    }

    protected function show() : void {
      dialogService.addDialog(this);
    }

    protected function setWindowSize() : void {
      this.window.height = this.closeButton.y + this.closeButton.height + WINDOW_MARGIN;
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseButtonClick();
    }

    override protected function confirmationKeyPressed() : void {
      if(this.saveButton.enable) {
        this.onSaveButtonClick();
      }
    }

    protected function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      if(Boolean(this.saveButton)) {
        this.saveButton.removeEventListener(MouseEvent.CLICK,this.onSaveButtonClick);
      }
      if(Boolean(this.emailBlock)) {
        this.emailBlock.removeEventListener(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.onEmailValidationEvent);
        this.emailBlock.destroy();
        this.emailBlock = null;
      }
      dispatchEvent(new EnterEmailReminderWindowEvent(EnterEmailReminderWindowEvent.WINDOW_CLOSING));
      dialogService.removeDialog(this);
    }

    public function showEmailIsBusy(param1:String) : void {
      this.emailBlock.showEmailIsBusy(param1);
    }

    public function showEmailIsForbidden(param1:String) : void {
      this.emailBlock.showEmailIsForbidden(param1);
    }

    public function showEmailIsFree(param1:String) : void {
      this.emailBlock.showEmailIsFree(param1);
    }
  }
}
