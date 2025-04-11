package alternativa.tanks.view.forms {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.IPasswordParamsService;
  import alternativa.tanks.view.bubbles.Bubble;
  import alternativa.tanks.view.bubbles.EntranceBubbleFactory;
  import alternativa.tanks.view.events.SendChangeUidAndPasswordEvent;
  import alternativa.tanks.view.events.SendChangeUidEvent;
  import alternativa.tanks.view.forms.commons.ChangeUidInputField;
  import alternativa.tanks.view.forms.primivites.Alert;
  import alternativa.tanks.view.forms.primivites.ValidationIcon;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFormatAlign;
  import forms.TankWindowWithHeader;
  import forms.events.LoginFormEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ChangeUidForm extends DiscreteSprite {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var passwordParamsService:IPasswordParamsService;

    private static var changeUidBitmapDataClass:Class = ChangeUidForm_changeUidBitmapDataClass;
    private static var changeUidBitmapData:BitmapData = Bitmap(new changeUidBitmapDataClass()).bitmapData;

    private static const WINDOW_WIDTH:int = 400;
    private static const WINDOW_MARGIN:int = 11;
    private static const GAP:int = 5;
    private static const INPUTS_LEFT_MARGIN:int = 125;

    private var _window:TankWindowWithHeader;
    private var _windowInner:TankWindowInner;
    private var _uidInputField:ChangeUidInputField;
    private var _newPasswordInputField:TankInputBase;
    private var _repeatPasswordInputField:TankInputBase;
    private var _newPasswordCheckIcon:ValidationIcon;
    private var _repeatPasswordCheckIcon:ValidationIcon;
    private var _passwordIsTooEasyBubble:Bubble;
    private var _passwordsDoNotMatchBubble:Bubble;
    private var _saveUidButton:DefaultButtonBase;
    private var _enablePasswordInput:Boolean;

    public function ChangeUidForm(param1:Boolean) {
      super();
      this._enablePasswordInput = param1;
      this.init();
    }

    public function init() : void {
      this.addWindow();
      this.addImageAndLabel();
      this.addUidInputField();
      if(this._enablePasswordInput) {
        this.addPasswordInputFields();
      }
      this.addSaveUidButtonAndSetWindowHeight();
      addChild(this._uidInputField);
      this.addEventListeners();
      this.onResize();
    }

    private function addWindow() : void {
      this._window = new TankWindowWithHeader(localeService.getText(TanksLocale.TEXT_HEADER_CHANGE_UID));
      this._window.width = WINDOW_WIDTH;
      addChild(this._window);
    }

    private function addImageAndLabel() : void {
      this._windowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this._windowInner.x = WINDOW_MARGIN;
      this._windowInner.y = WINDOW_MARGIN;
      this._windowInner.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this._window.addChild(this._windowInner);
      var local1:Bitmap = new Bitmap(changeUidBitmapData);
      local1.x = this._windowInner.width - local1.width >> 1;
      this._windowInner.addChild(local1);
      var local2:LabelBase = new LabelBase();
      local2.align = TextFormatAlign.CENTER;
      local2.wordWrap = true;
      local2.multiline = true;
      local2.text = localeService.getText(TanksLocale.TEXT_CHANGE_UID_FORM_EXPLANATION_TEXT);
      local2.size = 12;
      local2.x = WINDOW_MARGIN;
      local2.y = local1.y + local1.height + GAP;
      local2.width = WINDOW_WIDTH - WINDOW_MARGIN * 4;
      this._windowInner.addChild(local2);
      this._windowInner.height = local2.y + local2.height + GAP;
    }

    private function addUidInputField() : void {
      this._uidInputField = new ChangeUidInputField();
      this._uidInputField.setLabelText(localeService.getText(TanksLocale.TEXT_CHANGE_UID_FORM_NEW_UID_TEXT));
      addChild(this._uidInputField);
      this._uidInputField.width = this._window.width - INPUTS_LEFT_MARGIN - 2 * WINDOW_MARGIN;
      this._uidInputField.x = WINDOW_MARGIN + INPUTS_LEFT_MARGIN;
      this._uidInputField.y = this._windowInner.y + this._windowInner.height + GAP;
    }

    private function addPasswordInputFields() : void {
      this._newPasswordInputField = new TankInputBase();
      this._newPasswordInputField.label = localeService.getText(TanksLocale.TEXT_CHANGE_UID_FORM_NEW_PASSWORD_TEXT);
      this._newPasswordInputField.hidden = true;
      this._newPasswordInputField.maxChars = passwordParamsService.maxPasswordLength;
      this._repeatPasswordInputField = new TankInputBase();
      this._repeatPasswordInputField.label = localeService.getText(TanksLocale.TEXT_CHANGE_UID_FORM_REPEAT_PASSWORD_TEXT);
      this._repeatPasswordInputField.hidden = true;
      this._repeatPasswordInputField.maxChars = passwordParamsService.maxPasswordLength;
      this._newPasswordCheckIcon = new ValidationIcon();
      this._repeatPasswordCheckIcon = new ValidationIcon();
      this._passwordIsTooEasyBubble = EntranceBubbleFactory.passwordIsTooEasyBubble();
      this._passwordsDoNotMatchBubble = EntranceBubbleFactory.passwordsDoNotMatchBubble();
      addChild(this._repeatPasswordInputField);
      addChild(this._repeatPasswordCheckIcon);
      addChild(this._newPasswordInputField);
      addChild(this._newPasswordCheckIcon);
      this._newPasswordInputField.width = this._window.width - INPUTS_LEFT_MARGIN - 2 * WINDOW_MARGIN;
      this._newPasswordInputField.x = WINDOW_MARGIN + INPUTS_LEFT_MARGIN;
      this._newPasswordInputField.y = this._uidInputField.y + this._uidInputField.height + GAP;
      this._repeatPasswordInputField.width = this._window.width - INPUTS_LEFT_MARGIN - 2 * WINDOW_MARGIN;
      this._repeatPasswordInputField.x = this._newPasswordInputField.x;
      this._repeatPasswordInputField.y = this._newPasswordInputField.y + this._repeatPasswordInputField.height + GAP;
      this._newPasswordCheckIcon.x = this._newPasswordInputField.x + this._newPasswordInputField.textField.width - 20;
      this._newPasswordCheckIcon.y = this._newPasswordInputField.y + 7;
      this._repeatPasswordCheckIcon.x = this._repeatPasswordInputField.x + this._repeatPasswordInputField.textField.width - 20;
      this._repeatPasswordCheckIcon.y = this._repeatPasswordInputField.y + 7;
    }

    private function addSaveUidButtonAndSetWindowHeight() : void {
      this._saveUidButton = new DefaultButtonBase();
      this._saveUidButton.enable = false;
      this._saveUidButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_SAVE_TEXT);
      addChildAt(this._saveUidButton,1);
      this._saveUidButton.x = this._uidInputField.x + this._uidInputField.width - this._saveUidButton.width;
      if(this._enablePasswordInput) {
        this._saveUidButton.y = this._repeatPasswordInputField.y + this._repeatPasswordInputField.height + GAP;
      } else {
        this._saveUidButton.y = this._uidInputField.y + this._uidInputField.height + GAP;
      }
      this._window.height = this._saveUidButton.y + this._saveUidButton.height + WINDOW_MARGIN;
    }

    private function onResize(param1:Event = null) : void {
      this.x = int((display.stage.stageWidth - this._window.width) / 2);
      this.y = int((display.stage.stageHeight - this._window.height) / 2);
    }

    private function addEventListeners() : void {
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.addEventListener(Event.RESIZE,this.onResize);
      this._uidInputField.addEventListener(Event.CHANGE,this.onChangeUidInputField);
      this._saveUidButton.addEventListener(MouseEvent.CLICK,this.onSaveUidButtonClick);
      if(this._enablePasswordInput) {
        this._newPasswordInputField.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onPasswordChanged);
        this._repeatPasswordInputField.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onPasswordChanged);
      }
    }

    private function removeEventListeners() : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
      this._uidInputField.removeEventListener(Event.CHANGE,this.onChangeUidInputField);
      this._saveUidButton.removeEventListener(MouseEvent.CLICK,this.onSaveUidButtonClick);
      if(this._enablePasswordInput) {
        this._newPasswordInputField.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onPasswordChanged);
        this._repeatPasswordInputField.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onPasswordChanged);
      }
    }

    private function onRemoveFromStage(param1:Event) : void {
      this.removeEventListeners();
    }

    private function onChangeUidInputField(param1:Event) : void {
      this.updateEnableSaveUidButton();
    }

    private function updateEnableSaveUidButton() : void {
      var local1:Boolean = false;
      if(this._enablePasswordInput) {
        this._newPasswordInputField._label.visible = this._repeatPasswordInputField._label.visible = !this._uidInputField.isOpenFreeUidsForm();
        if(this._newPasswordInputField.textField.text == "" && this._repeatPasswordInputField.textField.text == "") {
          local1 = true;
        } else {
          local1 = this._newPasswordInputField.textField.text == this._repeatPasswordInputField.textField.text && !passwordParamsService.isPasswordForbidden(this._newPasswordInputField.textField.text);
        }
        this._saveUidButton.enable = this._uidInputField.isUidValid() && local1;
      } else {
        this._saveUidButton.enable = this._uidInputField.isUidValid();
      }
    }

    private function onPasswordChanged(param1:LoginFormEvent) : void {
      this._passwordIsTooEasyBubble.hide();
      this._newPasswordInputField.validValue = true;
      this._newPasswordCheckIcon.markAsValid();
      if(Boolean(passwordParamsService.isPasswordForbidden(this._newPasswordInputField.textField.text)) && this._newPasswordInputField.textField.text.length != 0) {
        this._newPasswordCheckIcon.markAsInvalid();
        this._newPasswordInputField.validValue = false;
        this._newPasswordCheckIcon.addChild(this._passwordIsTooEasyBubble);
      }
      if(this._newPasswordInputField.textField.text.length == 0) {
        this._newPasswordCheckIcon.turnOff();
      }
      this._repeatPasswordInputField.validValue = true;
      this._repeatPasswordCheckIcon.markAsValid();
      this._passwordsDoNotMatchBubble.hide();
      if(this._newPasswordInputField.textField.text != this._repeatPasswordInputField.textField.text && this._repeatPasswordInputField.textField.text.length != 0) {
        this._repeatPasswordCheckIcon.markAsInvalid();
        this._repeatPasswordInputField.validValue = false;
        if(!this._passwordIsTooEasyBubble.parent) {
          this._repeatPasswordCheckIcon.addChild(this._passwordsDoNotMatchBubble);
        }
      }
      if(this._repeatPasswordInputField.textField.text.length == 0) {
        this._repeatPasswordCheckIcon.turnOff();
      }
      this.updateEnableSaveUidButton();
    }

    private function onSaveUidButtonClick(param1:MouseEvent) : void {
      this._saveUidButton.enable = false;
      if(this._enablePasswordInput) {
        dispatchEvent(new SendChangeUidAndPasswordEvent(this._uidInputField.callsign,this._newPasswordInputField.value));
      } else {
        dispatchEvent(new SendChangeUidEvent(this._uidInputField.callsign));
      }
    }

    public function showAlertPasswordIsIncorrect() : void {
      this.clearPasswordInputs();
      parent.addChild(new Alert(Alert.ERROR_PASSWORD_CHANGE));
    }

    private function clearPasswordInputs() : void {
      this._newPasswordInputField.clear();
      this._repeatPasswordInputField.clear();
      this._newPasswordCheckIcon.turnOff();
      this._repeatPasswordCheckIcon.turnOff();
      this.updateEnableSaveUidButton();
    }
  }
}
