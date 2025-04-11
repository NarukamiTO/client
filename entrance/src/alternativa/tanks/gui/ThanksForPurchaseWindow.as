package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.controls.OrderingLine;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class ThanksForPurchaseWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    private static const WINDOW_SHADOW_OFFSET:int = 5;
    private static const WIDTH:int = 270;
    private static const WINDOW_MARGIN:int = 7 + WINDOW_SHADOW_OFFSET;
    private static const IMAGE_MARGIN:int = 9;
    private static const TEXT_INDENT:int = 33;

    private var closeButton:DefaultButtonBase;
    private var window:TankWindow;
    private var crystalsInfoBox:TankWindowInner;
    private var emailBlock:EmailBlock;
    private var isEmailBlockVisible:Boolean;

    public function ThanksForPurchaseWindow(param1:BitmapData, param2:Vector.<GoodInfoData>, param3:Boolean) {
      var local6:TankWindowInner = null;
      this.window = new TankWindow();
      super();
      this.isEmailBlockVisible = param3;
      var local4:int = WINDOW_MARGIN * 2 + IMAGE_MARGIN * 2 + param1.width;
      this.createCrystalsInfoBox(local4,param1,param2);
      this.window.addChild(this.crystalsInfoBox);
      this.crystalsInfoBox.x = WINDOW_MARGIN;
      this.crystalsInfoBox.y = WINDOW_MARGIN;
      var local5:int = this.crystalsInfoBox.y + this.crystalsInfoBox.height + 9;
      if(param3) {
        local6 = this.createInfoMessageBox(local4 - 2 * WINDOW_MARGIN);
        this.window.addChild(local6);
        local6.x = WINDOW_MARGIN;
        local6.y = local5;
        local5 = local6.y + local6.height + 10;
        this.emailBlock = new EmailBlock(local4,WINDOW_MARGIN);
        this.emailBlock.y = local5;
        this.window.addChild(this.emailBlock);
        local5 = this.emailBlock.y + this.emailBlock.height + 10;
      }
      this.closeButton = this.createCloseButton();
      this.closeButton.y = local5;
      this.closeButton.enable = !param3;
      this.centerAlign(this.closeButton,local4);
      this.window.addChild(this.closeButton);
      this.window.height = this.closeButton.y + this.closeButton.height + 6 + WINDOW_SHADOW_OFFSET;
      this.window.width = local4;
      addChild(this.window);
    }

    private function createInfoMessageBox(param1:int) : TankWindowInner {
      var local2:int = 0;
      var local4:LabelBase = null;
      local2 = 4;
      var local3:int = 7;
      local4 = new LabelBase();
      local4.wordWrap = false;
      local4.multiline = true;
      local4.align = TextFormatAlign.LEFT;
      local4.text = localeService.getText(TanksLocale.TEXT_THANKS_FOR_PURCHASE_INFO_ABOUT_EMAIL);
      local4.size = 12;
      local4.color = ColorConstants.GREEN_LABEL;
      local4.selectable = false;
      local4.x = TEXT_INDENT;
      local4.y = local2;
      var local5:TextFormat = local4.getTextFormat();
      local5.leading = 3;
      local4.setTextFormat(local5);
      var local6:TankWindowInner = new TankWindowInner(param1,0,TankWindowInner.GREEN);
      local6.addChild(local4);
      local6.height = local2 + local3 + local4.height;
      return local6;
    }

    private function createCrystalsInfoBox(param1:int, param2:BitmapData, param3:Vector.<GoodInfoData>) : void {
      var local5:GoodInfoData = null;
      this.crystalsInfoBox = new TankWindowInner(param1 - WINDOW_MARGIN * 2,0,TankWindowInner.GREEN);
      var local4:Bitmap = new Bitmap(param2);
      local4.x = (this.crystalsInfoBox.width - local4.width) / 2;
      local4.y = this.crystalsInfoBox.height + WINDOW_MARGIN;
      this.crystalsInfoBox.addChild(local4);
      for each(local5 in param3) {
        this.addNote(local5.name,local5.count);
      }
      this.crystalsInfoBox.height += WINDOW_MARGIN;
    }

    private function addNote(param1:String, param2:int) : void {
      var local3:OrderingLine = null;
      if(param2 > 0) {
        local3 = new OrderingLine(WIDTH,param1,param2);
        local3.x = TEXT_INDENT;
        local3.y = this.crystalsInfoBox.height - 7;
        this.crystalsInfoBox.addChild(local3);
      }
    }

    private function createCloseButton() : DefaultButtonBase {
      var local1:DefaultButtonBase = new DefaultButtonBase();
      local1.label = localeService.getText(TanksLocale.TEXT_FREE_BONUSES_WINDOW_BUTTON_CLOSE_TEXT);
      return local1;
    }

    public function addInDialogLayer() : void {
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      addEventListener(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.onEmailValidationEvent);
      if(paymentDisplayService.isPaymentDisplayed()) {
        dialogService.addDialog(this);
      } else {
        dialogService.enqueueDialog(this);
      }
    }

    private function onEmailValidationEvent(param1:EmailBlockValidationEvent) : void {
      this.closeButton.enable = param1.isValid;
    }

    override protected function confirmationKeyPressed() : void {
      if(this.closeButton.enable) {
        this.onCloseButtonClick();
      }
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      removeEventListener(EmailBlockValidationEvent.EMAIL_VALIDATED_EVENT,this.onEmailValidationEvent);
      dialogService.removeDialog(this);
      dispatchEvent(new Event(Event.CANCEL));
    }

    public function get hasEmailBlock() : Boolean {
      return this.isEmailBlockVisible;
    }

    public function get email() : String {
      return this.emailBlock.email;
    }

    private function centerAlign(param1:DisplayObject, param2:Number) : void {
      param1.x = (param2 - param1.width) / 2;
    }

    public function destroy() : void {
      if(Boolean(this.emailBlock)) {
        this.emailBlock.destroy();
        this.emailBlock = null;
      }
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
