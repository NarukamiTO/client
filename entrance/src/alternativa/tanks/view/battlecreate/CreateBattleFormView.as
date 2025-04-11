package alternativa.tanks.view.battlecreate {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.controllers.battlecreate.CreateBattleFormController;
  import alternativa.tanks.controllers.battlecreate.CreateBattleMapParams;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.battlecreate.slider.SelectRankSlider;
  import alternativa.tanks.view.battlecreate.slider.SelectRankSliderEvent;
  import alternativa.tanks.view.battleinfo.BattleInfoParamsView;
  import alternativa.tanks.view.icons.BattleParamsCheckButtonIcons;
  import assets.icons.BattleInfoIcons;
  import base.DiscreteSprite;
  import controls.NumStepper;
  import controls.ValidationIcon;
  import controls.base.RedButtonBase;
  import controls.base.TankInputBase;
  import controls.checkbox.CheckBoxBase;
  import controls.checkbox.CheckBoxEvent;
  import controls.dropdownlist.ComboBoxRenderer;
  import controls.dropdownlist.DropDownList;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.TankWindowWithHeader;
  import forms.events.LoginFormEvent;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  public class CreateBattleFormView extends DiscreteSprite {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var timeUnitService:ITimeUnitService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    private static const GA_CATEGORY:String = "lobby";
    private static const GA_ACTION:String = "createBattle";
    private static const MIN_FLASH_WIDTH:int = 970;
    private static const MIN_FLASH_HEIGHT:int = 530;
    private static const HEADER_HEIGHT:int = 60;
    private static const FIRST_COLUMN_X:int = 11;
    private static const RIGHT_MARGIN:Number = 11;
    private static const MAX_CHARS_BATTLE_NAME:int = 25;

    private var _isShowThemeComboBox:Boolean;
    private var controller:CreateBattleFormController;
    private var _timeOutResize:uint;
    private var _window:TankWindowWithHeader;
    private var _chooseMapComboBox:DropDownList;
    private var _chooseThemeMapComboBox:DropDownList;
    private var _chooseFormatComboBox:DropDownList;

    public var battleInfo:BattleInfoParamsView;

    private var _chooseRankSlider:SelectRankSlider;
    private var _chooseTypeBattle:ChooseTypeBattleView;
    private var _maxNumberPlayersStepper:NumStepper;
    private var _timeLimitStepper:NumStepper;
    private var _scoreLimitStepper:NumStepper;
    private var _autoBalanceCheckBox:CheckBoxBase;
    private var _friendlyFireCheckBox:CheckBoxBase;
    private var _dronesCheckBox:CheckBoxBase;
    private var _suppliesCheckBox:CheckBoxBase;
    private var _dependentCooldownCheckBox:CheckBoxBase;
    private var _bonusesCheckBox:CheckBoxBase;
    private var _goldBoxesCheckBox:CheckBoxBase;
    private var _upgradesCheckBox:CheckBoxBase;
    private var _privateBattleCheckBox:CheckBoxBase;
    private var _reArmorCheckBox:CheckBoxBase;
    private var _startButton:RedButtonBase;
    private var _devicesCheckBox:CheckBoxBase;
    private var _clanCheckBox:CheckBoxBase;
    private var ultimatesCheckBox:CheckBoxBase;
    private var _battleNameTextInput:TankInputBase;
    private var _battleNameCheckIcon:ValidationIcon;
    private var _trackedEvents:Dictionary = new Dictionary();
    private var scoreWidth:int;
    private var playersWidth:int;

    public function CreateBattleFormView(param1:CreateBattleFormController) {
      super();
      this.controller = param1;
      this._window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CREATE_BATTLE);
      addChild(this._window);
      this.battleInfo = new BattleInfoParamsView();
      addChild(this.battleInfo);
      this._chooseRankSlider = new SelectRankSlider();
      addChild(this._chooseRankSlider);
      this._chooseTypeBattle = new ChooseTypeBattleView(this);
      addChild(this._chooseTypeBattle);
      this._maxNumberPlayersStepper = new NumStepper();
      this._maxNumberPlayersStepper.label = CreateBattleFormLabels.stepperMaxPlayersLabel;
      this._maxNumberPlayersStepper.icon = CreateBattleFormController.getIcon(BattleInfoIcons.PLAYERS);
      this.playersWidth = this._maxNumberPlayersStepper.width;
      addChild(this._maxNumberPlayersStepper);
      this._timeLimitStepper = new NumStepper();
      this._timeLimitStepper.label = CreateBattleFormLabels.stepperTimeLimitLabel;
      this._timeLimitStepper.icon = CreateBattleFormController.getIcon(BattleInfoIcons.TIME_LIMIT);
      addChild(this._timeLimitStepper);
      this._scoreLimitStepper = new NumStepper();
      this._scoreLimitStepper.label = CreateBattleFormLabels.stepperFlagsLimitLabel;
      this._scoreLimitStepper.icon = CreateBattleFormController.getIcon(BattleInfoIcons.CTF);
      this.scoreWidth = this._scoreLimitStepper.width;
      addChild(this._scoreLimitStepper);
      this._autoBalanceCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.autoBalanceBitmapData);
      this._autoBalanceCheckBox.checked = true;
      this._autoBalanceCheckBox.label = CreateBattleFormLabels.checkBoxAutoBalanceLabel;
      addChild(this._autoBalanceCheckBox);
      this._suppliesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.suppliesBitmapData);
      this._suppliesCheckBox.checked = true;
      this._suppliesCheckBox.label = CreateBattleFormLabels.checkBoxNoSuppliesLabel;
      addChild(this._suppliesCheckBox);
      this._dependentCooldownCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.dependentCooldownsBitmapData);
      this._dependentCooldownCheckBox.checked = false;
      this._dependentCooldownCheckBox.label = CreateBattleFormLabels.checkBoxDependentCooldownLabel;
      addChild(this._dependentCooldownCheckBox);
      this._bonusesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.bonusesBitmapData);
      this._bonusesCheckBox.checked = true;
      this._bonusesCheckBox.label = CreateBattleFormLabels.checkBoxBonusesLabel;
      addChild(this._bonusesCheckBox);
      this._goldBoxesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.goldBonusesBitmapData);
      this._goldBoxesCheckBox.checked = true;
      this._goldBoxesCheckBox.label = CreateBattleFormLabels.checkBoxGoldBoxesLabel;
      addChild(this._goldBoxesCheckBox);
      this._friendlyFireCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.friendlyFireBitmapData);
      this._friendlyFireCheckBox.label = CreateBattleFormLabels.checkBoxFriendlyFireLabel;
      addChild(this._friendlyFireCheckBox);
      this._dronesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.droneBitmapData);
      this._dronesCheckBox.checked = true;
      this._dronesCheckBox.label = CreateBattleFormLabels.checkBoxDronesLabel;
      addChild(this._dronesCheckBox);
      this._upgradesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.upgradesBitmapData);
      this._upgradesCheckBox.checked = true;
      this._upgradesCheckBox.label = CreateBattleFormLabels.checkBoxUpgradesLabel;
      addChild(this._upgradesCheckBox);
      this._devicesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.devicesBitmapData);
      this._devicesCheckBox.checked = true;
      this._devicesCheckBox.label = CreateBattleFormLabels.checkBoxDevicesLabel;
      addChild(this._devicesCheckBox);
      this._privateBattleCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.privateBitmapData);
      this._privateBattleCheckBox.label = CreateBattleFormLabels.checkBoxPrivateBattleLabel;
      addChild(this._privateBattleCheckBox);
      this._reArmorCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.rearmorBitmapData);
      this._reArmorCheckBox.checked = true;
      this._reArmorCheckBox.label = CreateBattleFormLabels.checkBoxReArmorLabel;
      addChild(this._reArmorCheckBox);
      this._clanCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.clanVsClanBitmapData);
      this._clanCheckBox.checked = false;
      this._clanCheckBox.label = CreateBattleFormLabels.checkBoxClanLabel;
      addChild(this._clanCheckBox);
      this.ultimatesCheckBox = new CheckBoxBase(BattleParamsCheckButtonIcons.ultimatesBitmapData);
      this.ultimatesCheckBox.checked = true;
      this.ultimatesCheckBox.label = CreateBattleFormLabels.checkBoxUltimatesLabel;
      addChild(this.ultimatesCheckBox);
      this.updateUltimate();
      this._chooseFormatComboBox = new DropDownList();
      this._chooseFormatComboBox.setRenderer(ComboBoxRenderer);
      addChild(this._chooseFormatComboBox);
      this._battleNameTextInput = new TankInputBase();
      this._battleNameTextInput.maxChars = MAX_CHARS_BATTLE_NAME;
      addChild(this._battleNameTextInput);
      this._battleNameCheckIcon = new ValidationIcon();
      addChild(this._battleNameCheckIcon);
      this.resetProgressBattleNameCheckIcon();
      this._startButton = new RedButtonBase();
      this._startButton.label = CreateBattleFormLabels.startButtonLabel;
      addChild(this._startButton);
      this._chooseMapComboBox = new DropDownList();
      this._chooseMapComboBox.label = CreateBattleFormLabels.mapNameLabel;
      addChild(this._chooseMapComboBox);
      this._chooseThemeMapComboBox = new DropDownList();
      this._chooseThemeMapComboBox.label = CreateBattleFormLabels.themeMapNameLabel;
      this._chooseThemeMapComboBox.setRenderer(ComboBoxRenderer);
      addChild(this._chooseThemeMapComboBox);
    }

    public function setEvents() : void {
      display.stage.addEventListener(Event.RESIZE,this.onResize);
      this._battleNameTextInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onBattleNameChange);
      this._battleNameTextInput.textField.addEventListener(FocusEvent.FOCUS_IN,this.onBattleNameInFocus);
      this._battleNameTextInput.textField.addEventListener(FocusEvent.FOCUS_OUT,this.onBattleNameOutFocus);
      this._chooseMapComboBox.addEventListener(Event.CHANGE,this.onMapChange);
      this._chooseMapComboBox.addEventListener(Event.OPEN,this.onMapComboBoxOpen);
      this._chooseThemeMapComboBox.addEventListener(Event.OPEN,this.onThemeComboBoxOpen);
      this._chooseThemeMapComboBox.addEventListener(Event.CHANGE,this.onThemeChange);
      this._maxNumberPlayersStepper.addEventListener(Event.CHANGE,this.onPlayersNumberChange);
      this._maxNumberPlayersStepper.addEventListener(MouseEvent.CLICK,this.onPlayersNumberChangeTrack);
      this._timeLimitStepper.addEventListener(Event.CHANGE,this.onTimeLimitChange);
      this._timeLimitStepper.addEventListener(MouseEvent.CLICK,this.onTimeLimitChangeTrack);
      this._scoreLimitStepper.addEventListener(Event.CHANGE,this.onScoreLimitChange);
      this._scoreLimitStepper.addEventListener(MouseEvent.CLICK,this.onScoreLimitChangeTrack);
      this._chooseRankSlider.addEventListener(SelectRankSliderEvent.RANK_LIMIT_CHANGED,this.onRankLimitChanged);
      this._startButton.addEventListener(MouseEvent.CLICK,this.onStartButtonClick);
      this._suppliesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onNoSuppliesChange);
      this._privateBattleCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onPrivateBattleChange);
      this._bonusesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onBonusesChange);
      this._goldBoxesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onGoldBoxesChange);
      this._autoBalanceCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onAutoBalanceChange);
      this._reArmorCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onReArmorChange);
      this._upgradesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onUpgradesOrDevicesChange);
      this._devicesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onUpgradesOrDevicesChange);
      this._chooseFormatComboBox.addEventListener(Event.CHANGE,this.controller.onFormatChange);
      this._dependentCooldownCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onDependentCooldownChange);
      this._friendlyFireCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onFriendlyFireChange);
      this._clanCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.onClanChange);
      this.ultimatesCheckBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onUltimatesChanged);
    }

    public function removeEvents() : void {
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
      this._battleNameTextInput.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onBattleNameChange);
      this._battleNameTextInput.textField.removeEventListener(FocusEvent.FOCUS_IN,this.onBattleNameInFocus);
      this._battleNameTextInput.textField.removeEventListener(FocusEvent.FOCUS_OUT,this.onBattleNameOutFocus);
      this._chooseMapComboBox.removeEventListener(Event.CHANGE,this.onMapChange);
      this._chooseMapComboBox.removeEventListener(Event.OPEN,this.onMapComboBoxOpen);
      this._chooseThemeMapComboBox.removeEventListener(Event.OPEN,this.onThemeComboBoxOpen);
      this._chooseThemeMapComboBox.removeEventListener(Event.CHANGE,this.onThemeChange);
      this._maxNumberPlayersStepper.removeEventListener(Event.CHANGE,this.onPlayersNumberChange);
      this._maxNumberPlayersStepper.removeEventListener(MouseEvent.CLICK,this.onPlayersNumberChangeTrack);
      this._timeLimitStepper.removeEventListener(Event.CHANGE,this.onTimeLimitChange);
      this._timeLimitStepper.removeEventListener(MouseEvent.CLICK,this.onTimeLimitChangeTrack);
      this._scoreLimitStepper.removeEventListener(Event.CHANGE,this.onScoreLimitChange);
      this._scoreLimitStepper.removeEventListener(MouseEvent.CLICK,this.onScoreLimitChangeTrack);
      this._chooseRankSlider.removeEventListener(SelectRankSliderEvent.RANK_LIMIT_CHANGED,this.onRankLimitChanged);
      this._startButton.removeEventListener(MouseEvent.CLICK,this.onStartButtonClick);
      this._suppliesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onNoSuppliesChange);
      this._privateBattleCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onPrivateBattleChange);
      this._bonusesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onBonusesChange);
      this._goldBoxesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onGoldBoxesChange);
      this._autoBalanceCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onAutoBalanceChange);
      this._reArmorCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onReArmorChange);
      this._chooseFormatComboBox.removeEventListener(Event.CHANGE,this.controller.onFormatChange);
      this._dependentCooldownCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onDependentCooldownChange);
      this._friendlyFireCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.onFriendlyFireChange);
      this._upgradesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onUpgradesOrDevicesChange);
      this._devicesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onUpgradesOrDevicesChange);
      this.ultimatesCheckBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.controller.onUltimatesChanged);
    }

    public function setBattleMode(param1:BattleMode) : void {
      this.controller.setBattleMode(param1);
      this.trackOnce("battleTypeChange_" + param1.name);
    }

    public function setTypeBattle(param1:BattleMode) : void {
      this._chooseTypeBattle.setTypeBattle(param1);
      var local2:Boolean = param1 != BattleMode.DM;
      this._autoBalanceCheckBox.visible = local2;
      this._friendlyFireCheckBox.visible = local2;
      this._clanCheckBox.visible = local2 && Boolean(clanUserInfoService.clanMember);
    }

    public function blockedStartButton() : void {
      this._startButton.enable = false;
    }

    public function unBlockedStartButton() : void {
      this._startButton.enable = true;
    }

    public function resetPrivateBattleCheckBox() : void {
      this._privateBattleCheckBox.checked = false;
    }

    public function get isPrivateBattle() : Boolean {
      return this._privateBattleCheckBox.checked;
    }

    public function get isAutoBalance() : Boolean {
      return this._autoBalanceCheckBox.checked;
    }

    public function get isFriendlyFire() : Boolean {
      return this._friendlyFireCheckBox.checked;
    }

    public function get isWithoutDrones() : Boolean {
      return !this._dronesCheckBox.checked;
    }

    public function get isNoSuppliesBattle() : Boolean {
      return !this._suppliesCheckBox.checked;
    }

    public function get isWithoutBonuses() : Boolean {
      return !this._bonusesCheckBox.checked;
    }

    public function get isGoldBoxesEnabled() : Boolean {
      return this._goldBoxesCheckBox.checked;
    }

    public function get isReArmor() : Boolean {
      return this._reArmorCheckBox.checked;
    }

    public function get isWithoutUpgrades() : Boolean {
      return !this._upgradesCheckBox.checked;
    }

    public function get isWithoutDevices() : Boolean {
      return !this._devicesCheckBox.checked;
    }

    public function get isDependentCooldownBattle() : Boolean {
      return this._dependentCooldownCheckBox.checked;
    }

    public function get isClanBattle() : Boolean {
      return this._clanCheckBox.checked;
    }

    public function setRankIntervalRestriction(param1:int, param2:int, param3:int) : void {
      this._chooseRankSlider.minValue = param1;
      this._chooseRankSlider.maxValue = param2;
      this._chooseRankSlider.tickInterval = param3;
    }

    public function setMaxRankRange(param1:int) : void {
      this._chooseRankSlider.maxRangRange = param1;
    }

    public function setMaxRang(param1:int) : void {
      this._chooseRankSlider.maxRang = param1;
      this._chooseRankSlider.width = this.battleInfo.width;
    }

    public function setMinRang(param1:int) : void {
      this._chooseRankSlider.minRang = param1;
      this._chooseRankSlider.width = this.battleInfo.width;
    }

    public function setCurrentRank(param1:int) : void {
      this._chooseRankSlider.currentRang = param1;
    }

    public function getMaxRank() : int {
      return this._chooseRankSlider.maxRang;
    }

    public function getMinRank() : int {
      return this._chooseRankSlider.minRang;
    }

    public function getMinRangValue() : int {
      return this._chooseRankSlider.minValue;
    }

    public function getMaxRangValue() : int {
      return this._chooseRankSlider.maxValue;
    }

    public function show() : void {
      this.setEvents();
      this.onResize(null);
      if(!display.systemLayer.contains(this)) {
        display.systemLayer.addChild(this);
      }
    }

    public function hide() : void {
      this.removeEvents();
      if(display.systemLayer.contains(this)) {
        display.systemLayer.removeChild(this);
      }
    }

    public function destroy() : void {
      this.removeEvents();
      clearTimeout(this._timeOutResize);
      this._chooseTypeBattle.destroy();
      this._chooseTypeBattle = null;
      this._window = null;
      this.battleInfo = null;
      this._chooseRankSlider = null;
      this._maxNumberPlayersStepper = null;
      this._timeLimitStepper = null;
      this._scoreLimitStepper = null;
      this._autoBalanceCheckBox = null;
      this._suppliesCheckBox = null;
      this._dependentCooldownCheckBox = null;
      this._bonusesCheckBox = null;
      this._goldBoxesCheckBox = null;
      this._upgradesCheckBox = null;
      this._privateBattleCheckBox = null;
      this._reArmorCheckBox = null;
      this._startButton = null;
      this._chooseMapComboBox = null;
      this._chooseThemeMapComboBox = null;
      this.controller = null;
      this._trackedEvents = null;
      this._chooseFormatComboBox = null;
      this._friendlyFireCheckBox = null;
      this._dronesCheckBox = null;
      this._clanCheckBox = null;
      this._battleNameTextInput = null;
      this._battleNameCheckIcon = null;
    }

    public function setAvailableTypesBattle(param1:Vector.<BattleMode>) : void {
      this._chooseTypeBattle.setAvailableTypesBattle(param1);
    }

    private function resize(param1:Boolean = true) : void {
      var local2:Number = this.getBackgroundWidth();
      var local3:Number = this.getBackgroundHeight();
      this._window.width = local2;
      this._window.height = local3;
      this.x = local2 * 2;
      this.y = HEADER_HEIGHT;
      this._chooseMapComboBox.x = 11 + this._chooseMapComboBox.getLabelWidth() + 5;
      this._chooseMapComboBox.y = 11;
      this._chooseMapComboBox.height = 274;
      this.resizeMapAndThemeComboBoxes();
      this.battleInfo.width = local2 - 22;
      this.battleInfo.height = int(local3 - 520);
      this.battleInfo.x = 11;
      this.battleInfo.y = 51;
      this._chooseRankSlider.x = 11;
      this._chooseRankSlider.y = this.battleInfo.y + this.battleInfo.height + 5;
      this._chooseRankSlider.width = this.battleInfo.width;
      this._chooseTypeBattle.resize(this.battleInfo.width,this._chooseTypeBattle.getComponentHeight());
      this._chooseTypeBattle.x = 11;
      this._chooseTypeBattle.y = this._chooseRankSlider.y + this._chooseRankSlider.height + 5;
      var local4:int = int((local2 - this.playersWidth - this._timeLimitStepper.width - this.scoreWidth) / 4);
      this._maxNumberPlayersStepper.x = local4;
      this._timeLimitStepper.x = this.playersWidth + local4 * 2;
      this._scoreLimitStepper.x = this.playersWidth + this._timeLimitStepper.width + local4 * 3;
      this._maxNumberPlayersStepper.y = this._timeLimitStepper.y = this._scoreLimitStepper.y = this._chooseTypeBattle.y + 71;
      this.updateOptions();
      if(param1) {
        this.resizeWithDelay();
      }
    }

    public function updateOptions() : void {
      this._privateBattleCheckBox.x = FIRST_COLUMN_X;
      this._privateBattleCheckBox.y = this._maxNumberPlayersStepper.y + this._maxNumberPlayersStepper.height - 11;
      this._bonusesCheckBox.x = FIRST_COLUMN_X;
      this._bonusesCheckBox.y = this._privateBattleCheckBox.y + this._privateBattleCheckBox.height + 8;
      this._goldBoxesCheckBox.x = FIRST_COLUMN_X;
      this._goldBoxesCheckBox.y = this._bonusesCheckBox.y + this._bonusesCheckBox.height + 8;
      this._goldBoxesCheckBox.visible = !this.getSelectedFormatItem().parkour;
      var local1:DisplayObject = this._goldBoxesCheckBox.visible ? this._goldBoxesCheckBox : this._bonusesCheckBox;
      this._suppliesCheckBox.x = FIRST_COLUMN_X;
      this._suppliesCheckBox.y = local1.y + local1.height + 8;
      this._dependentCooldownCheckBox.x = FIRST_COLUMN_X;
      this._dependentCooldownCheckBox.y = this._suppliesCheckBox.y + this._suppliesCheckBox.height + 8;
      local1 = this._dependentCooldownCheckBox.visible ? this._dependentCooldownCheckBox : this._suppliesCheckBox;
      this._dronesCheckBox.x = FIRST_COLUMN_X;
      this._dronesCheckBox.y = local1.y + local1.height + 8;
      this.updateDrones();
      local1 = this._dronesCheckBox.visible ? this._dronesCheckBox : local1;
      this._friendlyFireCheckBox.x = FIRST_COLUMN_X;
      this._friendlyFireCheckBox.y = local1.y + local1.height + 8;
      local1 = this._friendlyFireCheckBox.visible ? this._friendlyFireCheckBox : local1;
      this._clanCheckBox.x = FIRST_COLUMN_X;
      this._clanCheckBox.y = local1.y + local1.height + 8;
      var local2:Number = this.getBackgroundWidth();
      var local3:int = local2 / 2 + 5;
      this._chooseFormatComboBox.x = local3;
      this._chooseFormatComboBox.y = this._privateBattleCheckBox.y;
      this._chooseFormatComboBox.width = local2 - this._chooseFormatComboBox.x - RIGHT_MARGIN;
      this._upgradesCheckBox.x = local3;
      this._upgradesCheckBox.y = this._bonusesCheckBox.y;
      this._devicesCheckBox.x = local3;
      this._devicesCheckBox.y = this._upgradesCheckBox.y + this._upgradesCheckBox.height + 8;
      this._reArmorCheckBox.x = local3;
      this._reArmorCheckBox.y = this._devicesCheckBox.y + this._devicesCheckBox.height + 8;
      this._autoBalanceCheckBox.x = local3;
      this._autoBalanceCheckBox.y = this._reArmorCheckBox.y + this._reArmorCheckBox.height + 8;
      local1 = this._autoBalanceCheckBox.visible ? this._autoBalanceCheckBox : this._reArmorCheckBox;
      this.ultimatesCheckBox.x = local3;
      this.ultimatesCheckBox.y = local1.y + local1.height + 8;
      this._startButton.x = local2 - this._startButton.width - 11;
      this._startButton.y = this.getBackgroundHeight() - 42;
      this._battleNameTextInput.x = FIRST_COLUMN_X;
      this._battleNameTextInput.y = this._startButton.y;
      this._battleNameTextInput.width = this._startButton.x - FIRST_COLUMN_X - RIGHT_MARGIN;
      this._battleNameCheckIcon.x = this._startButton.x - 35;
      this._battleNameCheckIcon.y = this._startButton.y + 5;
    }

    public function setupFormatComboBoxHeight(param1:int) : void {
      var local2:int = 34;
      this._chooseFormatComboBox.height = local2 + param1 * this._chooseFormatComboBox.rowHeight;
    }

    private function getBackgroundHeight() : Number {
      return Math.max(display.stage.stageHeight - HEADER_HEIGHT,MIN_FLASH_HEIGHT);
    }

    private function resizeWithDelay(param1:int = 200) : void {
      clearTimeout(this._timeOutResize);
      this._timeOutResize = setTimeout(this.onResizeWithDelay,param1);
    }

    private function onResizeWithDelay() : void {
      this.resize(false);
    }

    public function setMapsInfo(param1:Array) : void {
      var local4:CreateBattleMapParams = null;
      this._chooseMapComboBox.clear();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3] as CreateBattleMapParams;
        this._chooseMapComboBox.addItem({
          "index":local4.index,
          "gameName":local4.gameName,
          "id":local4.id,
          "minRank":local4.minRank,
          "maxRank":local4.maxRank,
          "rang":local4.currentRank,
          "maxPeople":local4.maxPeople,
          "battleModes":local4.battleModes,
          "matchmakingMark":local4.matchmakingMark
        });
        local3++;
      }
    }

    public function setThemeInfo(param1:Array) : void {
      var local4:MapTheme = null;
      this._chooseThemeMapComboBox.clear();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3].theme;
        this._chooseThemeMapComboBox.addItem({
          "gameName":CreateBattleFormLabels.getThemeName(local4),
          "themeName":param1[local3].gameName,
          "id":param1[local3].id,
          "rang":param1[local3].rang,
          "theme":local4,
          "sortIndex":local4.value
        });
        local3++;
      }
      this._chooseThemeMapComboBox.sortOn("sortIndex",[Array.NUMERIC]);
      this._chooseThemeMapComboBox.height = 34 + local2 * 20;
    }

    public function selectMap(param1:String, param2:String) : void {
      this._chooseMapComboBox.selectItemByField(param1,param2);
    }

    public function setSelectMapThemeItemByField(param1:String, param2:String) : void {
      this._chooseThemeMapComboBox.selectItemByField(param1,param2);
    }

    public function getSelectMapItem() : Object {
      return this._chooseMapComboBox.selectedItem;
    }

    public function getSelectedThemeItem() : Object {
      return this._chooseThemeMapComboBox.selectedItem;
    }

    public function showThemeForMap() : void {
      this._isShowThemeComboBox = true;
      this._chooseThemeMapComboBox.visible = this._isShowThemeComboBox;
      this.resizeMapAndThemeComboBoxes();
    }

    public function hideThemeForMap() : void {
      this._isShowThemeComboBox = false;
      this._chooseThemeMapComboBox.visible = this._isShowThemeComboBox;
      this.resizeMapAndThemeComboBoxes();
    }

    public function setSettingsPlayersLimit(param1:int, param2:int) : void {
      this._maxNumberPlayersStepper.minValue = param1;
      this._maxNumberPlayersStepper.maxValue = param2;
      this._maxNumberPlayersStepper.value = param2;
    }

    public function setSettingsTimeLimit(param1:int, param2:int, param3:int) : void {
      this._timeLimitStepper.minValue = param1;
      this._timeLimitStepper.maxValue = param2;
      this._timeLimitStepper.value = param3;
    }

    public function setSettingsScoreLimit(param1:int, param2:int, param3:int, param4:String, param5:DisplayObject) : void {
      this._scoreLimitStepper.minValue = 0;
      this._scoreLimitStepper.maxValue = param1;
      this._scoreLimitStepper.value = param2;
      this._scoreLimitStepper.step = param3;
      this._scoreLimitStepper.label = param4;
      this._scoreLimitStepper.icon = param5;
    }

    public function setNameMaxPlayersStepper() : void {
      this._maxNumberPlayersStepper.label = CreateBattleFormLabels.stepperMaxPlayersLabel;
    }

    public function setNameMaxPlayersTeamStepper() : void {
      this._maxNumberPlayersStepper.label = CreateBattleFormLabels.stepperMaxTeamPlayersLabel;
    }

    public function getTimeLimit() : int {
      return this._timeLimitStepper.value;
    }

    public function getScoreLimit() : int {
      return this._scoreLimitStepper.value;
    }

    public function getNumberPlayers() : int {
      return this._maxNumberPlayersStepper.value;
    }

    private function resizeMapAndThemeComboBoxes() : void {
      var local1:Number = this.getBackgroundWidth();
      if(this._isShowThemeComboBox) {
        this._chooseMapComboBox.width = int(local1 / 2 - this._chooseMapComboBox.x - 11);
        this._chooseThemeMapComboBox.width = int(local1 / 2 - this._chooseMapComboBox.x - 10);
        this._chooseThemeMapComboBox.x = int(local1 / 2 + this._chooseMapComboBox.x);
      } else {
        this._chooseMapComboBox.width = local1 - this._chooseMapComboBox.x - 11;
      }
      this._chooseThemeMapComboBox.y = 11;
    }

    private function getBackgroundWidth() : Number {
      return int(Math.max(MIN_FLASH_WIDTH,display.stage.stageWidth)) / 3;
    }

    private function onPrivateBattleChange(param1:CheckBoxEvent) : void {
      this.trackOnce("privateBattleChange");
    }

    private function onRankLimitChanged(param1:SelectRankSliderEvent) : void {
      this.trackOnce("rankLimitChange");
    }

    private function onStartButtonClick(param1:MouseEvent) : void {
      this.controller.onCreateBattle();
      this.trackOnce("startBattle");
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    private function onMapChange(param1:Event) : void {
      this.controller.onMapChange();
      this.trackOnce("mapChange");
    }

    private function onMapComboBoxOpen(param1:Event) : void {
      this.trackOnce("mapComboBoxOpen");
    }

    private function onThemeComboBoxOpen(param1:Event) : void {
      this.trackOnce("themeComboBoxOpen");
    }

    private function onThemeChange(param1:Event) : void {
      this.controller.onThemeChange();
      this.trackOnce("themeChange");
    }

    private function onPlayersNumberChange(param1:Event) : void {
      this.controller.onPlayersNumberChange();
    }

    private function onTimeLimitChange(param1:Event) : void {
      this.controller.onTimeLimitChange();
    }

    private function onScoreLimitChange(param1:Event) : void {
      this.controller.onScoreLimitChange();
    }

    private function onNoSuppliesChange(param1:CheckBoxEvent) : void {
      this.trackOnce("supplyChange");
      this._dependentCooldownCheckBox.visible = this._suppliesCheckBox.checked;
      this.updateUltimate();
      this.updateOptions();
    }

    private function onFriendlyFireChange(param1:CheckBoxEvent) : void {
      this.trackOnce("friendlyFireChange");
    }

    private function onBonusesChange(param1:CheckBoxEvent) : void {
      this.trackOnce("bonusesChange");
      this.updateUltimate();
      this.updateOptions();
    }

    private function onGoldBoxesChange(param1:CheckBoxEvent) : void {
      this.trackOnce("goldBoxesChange");
    }

    private function onAutoBalanceChange(param1:CheckBoxEvent) : void {
      this.trackOnce("autoBalanceChange");
    }

    private function onClanChange(param1:CheckBoxEvent) : void {
      this.trackOnce("clanChange");
    }

    private function onScoreLimitChangeTrack(param1:MouseEvent) : void {
      this.trackOnce("scoreLimitChange");
    }

    private function onPlayersNumberChangeTrack(param1:MouseEvent) : void {
      this.trackOnce("playersNumberChange");
    }

    private function onTimeLimitChangeTrack(param1:MouseEvent) : void {
      this.trackOnce("timeLimitChange");
    }

    private function onReArmorChange(param1:CheckBoxEvent) : void {
      this.controller.onReArmorChanged();
      this.trackOnce("ReArmorChange");
    }

    private function trackOnce(param1:String) : void {
      if(this._trackedEvents[param1] == null) {
        this._trackedEvents[param1] = true;
        trackerService.trackEvent(GA_CATEGORY,GA_ACTION,param1);
      }
    }

    public function setBattleFormats(param1:Vector.<Object>) : void {
      var local2:int = 0;
      while(local2 < param1.length) {
        this._chooseFormatComboBox.addItem(param1[local2]);
        local2++;
      }
      this.setupFormatComboBoxHeight(param1.length);
    }

    public function getSelectedFormatItem() : Object {
      return this._chooseFormatComboBox.selectedItem;
    }

    public function resetReArmorCheckbox() : void {
      this._reArmorCheckBox.setCheckedWithoutEvent(false);
    }

    public function resetUpgradesAndDevicesCheckbox() : void {
      this._upgradesCheckBox.setCheckedWithoutEvent(false);
      this._devicesCheckBox.setCheckedWithoutEvent(false);
    }

    public function selectFormatByIndex(param1:int) : void {
      this._chooseFormatComboBox.selectItemByField("index",param1);
    }

    public function resetDependentCooldownCheckBox() : void {
      this._dependentCooldownCheckBox.setCheckedWithoutEvent(false);
    }

    public function resetDronesCheckBox() : void {
      this._dronesCheckBox.setCheckedWithoutEvent(false);
    }

    public function isUltimatesEnabled() : Boolean {
      return this.ultimatesCheckBox.checked;
    }

    public function resetUltimatesCheckBox() : void {
      this.ultimatesCheckBox.setCheckedWithoutEvent(false);
    }

    public function showInvalidRectangleBattleName() : void {
      this._battleNameTextInput.validValue = false;
    }

    public function hideInvalidRectangleBattleName() : void {
      this._battleNameTextInput.validValue = true;
    }

    public function setBattleName(param1:String) : void {
      this._battleNameTextInput.value = param1;
    }

    public function getBattleName() : String {
      return this._battleNameTextInput.value;
    }

    public function getBattleNameLength() : int {
      return this._battleNameTextInput.textField.length;
    }

    private function onBattleNameChange(param1:LoginFormEvent) : void {
      this.controller.onBattleNameChange();
      this.trackOnce("battleNameChange");
    }

    private function onBattleNameInFocus(param1:FocusEvent) : void {
      this.controller.onBattleNameInFocus();
    }

    private function onBattleNameOutFocus(param1:FocusEvent) : void {
      this.controller.onBattleNameOutFocus();
    }

    public function setProgressBattleNameCheckIcon() : void {
      this._battleNameCheckIcon.startProgress();
    }

    public function resetProgressBattleNameCheckIcon() : void {
      this._battleNameCheckIcon.turnOff();
    }

    private function updateUltimate() : void {
      this.ultimatesCheckBox.visible = this.controller.battleCreateParams.ultimatesEnabled && (this._suppliesCheckBox.checked || this._bonusesCheckBox.checked);
      if(!this.ultimatesCheckBox.visible) {
        this.ultimatesCheckBox.setCheckedWithoutEvent(false);
      }
    }

    private function updateDrones() : void {
      this._dronesCheckBox.visible = this._suppliesCheckBox.checked && (this.getSelectedFormatItem().index == 0 || Boolean(this.getSelectedFormatItem().parkour));
      if(!this._dronesCheckBox.visible) {
        this._dronesCheckBox.setCheckedWithoutEvent(false);
      }
    }
  }
}
