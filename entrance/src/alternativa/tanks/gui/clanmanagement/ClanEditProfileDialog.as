package alternativa.tanks.gui.clanmanagement {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.components.ClanDescriptionInput;
  import alternativa.tanks.gui.components.flag.FlagsDropDownList;
  import alternativa.tanks.gui.components.rank.RanksDropDownList;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.models.clan.info.IClanInfoModel;
  import alternativa.tanks.models.panel.create.ClanCreateService;
  import alternativa.tanks.models.panel.create.CreateClanServiceEvent;
  import alternativa.tanks.models.service.ClanInfoUpdateEvent;
  import alternativa.tanks.models.service.ClanService;
  import controls.base.LabelBase;
  import controls.base.TankInputBox;
  import controls.base.ThreeLineBigButton;
  import controls.dropdownlist.DropDownList;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ClanEditProfileDialog extends ClanDialog {
    [Inject]
    public static var createClanService:ClanCreateService;

    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const FLAG_FIELD_NAME:String = "country";
    private static const GREY_TEXT_COLOR:int = 7829367;

    public static const WIDTH:Number = 550;
    public static const HEIGHT:Number = 450;

    private var clanNameInput:TankInputBox;
    private var clanTagInput:TankInputBox;
    private var flagsLabel:LabelBase;
    private var flagsCombo:FlagsDropDownList;
    private var applyRequestsLabel:LabelBase;
    private var applyRequests:DropDownList;
    private var rankLabel:LabelBase;
    private var rankCombo:DropDownList;
    private var descriptionInput:ClanDescriptionInput;
    private var descriptionLabel:LabelBase;
    private var okButton:ThreeLineBigButton;
    private var infoModel:IClanInfoModel;
    private var lastInfo:ClanInfoUpdateEvent;
    private var profileWindow:ClanProfileWindow;

    public function ClanEditProfileDialog(param1:IClanInfoModel, param2:ClanInfoUpdateEvent, param3:ClanProfileWindow) {
      super();
      this.infoModel = param1;
      this.lastInfo = param2;
      this.profileWindow = param3;
      this.init();
      this.resize();
    }

    private function init() : void {
      this.clanNameInput = new TankInputBox("",true);
      this.clanNameInput.validateFunction = this.updateClanName;
      this.clanNameInput.maxChars = 15;
      this.clanNameInput.restrict = "0-9.a-zA-z_\\-*";
      this.clanNameInput.value = this.getClanName();
      this.clanNameInput.enable = false;
      this.clanNameInput.textField.textColor = GREY_TEXT_COLOR;
      addChild(this.clanNameInput);
      this.clanTagInput = new TankInputBox("",true);
      this.clanTagInput.validateFunction = this.updateClanTag;
      this.clanTagInput.maxChars = 5;
      this.clanTagInput.restrict = "0-9.a-zA-z_\\-*";
      this.clanTagInput.value = this.getClanTag();
      this.clanTagInput.enable = false;
      this.clanTagInput.textField.textColor = GREY_TEXT_COLOR;
      addChild(this.clanTagInput);
      this.descriptionInput = new ClanDescriptionInput(this.getClanDescription(),clanService.maxCharactersDescription);
      this.descriptionInput.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInDescriptionInput);
      this.descriptionInput.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutDescriptionInput);
      addChild(this.descriptionInput);
      this.descriptionLabel = new LabelBase();
      this.descriptionLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_DESCRIPTION_LABEL);
      this.descriptionLabel.textColor = GREY_TEXT_COLOR;
      this.descriptionLabel.mouseEnabled = false;
      this.descriptionLabel.visible = this.descriptionInput.text.length == 0;
      this.applyRequestsLabel = new LabelBase();
      this.applyRequestsLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_PROFILE_INVATION_CLAN);
      this.applyRequestsLabel.mouseEnabled = false;
      addChild(this.applyRequestsLabel);
      this.applyRequests = new DropDownList();
      this.applyRequests.addItem({
        "gameName":localeService.getText(TanksLocale.TEXT_CLAN_PROFILE_OPEN),
        "id":0,
        "rang":0
      });
      this.applyRequests.addItem({
        "gameName":localeService.getText(TanksLocale.TEXT_CLAN_PROFILE_CLOSE),
        "id":1,
        "rang":0
      });
      this.applyRequests.selectItemAt(this.requestsEnabled() ? 0 : 1);
      this.applyRequests.width = 84;
      this.applyRequests.height = 75;
      addChild(this.applyRequests);
      this.flagsLabel = new LabelBase();
      this.flagsLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_FLAG);
      addChild(this.flagsLabel);
      this.rankLabel = new LabelBase();
      this.rankLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_PROFILE_MIN_RANK);
      this.rankLabel.mouseEnabled = false;
      addChild(this.rankLabel);
      this.rankCombo = new RanksDropDownList(clanService.minRankForCreateClan);
      this.rankCombo.selectItemByField("rank",this.getMinRankIndex());
      this.flagsCombo = new FlagsDropDownList();
      this.flagsCombo.selectItemByField(FLAG_FIELD_NAME,this.getClanFlag());
      addChild(this.rankCombo);
      addChild(this.flagsCombo);
      this.okButton = new ThreeLineBigButton();
      this.okButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_SAVE_TEXT);
      this.okButton.addEventListener(MouseEvent.CLICK,this.onOkButtonClick);
      addChild(this.okButton);
      createClanService.addEventListener(CreateClanServiceEvent.CORRECT_NAME,this.onCorrectName);
      createClanService.addEventListener(CreateClanServiceEvent.INCORRECT_NAME,this.onIncorrectName);
      createClanService.addEventListener(CreateClanServiceEvent.CORRECT_TAG,this.onCorrectTag);
      createClanService.addEventListener(CreateClanServiceEvent.INCORRECT_TAG,this.onIncorrectTag);
    }

    private function onFocusInDescriptionInput(param1:FocusEvent) : void {
      this.descriptionLabel.visible = false;
    }

    private function onFocusOutDescriptionInput(param1:FocusEvent) : void {
      if(this.descriptionInput.text.length == 0) {
        this.descriptionLabel.visible = true;
      }
    }

    private function getClanDescription() : String {
      if(this.lastInfo == null) {
        return this.infoModel.getDescription();
      }
      return this.lastInfo.clanDescription;
    }

    private function getClanName() : String {
      if(this.lastInfo == null) {
        return this.infoModel.getClanName();
      }
      return this.lastInfo.clanName;
    }

    private function getClanTag() : String {
      if(this.lastInfo == null) {
        return this.infoModel.getClanTag();
      }
      return this.lastInfo.clanTag;
    }

    private function getClanFlag() : ClanFlag {
      if(this.lastInfo == null) {
        return this.infoModel.getClanFlag();
      }
      return this.lastInfo.clanFlag;
    }

    private function requestsEnabled() : Boolean {
      if(this.lastInfo == null) {
        return this.infoModel.incomingRequestEnabled();
      }
      return this.lastInfo.clanRequestsEnabled;
    }

    private function getMinRankIndex() : int {
      if(this.lastInfo == null) {
        return this.infoModel.getRankIndexForAddClan();
      }
      return this.lastInfo.clanMinRank;
    }

    private function resize() : void {
      this.clanNameInput.x = MARGIN;
      this.clanNameInput.y = MARGIN;
      this.clanNameInput.width = WIDTH - 2 * MARGIN;
      this.clanTagInput.x = MARGIN;
      this.clanTagInput.y = this.clanNameInput.y + this.clanNameInput.height + SMALL_MARGIN;
      this.clanTagInput.width = WIDTH - 2 * MARGIN;
      this.flagsLabel.x = MARGIN;
      this.flagsLabel.y = this.clanTagInput.y + this.clanTagInput.height + SMALL_MARGIN + 6;
      this.flagsCombo.x = this.flagsLabel.x + this.flagsLabel.width + SMALL_MARGIN;
      this.flagsCombo.y = this.clanTagInput.y + this.clanTagInput.height + SMALL_MARGIN;
      this.applyRequestsLabel.x = this.flagsCombo.x + 70 + SMALL_MARGIN;
      this.applyRequestsLabel.y = this.flagsLabel.y;
      this.applyRequests.x = this.applyRequestsLabel.x + this.applyRequestsLabel.width + SMALL_MARGIN;
      this.applyRequests.y = this.flagsCombo.y;
      this.rankLabel.x = this.applyRequests.x + 84 + SMALL_MARGIN;
      this.rankLabel.y = this.flagsLabel.y;
      this.rankCombo.x = this.rankLabel.x + this.rankLabel.width + SMALL_MARGIN;
      this.rankCombo.y = this.flagsCombo.y;
      this.okButton.x = WIDTH - this.okButton.width >> 1;
      this.okButton.y = HEIGHT - this.okButton.height - MARGIN;
      this.descriptionLabel.x = SMALL_MARGIN;
      this.descriptionLabel.y = SMALL_MARGIN;
      this.descriptionInput.x = MARGIN;
      this.descriptionInput.y = this.flagsCombo.y + 30 + SMALL_MARGIN;
      this.descriptionInput.width = WIDTH - 2 * MARGIN;
      this.descriptionInput.height = HEIGHT - this.descriptionInput.y - this.okButton.height - MARGIN - SMALL_MARGIN;
    }

    override protected function removeEvents() : void {
      this.descriptionInput.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusInDescriptionInput);
      this.descriptionInput.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutDescriptionInput);
      createClanService.removeEventListener(CreateClanServiceEvent.CORRECT_NAME,this.onCorrectName);
      createClanService.removeEventListener(CreateClanServiceEvent.INCORRECT_NAME,this.onIncorrectName);
      createClanService.removeEventListener(CreateClanServiceEvent.CORRECT_TAG,this.onCorrectTag);
      createClanService.removeEventListener(CreateClanServiceEvent.INCORRECT_TAG,this.onIncorrectTag);
    }

    private function updateOkButtonState() : void {
      if((this.clanNameInput.isValid() || !this.clanNameInput.isEnabled()) && (this.clanTagInput.isValid() || !this.clanTagInput.isEnabled()) && !this.clanNameInput.isValidating && !this.clanTagInput.isValidating) {
        this.okButton.enabled = true;
      } else {
        this.okButton.enabled = false;
      }
    }

    private function updateClanName() : void {
      createClanService.validateName(this.clanNameInput.value);
    }

    private function updateClanTag() : void {
      createClanService.validateTag(this.clanTagInput.value);
    }

    private function onCorrectName(param1:CreateClanServiceEvent) : void {
      this.clanNameInput.valid();
      this.updateOkButtonState();
    }

    private function onIncorrectName(param1:CreateClanServiceEvent) : void {
      this.clanNameInput.invalid();
      this.updateOkButtonState();
    }

    private function onCorrectTag(param1:CreateClanServiceEvent) : void {
      this.clanTagInput.valid();
      this.updateOkButtonState();
    }

    private function onIncorrectTag(param1:CreateClanServiceEvent) : void {
      this.clanTagInput.invalid();
      this.updateOkButtonState();
    }

    private function onOkButtonClick(param1:MouseEvent) : void {
      var local2:ClanInfoUpdateEvent = new ClanInfoUpdateEvent();
      var local3:ClanFlag = this.flagsCombo.selectedItem[FLAG_FIELD_NAME];
      var local4:int = int(this.rankCombo.selectedItem.rank);
      local2.clanName = this.clanNameInput.value;
      local2.clanTag = this.clanTagInput.value;
      local2.clanFlag = local3;
      local2.clanRequestsEnabled = this.applyRequests.selectedItem.id == 0;
      local2.clanMinRank = local4;
      local2.clanDescription = this.descriptionInput.text;
      clanService.updateClanInfo(this.descriptionInput.text,local4,local3,this.applyRequests.selectedItem.id == 0);
      this.profileWindow.dispatchUpdate(local2);
      destroy();
    }

    override public function updateActions() : void {
      if(!clanUserInfoService.hasAction(ClanAction.EDIT_PROFILE)) {
        destroy();
      }
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override protected function getImageHeaderId() : String {
      return TanksLocale.TEXT_HEADER_CLAN_EDIT_PROFILE;
    }
  }
}
