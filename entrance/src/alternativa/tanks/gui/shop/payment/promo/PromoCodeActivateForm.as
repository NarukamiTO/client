package alternativa.tanks.gui.shop.payment.promo {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.events.ShopWindowBackButtonEvent;
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import controls.TankWindowInner;
  import controls.ValidationIcon;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInput;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.TextEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.ui.Keyboard;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import utils.tweener.TweenLite;
  import utils.tweener.core.SimpleTimeline;
  import utils.tweener.easing.Elastic;

  public class PromoCodeActivateForm extends PaymentView {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var validateService:IValidateService;

    [Inject]
    public static var display:IDisplay;

    public static const DESCRIPTION_HEIGHT:int = 82;
    public static const MARGIN:int = 8;

    protected static const MAX_LENGTH:int = 50;
    protected static const BLOCK_LENGTH:int = 5;
    protected static const TWEEN_FORCE:int = 100;

    private var codeField:TankInput;
    private var sendButton:DefaultButtonBase;
    private var validationIcon:ValidationIcon;
    private var codeTween:SimpleTimeline;
    private var code:String = "";
    private var descriptionWindow:TankWindowInner;
    private var descriptionLabel:LabelBase;
    private var invalidCodeLabel:LabelBase;

    public function PromoCodeActivateForm() {
      super();
      this.descriptionWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.descriptionWindow.showBlink = true;
      addChild(this.descriptionWindow);
      this.descriptionLabel = this.createDescriptionLabel();
      this.descriptionWindow.addChild(this.descriptionLabel);
      this.codeField = this.createCodeField();
      addChild(this.codeField);
      this.sendButton = this.createSendButton();
      addChild(this.sendButton);
      this.validationIcon = this.createValidationIcon();
      addChild(this.validationIcon);
      this.invalidCodeLabel = this.createInvalidCodeLabel();
      addChild(this.invalidCodeLabel);
    }

    private function createDescriptionLabel() : LabelBase {
      var local1:LabelBase = new LabelBase();
      local1.autoSize = TextFieldAutoSize.NONE;
      local1.multiline = true;
      local1.wordWrap = true;
      local1.htmlText = localeService.getText(TanksLocale.TEXT_PROMO_CODE_DESCRIPTION_TEXT);
      return local1;
    }

    protected function createCodeField() : TankInput {
      var local1:TankInput = new TankInput();
      local1.align = TextFormatAlign.CENTER;
      local1.restrict = ValidateService.PROMO_CODE_PATTERN;
      return local1;
    }

    protected function createSendButton() : DefaultButtonBase {
      var local1:DefaultButtonBase = new DefaultButtonBase();
      local1.tabEnabled = false;
      local1.enable = false;
      local1.label = localeService.getText(TanksLocale.TEXT_BUG_REPORT_BUTTON_SEND_TEXT);
      return local1;
    }

    protected function createValidationIcon() : ValidationIcon {
      var local1:ValidationIcon = new ValidationIcon();
      local1.fadeTime = 0.2;
      local1.mouseEnabled = false;
      local1.mouseChildren = false;
      return local1;
    }

    protected function createInvalidCodeLabel() : LabelBase {
      var local1:LabelBase = new LabelBase();
      local1.visible = false;
      local1.text = localeService.getText(TanksLocale.TEXT_PROMO_CODE_INVALID_LABEL);
      return local1;
    }

    private function onBackButtonClick(param1:Event) : void {
      display.stage.focus = null;
    }

    private function getCodeTween() : SimpleTimeline {
      if(!this.codeTween) {
        this.codeTween = new SimpleTimeline();
        this.codeTween.insert(TweenLite.to(this.codeField.textField,0.2,{
          "x":TWEEN_FORCE,
          "ease":Elastic.easeInOut
        }));
        this.codeTween.insert(TweenLite.to(this.codeField.textField,0.2,{
          "x":0,
          "ease":Elastic.easeInOut
        }));
      }
      return this.codeTween;
    }

    private function textInputHandler(param1:TextEvent = null) : void {
      this.getCodeTween().restart(true);
    }

    private function textEditHandler(param1:Event) : void {
      var local7:String = null;
      this.codeField.validValue = true;
      this.validationIcon.turnOff();
      this.invalidCodeLabel.visible = false;
      var local2:String = "";
      var local3:int = this.codeField.textField.length;
      var local4:int = 0;
      var local5:int = 0;
      var local6:int = local3 - this.codeField.textField.selectionBeginIndex;
      this.code = "";
      while(local4 < local3) {
        local7 = this.codeField.textField.text.charAt(local4).toUpperCase();
        if(local7 != "-") {
          this.code = this.code.concat(local7);
          if(local3 - local4 > 1 && local2.length - BLOCK_LENGTH + 1 >= 0 && (local2.length - local5 + 1) % BLOCK_LENGTH == 0) {
            local7 = local7.concat("-");
            local5++;
          }
          local2 = local2.concat(local7);
        }
        local4++;
      }
      if(local2.charAt(local2.length - 1) == "-") {
        local2 = local2.substr(0,local2.length - 1);
      }
      this.codeField.maxChars = MAX_LENGTH + local5;
      this.codeField.textField.text = local2;
      this.codeField.textField.setSelection(local2.length - local6,local2.length - local6);
      this.sendButton.enable = validateService.isValidPromoCode(this.code);
    }

    private function sendOnEnterHandler(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER) {
        this.sendClickHandler();
      }
    }

    protected function sendClickHandler(param1:MouseEvent = null) : void {
      if(validateService.isValidPromoCode(this.code)) {
        this.validationIcon.startProgress();
        this.sendButton.enable = false;
        this.codeField.enable = false;
        dispatchEvent(new SendPromoCodeEvent(this.getPromoCode()));
      } else {
        this.textInputHandler();
      }
    }

    override public function render(param1:int, param2:int) : void {
      super.render(param1,param2);
      this.getCodeTween().restart(true);
      this.sendButton.enable = validateService.isValidPromoCode(this.code);
      this.descriptionWindow.width = param1;
      this.descriptionWindow.height = DESCRIPTION_HEIGHT;
      this.descriptionLabel.width = param1 - 2 * ShopWindow.WINDOW_PADDING;
      this.descriptionLabel.height = DESCRIPTION_HEIGHT - 2 * ShopWindow.WINDOW_PADDING;
      this.descriptionLabel.x = this.descriptionLabel.y = ShopWindow.WINDOW_PADDING;
      var local3:int = param2 - DESCRIPTION_HEIGHT;
      this.codeField.width = Math.max(this.codeField.textField.textWidth,int(param1 * 0.66));
      this.codeField.x = param1 - this.codeField.width - this.sendButton.width - MARGIN >> 1;
      this.codeField.y = (local3 - this.codeField.height >> 1) + DESCRIPTION_HEIGHT;
      this.sendButton.x = this.codeField.x + this.codeField.width + MARGIN;
      this.sendButton.y = this.codeField.y;
      this.invalidCodeLabel.x = int(this.codeField.x + this.codeField.width / 2) - int(this.invalidCodeLabel.width / 2);
      this.invalidCodeLabel.y = int(this.codeField.y + this.codeField.height + MARGIN);
      var local4:int = this.codeField.height - this.validationIcon.height >> 1;
      this.validationIcon.x = this.codeField.x + this.codeField.width - local4 - this.validationIcon.height;
      this.validationIcon.y = this.codeField.y + local4 + 2;
    }

    override public function postRender() : void {
      super.postRender();
      this.codeField.addEventListener(TextEvent.TEXT_INPUT,this.textInputHandler);
      this.codeField.addEventListener(Event.CHANGE,this.textEditHandler);
      this.codeField.addEventListener(KeyboardEvent.KEY_DOWN,this.sendOnEnterHandler);
      this.sendButton.addEventListener(MouseEvent.CLICK,this.sendClickHandler);
      window.addEventListener(ShopWindowBackButtonEvent.CLICK,this.onBackButtonClick);
    }

    override public function destroy() : void {
      this.codeField.removeEventListener(TextEvent.TEXT_INPUT,this.textInputHandler);
      this.codeField.removeEventListener(Event.CHANGE,this.textEditHandler);
      this.codeField.removeEventListener(KeyboardEvent.KEY_DOWN,this.sendOnEnterHandler);
      this.sendButton.removeEventListener(MouseEvent.CLICK,this.sendClickHandler);
      window.removeEventListener(ShopWindowBackButtonEvent.CLICK,this.onBackButtonClick);
      super.destroy();
    }

    private function getPromoCode() : String {
      return this.code;
    }

    public function activateFailed() : void {
      this.codeField.validValue = false;
      this.codeField.enable = true;
      this.validationIcon.markAsInvalid();
      this.invalidCodeLabel.visible = true;
    }

    public function codeActivatedSuccessful() : void {
      this.codeField.enable = true;
      this.validationIcon.markAsValid();
    }
  }
}
