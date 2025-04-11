package alternativa.tanks.model.item.rename {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.textinputs.PlaceholderInputText;
  import alternativa.tanks.model.useremailandpassword.PasswordService;
  import controls.TankWindowInner;
  import controls.ValidationIcon;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.TankWindowWithHeader;
  import platform.client.models.commons.types.ValidationStatus;
  import projects.tanks.clients.flash.commons.services.validate.IValidateService;
  import projects.tanks.clients.flash.commons.services.validate.ValidateService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck.UidCheckService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class RenameForm extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var uidCheckService:UidCheckService;

    [Inject]
    public static var passwordService:PasswordService;

    [Inject]
    public static var validateService:IValidateService;

    private static const CHECK_ICON_OFFSET:int = 6;
    private static const CHECK_DELAY:int = 500;
    private static const PASSWORD_MAX_LENGTH:int = 20;

    private static var enterEmailReminderBitmapDataClass:Class = RenameForm_enterEmailReminderBitmapDataClass;
    private static var enterEmailReminderBitmapData:BitmapData = Bitmap(new enterEmailReminderBitmapDataClass()).bitmapData;

    protected static const WINDOW_WIDTH:int = 335;
    protected static const WINDOW_MARGIN:int = 11;
    protected static const GAP:int = 5;

    protected var window:TankWindowWithHeader;

    private var newNickname:PlaceholderInputText;
    private var nickanameCheckIcon:ValidationIcon;
    private var nicknameCheckTimeOut:uint;
    private var nickname:String;
    private var nicknameIsValid:Boolean;
    private var currentPassword:PlaceholderInputText;
    private var passwordCheckIcon:ValidationIcon;
    private var passwordCheckTimeOut:uint;
    private var password:String;
    private var passwordIsValid:Boolean;
    private var saveButton:DefaultButtonBase;
    private var closeButton:DefaultButtonBase;
    private var imageInnerWindow:TankWindowInner;
    private var instructionLabel:TankWindowInner;
    private var needPassword:Boolean;

    public function RenameForm(param1:Boolean) {
      super();
      this.needPassword = param1;
      this.addMainInnerWindow();
      this.addInfoImage();
      this.addInstructionLabel();
      this.addNicknameField();
      if(param1) {
        this.addPasswordField();
      }
      this.addSaveButton();
      this.addCloseButton();
      this.window.height = this.saveButton.y + this.saveButton.height + WINDOW_MARGIN;
    }

    public function show() : void {
      dialogService.addDialog(this);
    }

    public function close() : void {
      dialogService.removeDialog(this);
    }

    public function isNeedPassword() : Boolean {
      return this.needPassword;
    }

    public function getPassword() : String {
      return this.currentPassword.value;
    }

    private function calculateYPosition(param1:DisplayObject) : int {
      return param1.y + param1.height + GAP;
    }

    private function addMainInnerWindow() : void {
      this.window = new TankWindowWithHeader(localeService.getText(TanksLocale.TEXT_HEADER_CHANGE_UID));
      this.window.width = WINDOW_WIDTH;
      addChild(this.window);
    }

    private function addInfoImage() : void {
      var local1:Bitmap = new Bitmap(enterEmailReminderBitmapData);
      local1.x = WINDOW_MARGIN;
      this.imageInnerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.imageInnerWindow.x = WINDOW_MARGIN;
      this.imageInnerWindow.y = WINDOW_MARGIN;
      this.imageInnerWindow.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this.imageInnerWindow.height = local1.height;
      this.imageInnerWindow.addChild(local1);
      this.window.addChild(this.imageInnerWindow);
    }

    private function addInstructionLabel() : void {
      this.instructionLabel = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.instructionLabel.x = WINDOW_MARGIN;
      this.instructionLabel.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      var local1:LabelBase = new LabelBase();
      local1.wordWrap = true;
      local1.multiline = true;
      local1.htmlText = localeService.getText(TanksLocale.TEXT_RENAME_FORM_INSTRUCTION);
      local1.size = 12;
      local1.x = WINDOW_MARGIN;
      local1.y = WINDOW_MARGIN;
      local1.width = WINDOW_WIDTH - WINDOW_MARGIN * 4;
      this.instructionLabel.addChild(local1);
      this.instructionLabel.height = local1.height + WINDOW_MARGIN * 2;
      this.instructionLabel.y = this.calculateYPosition(this.imageInnerWindow);
      this.window.addChild(this.instructionLabel);
    }

    private function addNicknameField() : void {
      this.newNickname = this.createPlaceholder(localeService.getText(TanksLocale.TEXT_RENAME_FORM_NEW_UID_INPUT),this.calculateYPosition(this.instructionLabel));
      this.newNickname.validValue = true;
      this.newNickname.maxChars = uidCheckService.getMaxLength();
      this.newNickname.addEventListener(Event.CHANGE,this.onNicknameInputChanged);
      this.nickanameCheckIcon = this.createCheckIcon(this.newNickname);
      this.window.addChild(this.newNickname);
      this.newNickname.addChild(this.nickanameCheckIcon);
    }

    private function addPasswordField() : void {
      this.currentPassword = this.createPlaceholder(localeService.getText(TanksLocale.TEXT_RENAME_FORM_CURRENT_PASSWORD_INPUT),this.calculateYPosition(this.newNickname));
      this.currentPassword.hidden = true;
      this.currentPassword.maxChars = PASSWORD_MAX_LENGTH;
      this.currentPassword.addEventListener(Event.CHANGE,this.onPasswordInputChanged);
      this.passwordCheckIcon = this.createCheckIcon(this.currentPassword);
      this.window.addChild(this.currentPassword);
      this.currentPassword.addChild(this.passwordCheckIcon);
    }

    private function onNicknameInputChanged(param1:Event) : void {
      this.saveButton.enable = false;
      var local2:String = this.newNickname.value;
      if(!validateService.isValidIdentificationStringForRegistration(local2)) {
        this.newNickname.value = local2.replace(ValidateService.NOT_ALLOWED_PATTERN_FOR_REGISTRATION,"");
      }
      this.nickanameCheckIcon.startProgress();
      clearTimeout(this.nicknameCheckTimeOut);
      this.nicknameCheckTimeOut = setTimeout(this.checkUid,CHECK_DELAY);
    }

    private function checkUid() : void {
      if(this.needPassword && this.newNickname.value == this.currentPassword.value) {
        this.nickanameCheckIcon.markAsInvalid();
        this.newNickname.validValue = false;
        return;
      }
      if(this.newNickname.value.length == 0) {
        this.nickanameCheckIcon.turnOff();
        this.newNickname.validValue = true;
      } else {
        this.nickname = this.newNickname.value;
        uidCheckService.validate(this.nickname,this.callbackUidValidate);
      }
    }

    private function onPasswordInputChanged(param1:Event) : void {
      this.saveButton.enable = false;
      this.passwordCheckIcon.startProgress();
      clearTimeout(this.passwordCheckTimeOut);
      this.passwordCheckTimeOut = setTimeout(this.checkPassword,CHECK_DELAY);
    }

    private function checkPassword() : void {
      if(this.needPassword && this.currentPassword.value == this.newNickname.value) {
        this.currentPassword.validValue = false;
        this.passwordCheckIcon.markAsInvalid();
        return;
      }
      if(this.currentPassword.value.length == 0) {
        this.passwordCheckIcon.turnOff();
        this.currentPassword.validValue = true;
      } else {
        this.password = this.currentPassword.value;
        passwordService.checkPassword(this.password,this.callbackPasswordCheck);
      }
    }

    private function createPlaceholder(param1:String, param2:int) : PlaceholderInputText {
      var local3:PlaceholderInputText = new PlaceholderInputText(param1);
      local3.x = WINDOW_MARGIN;
      local3.y = param2;
      local3.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      return local3;
    }

    private function createCheckIcon(param1:PlaceholderInputText) : ValidationIcon {
      var local2:ValidationIcon = new ValidationIcon();
      local2.turnOff();
      local2.y = int((param1.height - local2.height) / 2) + 2;
      local2.x = param1.width - local2.width - CHECK_ICON_OFFSET;
      return local2;
    }

    private function addSaveButton() : void {
      this.saveButton = new DefaultButtonBase();
      this.saveButton.label = localeService.getText(TanksLocale.TEXT_SAVE_BUTTON_LABEL);
      this.saveButton.x = WINDOW_WIDTH - 2 * this.saveButton.width - 2 * WINDOW_MARGIN;
      this.saveButton.y = this.calculateYPosition(this.needPassword ? this.currentPassword : this.newNickname);
      this.saveButton.enable = false;
      this.saveButton.addEventListener(MouseEvent.CLICK,this.onSaveButtonClick);
      this.window.addChild(this.saveButton);
    }

    private function addCloseButton() : void {
      this.closeButton = new DefaultButtonBase();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = WINDOW_WIDTH - WINDOW_MARGIN - this.closeButton.width;
      this.closeButton.y = this.saveButton.y;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.window.addChild(this.closeButton);
    }

    private function callbackUidValidate(param1:ValidationStatus) : void {
      this.nicknameIsValid = param1 == ValidationStatus.CORRECT;
      this.newNickname.validValue = this.nicknameIsValid;
      if(this.nicknameIsValid) {
        this.nickanameCheckIcon.markAsValid();
      } else {
        this.nickanameCheckIcon.markAsInvalid();
      }
      this.checkRenameState();
    }

    private function callbackPasswordCheck(param1:Boolean) : void {
      this.passwordIsValid = param1;
      if(this.passwordIsValid) {
        this.passwordCheckIcon.markAsValid();
      } else {
        this.passwordCheckIcon.markAsInvalid();
      }
      this.currentPassword.validValue = this.passwordIsValid;
      this.checkRenameState();
    }

    private function uidIsValid() : void {
      this.nickanameCheckIcon.markAsValid();
      this.newNickname.validValue = true;
      this.checkRenameState();
    }

    private function uidIsNotValid() : void {
      this.nickanameCheckIcon.markAsInvalid();
      this.newNickname.validValue = false;
    }

    private function checkRenameState() : void {
      if(this.nicknameIsValid && (this.passwordIsValid || !this.needPassword)) {
        this.saveButton.enable = true;
      }
    }

    private function onSaveButtonClick(param1:MouseEvent) : void {
      dispatchEvent(new RenameEvent(this.nickname));
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      dialogService.removeDialog(this);
    }

    public function dispose() : void {
      this.saveButton.removeEventListener(MouseEvent.CLICK,this.onSaveButtonClick);
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.newNickname.removeEventListener(Event.CHANGE,this.onNicknameInputChanged);
      if(this.needPassword) {
        this.currentPassword.removeEventListener(Event.CHANGE,this.onPasswordInputChanged);
      }
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseButtonClick();
    }
  }
}
