package alternativa.tanks.gui.present.give {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindow;
  import controls.TextArea;
  import controls.ValidationIcon;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;

  public class PresentPrepareWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const MAX_MESSAGE_LENGTH:int = 350;
    private static const CHECK_DELAY_MS:int = 600;
    private static const OFFSET:int = 11;
    private static const SPACING:int = 5;

    private var window:TankWindow = new TankWindow(440,200);
    private var messageTextArea:TextArea;
    private var uidInput:TankInputBase;
    private var uidHintLabel:LabelBase;
    private var sendButton:DefaultButtonBase;
    private var isUidValid:Boolean;
    private var uid:String;
    private var uidValidationIcon:ValidationIcon;
    private var uidCheckTimeOut:uint;

    public function PresentPrepareWindow() {
      super();
      addChild(this.window);
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onStageKeyUp);
      var local1:int = OFFSET;
      this.createMessageText(local1);
      local1 += this.messageTextArea.height + SPACING;
      this.createUidInput(local1);
      local1 += this.uidInput.height + SPACING;
      this.createButtons(local1);
      dialogService.addDialog(this);
    }

    private function createButtons(param1:int) : void {
      this.sendButton = new DefaultButtonBase();
      this.sendButton.label = localeService.getText(TanksLocale.TEXT_SEND_PRESENT_BUTTON);
      this.sendButton.x = OFFSET;
      this.sendButton.y = param1;
      this.sendButton.addEventListener(MouseEvent.CLICK,this.onSendClick);
      this.sendButton.enable = false;
      this.window.addChild(this.sendButton);
      var local2:DefaultButtonBase = new DefaultButtonBase();
      local2.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_CANCEL);
      local2.x = OFFSET;
      local2.y = param1;
      local2.addEventListener(MouseEvent.CLICK,this.onCancelClick);
      this.window.addChild(local2);
      var local3:int = Math.max(this.sendButton.width,local2.width);
      this.sendButton.width = local3;
      local2.width = local3;
      var local4:int = this.sendButton.height + 2 * SPACING;
      var local5:int = (width - 2 * local3 - local4) / 2;
      this.sendButton.x = local5;
      local2.x = width - local3 - local5;
    }

    private function createUidInput(param1:int) : void {
      this.uidInput = new TankInputBase();
      this.uidInput.maxChars = 20;
      this.uidInput.x = OFFSET;
      this.uidInput.y = param1;
      this.uidInput.width = this.window.width - 2 * OFFSET;
      this.uidInput.addEventListener(FocusEvent.FOCUS_OUT,this.onUidSearchInputFocusOut);
      this.uidInput.textField.addEventListener(Event.CHANGE,this.onUidInputChanged);
      this.uidInput.addEventListener(KeyboardEvent.KEY_UP,this.onEnterPressed);
      this.window.addChild(this.uidInput);
      this.uidHintLabel = new TypingHintLabel(this.uidInput.textField);
      this.uidHintLabel.text = localeService.getText(TanksLocale.TEXT_PRESENT_RECIPIENT_NAME);
      this.uidHintLabel.x = this.uidInput.x + SPACING;
      this.uidHintLabel.y = this.uidInput.y + SPACING;
      this.window.addChild(this.uidHintLabel);
      this.uidValidationIcon = new ValidationIcon();
      this.window.addChild(this.uidValidationIcon);
      this.uidValidationIcon.x = this.uidInput.x + this.uidInput.width - this.uidValidationIcon.width - 15;
      this.uidValidationIcon.y = param1 + SPACING;
    }

    private function createMessageText(param1:int) : void {
      this.messageTextArea = new TextArea();
      this.messageTextArea.maxChars = MAX_MESSAGE_LENGTH;
      this.messageTextArea.height = 106;
      this.messageTextArea.width = this.window.width - 2 * OFFSET;
      this.messageTextArea.x = OFFSET;
      this.messageTextArea.y = param1;
      this.messageTextArea.tf.addEventListener(Event.CHANGE,this.onMessageChanged);
      this.window.addChild(this.messageTextArea);
      var local2:LabelBase = new TypingHintLabel(this.messageTextArea.tf);
      local2.text = localeService.getText(TanksLocale.TEXT_TYPE_MESSAGE_WITH_PRESENT);
      local2.x = this.messageTextArea.x + SPACING;
      local2.y = this.messageTextArea.y + SPACING;
      this.window.addChild(local2);
    }

    private function onEnterPressed(param1:KeyboardEvent) : void {
      if(AlertUtils.isConfirmationKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.trySendPresent();
      }
    }

    private function onStageKeyUp(param1:KeyboardEvent) : void {
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.cancelDialog();
      }
    }

    private function onUidInputChanged(param1:Event) : void {
      this.isUidValid = false;
      this.sendButton.enable = false;
      this.uidValidationIcon.startProgress();
      if(this.uidInput.value.length > 0) {
        this.uidHintLabel.visible = false;
      }
      clearTimeout(this.uidCheckTimeOut);
      this.updateSendButton();
      this.uidCheckTimeOut = setTimeout(this.checkUid,CHECK_DELAY_MS);
    }

    private function onMessageChanged(param1:Event) : void {
      this.updateSendButton();
    }

    private function onSendClick(param1:MouseEvent) : void {
      this.trySendPresent();
    }

    private function trySendPresent() : void {
      if(this.canSendPresent()) {
        this.destroy();
        dispatchEvent(new SendPresentEvent(SendPresentEvent.SEND_PRESENT,this.uid,this.messageTextArea.text));
      }
    }

    private function onCancelClick(param1:MouseEvent) : void {
      this.cancelDialog();
    }

    private function cancelDialog() : void {
      dispatchEvent(new Event(Event.CANCEL));
      this.destroy();
    }

    private function destroy() : void {
      this.sendButton.removeEventListener(MouseEvent.CLICK,this.onSendClick);
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onStageKeyUp);
      this.uidInput.removeEventListener(KeyboardEvent.KEY_UP,this.onEnterPressed);
      dialogService.removeDialog(this);
    }

    private function checkUid() : void {
      if(this.uidInput.value.length == 0) {
        this.uidValidationIcon.turnOff();
        this.uidInput.validValue = true;
      } else {
        this.uid = this.uidInput.value;
        dispatchEvent(new CheckUidEvent(this.uid));
      }
    }

    public function setUidAvailable(param1:Boolean) : void {
      this.uidInput.validValue = param1;
      this.isUidValid = param1;
      if(param1) {
        this.uidValidationIcon.markAsValid();
        this.updateSendButton();
      } else {
        this.uidValidationIcon.markAsInvalid();
      }
    }

    private function updateSendButton() : void {
      this.sendButton.enable = this.canSendPresent();
    }

    private function canSendPresent() : Boolean {
      return this.isUidValid && this.isMessageNotEmpty();
    }

    private function isMessageNotEmpty() : Boolean {
      return this.messageTextArea.text.length > 0;
    }

    private function onUidSearchInputFocusOut(param1:Event) : void {
      if(this.uidInput.value.length == 0) {
        this.uidHintLabel.visible = true;
        this.uidValidationIcon.turnOff();
        this.uidInput.validValue = true;
        this.updateSendButton();
      }
    }
  }
}
