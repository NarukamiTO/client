package alternativa.tanks.gui.notinclan.dialogs {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.components.flag.FlagsDropDownList;
  import alternativa.tanks.gui.components.helpers.BubbleItem;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.models.panel.create.ClanCreateService;
  import alternativa.tanks.models.panel.create.CreateClanServiceEvent;
  import controls.ValidationIcon;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import controls.base.ThreeLineBigButton;
  import controls.checkbox.CheckBoxEvent;
  import controls.checkbox.TankCheckBox;
  import controls.windowinner.WindowInner;
  import flash.display.Bitmap;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import forms.ColorConstants;
  import forms.events.LoginFormEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;

  public class ClanCreateDialog extends ClanDialog {
    [Inject]
    public static var createClanService:ClanCreateService;

    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    public static const WIDTH:Number = 550;
    public static const HEIGHT:Number = 331;

    private const CHECK_CALLSIGN_DELAY:int = 500;

    private var licenseImageClass:Class = ClanCreateDialog_licenseImageClass;
    private var licenseImage:Bitmap = new this.licenseImageClass() as Bitmap;
    private var windowInner:WindowInner = new WindowInner(0,0,WindowInner.GREEN);
    private var checkNameAndTagTimer:Timer;
    private var checkTagTimer:Timer;
    private var validateStateName:Boolean;
    private var validateStateTag:Boolean;
    private var clanNameInput:TankInputBase;
    private var clanTagInput:TankInputBase;
    private var checkBox:TankCheckBox;
    private var rulesLink:LabelBase;
    private var createButton:ThreeLineBigButton;
    private var validateCheckClanNameIcon:ValidationIcon;
    private var validateCheckTagIcon:ValidationIcon;
    private var tagLabel:LabelBase;
    private var clanLabel:LabelBase;
    private var flagsCombo:FlagsDropDownList = new FlagsDropDownList();

    public function ClanCreateDialog() {
      super();
      this.initControls();
      this.addControls();
    }

    private function initControls() : void {
      this.windowInner.x = MARGIN;
      this.windowInner.y = MARGIN;
      this.windowInner.width = WIDTH - 2 * MARGIN;
      this.clanNameInput = new TankInputBase();
      this.clanNameInput.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInClanInput);
      this.clanNameInput.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutClanInput);
      this.clanNameInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onClanNameChanged);
      this.clanNameInput.tabIndex = 2;
      this.clanTagInput = new TankInputBase();
      this.clanTagInput.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInTagInput);
      this.clanTagInput.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutTagInput);
      this.clanTagInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onTagChanged);
      this.clanTagInput.tabIndex = 1;
      this.checkBox = new TankCheckBox();
      this.checkBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onCheckBoxClick);
      this.checkBox.tabIndex = 3;
      this.rulesLink = new LabelBase();
      this.rulesLink.htmlText = localeService.getText(TanksLocale.TEXT_CLAN_CREATION_RULES);
      this.createButton = new ThreeLineBigButton();
      this.createButton.setText(localeService.getText(TanksLocale.TEXT_CLAN_CREATE));
      this.createButton.enabled = false;
      this.createButton.addEventListener(MouseEvent.CLICK,this.onCreateButtonClick);
      this.createButton.tabIndex = 4;
      this.validateCheckClanNameIcon = new ValidationIcon();
      this.validateCheckTagIcon = new ValidationIcon();
      this.checkNameAndTagTimer = new Timer(this.CHECK_CALLSIGN_DELAY,1);
      this.checkNameAndTagTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCheckNameTimerComplete);
      this.checkTagTimer = new Timer(this.CHECK_CALLSIGN_DELAY,1);
      this.checkTagTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCheckTagTimerComplete);
      this.clanLabel = new LabelBase();
      this.clanLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_USER_CLAN_NAME);
      this.clanLabel.mouseEnabled = false;
      this.clanLabel.color = ColorConstants.LIST_LABEL_HINT;
      this.tagLabel = new LabelBase();
      this.tagLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_TAG);
      this.tagLabel.mouseEnabled = false;
      this.tagLabel.color = ColorConstants.LIST_LABEL_HINT;
      createClanService.addEventListener(CreateClanServiceEvent.NOT_UNIQUE_NAME,this.onNotUniqueName);
      createClanService.addEventListener(CreateClanServiceEvent.NOT_UNIQUE_TAG,this.onNotUniqueTag);
      createClanService.addEventListener(CreateClanServiceEvent.CORRECT_NAME,this.onCorrectName);
      createClanService.addEventListener(CreateClanServiceEvent.INCORRECT_NAME,this.onIncorrectName);
      createClanService.addEventListener(CreateClanServiceEvent.CORRECT_TAG,this.onCorrectTag);
      createClanService.addEventListener(CreateClanServiceEvent.INCORRECT_TAG,this.onIncorrectTag);
      createClanService.addEventListener(CreateClanServiceEvent.OTHER_ERROR,this.onError);
      createClanService.addEventListener(CreateClanServiceEvent.ALREADY_IN_CLAN,this.onAlreadyInClan);
      this.createButton.x = WIDTH - this.createButton.width >> 1;
      this.createButton.y = HEIGHT - this.createButton.height - MARGIN;
      this.checkBox.x = MARGIN;
      this.checkBox.y = this.createButton.y - this.checkBox.height - MARGIN - SMALL_MARGIN;
      this.clanTagInput.x = MARGIN;
      this.clanTagInput.y = this.checkBox.y - this.clanTagInput.height - MARGIN;
      this.clanTagInput.width = 100;
      this.clanNameInput.x = this.clanTagInput.x + this.clanTagInput.width;
      this.clanNameInput.y = this.clanTagInput.y;
      this.clanNameInput.width = this.windowInner.width - this.clanTagInput.width - 70 - MARGIN;
      this.flagsCombo.x = this.clanNameInput.x + this.clanNameInput.width;
      this.flagsCombo.y = this.clanNameInput.y;
      this.tagLabel.x = this.clanTagInput.x + 3;
      this.tagLabel.y = this.clanTagInput.y + 7;
      this.clanLabel.x = this.clanNameInput.x + 3;
      this.clanLabel.y = this.clanNameInput.y + 7;
      this.rulesLink.x = this.checkBox.x + this.checkBox._labelInfo.x + this.checkBox._labelInfo.width;
      this.rulesLink.y = this.checkBox.y + this.checkBox._labelInfo.y;
      this.validateCheckClanNameIcon.x = this.clanNameInput.x + this.clanNameInput.width - 33;
      this.validateCheckClanNameIcon.y = this.clanNameInput.y + 7;
      this.validateCheckTagIcon.x = this.clanTagInput.x + this.clanTagInput.width - 33;
      this.validateCheckTagIcon.y = this.clanTagInput.y + 7;
      this.windowInner.height = this.clanNameInput.y - SMALL_MARGIN - MARGIN;
      this.licenseImage.y = MARGIN;
      this.licenseImage.x = (this.width - this.licenseImage.width) / 2;
    }

    private function addControls() : void {
      addChild(this.windowInner);
      addChild(this.clanNameInput);
      addChild(this.clanLabel);
      addChild(this.clanTagInput);
      addChild(this.tagLabel);
      addChild(this.checkBox);
      addChild(this.rulesLink);
      addChild(this.createButton);
      addChild(this.validateCheckClanNameIcon);
      addChild(this.validateCheckTagIcon);
      addChild(this.flagsCombo);
      addChild(this.licenseImage);
    }

    protected function onCreateButtonClick(param1:MouseEvent) : void {
      if(this.checkBox.checked) {
        modalLoaderService.show();
        createClanService.createClan(this.clanNameInput.value,this.clanTagInput.value,"",this.flagsCombo.flag.country);
      }
    }

    private function onCheckBoxClick(param1:CheckBoxEvent) : void {
      this.updateStateCreateButton();
    }

    private function onClanNameChanged(param1:LoginFormEvent) : void {
      if(this.clanNameInput.value.length == 0) {
        this.validateCheckClanNameIcon.turnOff();
      }
      this.checkNameAndTagTimer.reset();
      this.checkNameAndTagTimer.start();
    }

    private function onTagChanged(param1:LoginFormEvent) : void {
      if(this.clanTagInput.value.length == 0) {
        this.validateCheckTagIcon.turnOff();
      }
      this.checkTagTimer.reset();
      this.checkTagTimer.start();
    }

    private function onCheckNameTimerComplete(param1:TimerEvent) : void {
      if(this.clanNameInput.value.length > 0) {
        this.validateCheckClanNameIcon.startProgress();
        createClanService.validateName(this.clanNameInput.value);
      } else {
        this.updateStateCreateButton();
      }
    }

    private function onCheckTagTimerComplete(param1:TimerEvent) : void {
      if(this.clanTagInput.value.length > 0) {
        this.validateCheckTagIcon.startProgress();
        createClanService.validateTag(this.clanTagInput.value);
      } else {
        this.updateStateCreateButton();
      }
    }

    private function updateStateCreateButton() : void {
      var local1:String = this.clanNameInput.value;
      var local2:String = this.clanTagInput.value;
      this.createButton.enabled = false;
      if(this.checkBox.checked && local1 != null && local1.length > 0 && local2 != null && local2.length > 0 && this.validateStateTag && this.validateStateName) {
        this.createButton.enabled = true;
      }
      if(local1.length == 0 && local2.length == 0) {
        BubbleItem.hide();
      }
    }

    override protected function removeEvents() : void {
      createClanService.removeEventListener(CreateClanServiceEvent.NOT_UNIQUE_NAME,this.onNotUniqueName);
      createClanService.removeEventListener(CreateClanServiceEvent.NOT_UNIQUE_TAG,this.onNotUniqueTag);
      createClanService.removeEventListener(CreateClanServiceEvent.CORRECT_NAME,this.onCorrectName);
      createClanService.removeEventListener(CreateClanServiceEvent.INCORRECT_NAME,this.onIncorrectName);
      createClanService.removeEventListener(CreateClanServiceEvent.CORRECT_TAG,this.onCorrectTag);
      createClanService.removeEventListener(CreateClanServiceEvent.INCORRECT_TAG,this.onIncorrectTag);
      createClanService.removeEventListener(CreateClanServiceEvent.ALREADY_IN_CLAN,this.onAlreadyInClan);
      this.createButton.removeEventListener(MouseEvent.CLICK,this.onCreateButtonClick);
      this.clanNameInput.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onClanNameChanged);
      this.checkNameAndTagTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onCheckNameTimerComplete);
      this.checkBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onCheckBoxClick);
    }

    private function onCorrectName(param1:CreateClanServiceEvent) : void {
      BubbleItem.hide();
      this.validateStateName = true;
      this.validateCheckClanNameIcon.markAsValid();
      this.updateStateCreateButton();
    }

    private function onCorrectTag(param1:CreateClanServiceEvent) : void {
      BubbleItem.hide();
      this.validateStateTag = true;
      this.validateCheckTagIcon.markAsValid();
      this.updateStateCreateButton();
    }

    private function onError(param1:CreateClanServiceEvent) : void {
      this.validateStateName = false;
      this.validateCheckClanNameIcon.markAsInvalid();
      this.validateStateTag = false;
      this.validateCheckTagIcon.markAsInvalid();
      this.updateStateCreateButton();
    }

    private function onIncorrectName(param1:CreateClanServiceEvent) : void {
      BubbleItem.createBubble(localeService.getText(TanksLocale.TEXT_CLAN_INCORECT_CLAN_NAME),this.clanNameInput,this);
      this.validateStateName = false;
      this.validateCheckClanNameIcon.markAsInvalid();
      this.updateStateCreateButton();
    }

    private function onIncorrectTag(param1:CreateClanServiceEvent) : void {
      BubbleItem.createBubble(localeService.getText(TanksLocale.TEXT_CLAN_INCORECT_CLAN_TAG),this.clanTagInput,this);
      this.validateStateTag = false;
      this.validateCheckTagIcon.markAsInvalid();
      this.updateStateCreateButton();
    }

    private function onNotUniqueName(param1:CreateClanServiceEvent) : void {
      BubbleItem.createBubble(localeService.getText(TanksLocale.TEXT_CLAN_NAME_ALREADY),this.clanNameInput,this);
      this.validateStateName = false;
      this.validateCheckClanNameIcon.markAsInvalid();
      this.updateStateCreateButton();
    }

    private function onNotUniqueTag(param1:CreateClanServiceEvent) : void {
      BubbleItem.createBubble(localeService.getText(TanksLocale.TEXT_CLAN_TAG_ALREADY),this.clanTagInput,this);
      this.validateStateTag = false;
      this.validateCheckTagIcon.markAsInvalid();
      this.updateStateCreateButton();
    }

    private function onFocusInClanInput(param1:FocusEvent) : void {
      this.clanLabel.visible = false;
    }

    private function onFocusOutClanInput(param1:FocusEvent) : void {
      if(this.clanNameInput.value.length == 0) {
        this.clanLabel.visible = true;
      }
    }

    private function onFocusInTagInput(param1:FocusEvent) : void {
      this.tagLabel.visible = false;
    }

    private function onFocusOutTagInput(param1:FocusEvent) : void {
      if(this.clanTagInput.value.length == 0) {
        this.tagLabel.visible = true;
      }
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    private function onAlreadyInClan(param1:CreateClanServiceEvent) : void {
      alertService.showOkAlert(localeService.getText(TanksLocale.TEXT_CLAN_YOU_ALREADY_IN_CLAN));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onClickAlreadyInClanAlert);
    }

    private function onClickAlreadyInClanAlert(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onClickAlreadyInClanAlert);
      destroy();
    }

    override protected function getImageHeaderId() : String {
      return TanksLocale.TEXT_HEADER_CLAN_LICENSE;
    }
  }
}
