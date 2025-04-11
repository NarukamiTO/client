package alternativa.tanks.controllers.battlecreate {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.map.mapinfo.IMapInfo;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.view.battlecreate.CreateBattleFormLabels;
  import alternativa.tanks.view.battlecreate.CreateBattleFormView;
  import alternativa.tanks.view.battlelist.modefilter.BattleModeIcons;
  import alternativa.types.Long;
  import assets.icons.BattleInfoIcons;
  import controls.checkbox.CheckBoxEvent;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.TimerEvent;
  import flash.net.SharedObject;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  import mx.utils.StringUtil;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battleselect.create.BattleCreateCC;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;

  public class CreateBattleFormController extends EventDispatcher {
    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var battleFormatUtil:BattleFormatUtil;

    [Inject]
    public static var localeService:ILocaleService;

    private static const SECONDS_IN_MINUTE:int = 60;
    private static const NON_FORMAT_BATTLE_MODE_INDEX:int = 0;
    private static const MAX_RANK:int = 31;
    private static const MIN_RANK:int = 1;
    private static const MIN_RANK_INTERVAL_LENGTH:int = 1;
    private static const MIN_PLAYER_FOR_DEATH_MATCH:int = 2;
    private static const MIN_PLAYER_FOR_TEAM_BATTLE:int = 1;
    private static const SCORE_STEP_COMMON:int = 1;
    private static const SCORE_STEP_CP:int = 10;
    private static const SCORE_STEP_ASL:int = 10;

    private var _battlesLimits:Vector.<BattleLimits>;
    private var scoreLimits:Vector.<int>;
    private var _timeLimitInSec:int = 1800;
    private var _maxPeopleCount:int;
    private var _battleMode:BattleMode = BattleMode.DM;
    private var _view:CreateBattleFormView;
    private var _mapThemes:Dictionary = new Dictionary();
    private var _currentRank:int = -1;
    private var _mapsParams:Array;
    private var _mapParamsForCurrentRank:Array;
    private var _themeName:String;
    private var _isShowForm:Boolean;

    public var battleCreateParams:BattleCreateCC;

    private var _checkedBattleNameTimer:Timer;
    private var _isAutoName:Boolean;
    private var _isCheckedServerBattleName:Boolean;
    private var _battleNameBeforeCheck:String;

    public function CreateBattleFormController(param1:BattleCreateCC, param2:Vector.<IGameObject>) {
      super();
      this.battleCreateParams = param1;
      this._view = new CreateBattleFormView(this);
      this.init(param2);
    }

    public static function getIcon(param1:int) : DisplayObject {
      var local2:BattleInfoIcons = new BattleInfoIcons();
      local2.type = param1;
      return local2;
    }

    private function init(param1:Vector.<IGameObject>) : void {
      this._battlesLimits = this.battleCreateParams.battlesLimits;
      this.scoreLimits = new Vector.<int>(BattleMode.values.length);
      this._checkedBattleNameTimer = new Timer(1200);
      this._checkedBattleNameTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
      this._view.setMaxRankRange(this.battleCreateParams.maxRangeLength - 1);
      this._view.setRankIntervalRestriction(MIN_RANK,MAX_RANK,MIN_RANK_INTERVAL_LENGTH);
      this._view.resetPrivateBattleCheckBox();
      this._view.setBattleFormats(this.createFormatBattleModeDatas());
      this.parseMapsParams(param1);
    }

    private function parseMapsParams(param1:Vector.<IGameObject>) : void {
      var local4:IGameObject = null;
      var local5:IMapInfo = null;
      var local6:CreateBattleMapParams = null;
      this._mapsParams = new Array();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        local5 = IMapInfo(local4.adapt(IMapInfo));
        local6 = new CreateBattleMapParams();
        local6.index = local3;
        local6.id = local5.getMapId();
        local6.previewResource = local5.getPreviewResource();
        local6.gameName = local5.getName();
        local6.maxPeople = local5.getMaxPeople();
        local6.maxRank = local5.getMaxRank();
        local6.minRank = local5.getMinRank();
        local6.themeName = local5.getThemeName();
        local6.theme = local5.getTheme();
        local6.battleModes = local5.getSupportedBattleModes();
        local6.enabled = local5.isEnabled();
        local6.defaultTheme = local5.getDefaultTheme();
        local6.matchmakingMark = local5.hasMatchmakingMark();
        this._mapsParams.push(local6);
        local3++;
      }
    }

    public function onPlayersNumberChange() : void {
      this._maxPeopleCount = this._view.getNumberPlayers();
    }

    public function onTimeLimitChange() : void {
      this._timeLimitInSec = this._view.getTimeLimit() * SECONDS_IN_MINUTE;
      this.checkedCorrectBattleParams();
    }

    public function onScoreLimitChange() : void {
      this.scoreLimits[this._battleMode.value] = this._view.getScoreLimit();
      this.checkedCorrectBattleParams();
    }

    public function setBattleMode(param1:BattleMode) : void {
      var local3:int = 0;
      this._battleMode = param1;
      var local2:int = this._battlesLimits[this._battleMode.value].timeLimitInSec;
      if(this._timeLimitInSec > local2) {
        this._timeLimitInSec = local2;
      }
      this._view.setTypeBattle(this._battleMode);
      if(this._battleMode == BattleMode.DM) {
        this._maxPeopleCount = int(this.getSelectedMapParams().maxPeople);
        local3 = MIN_PLAYER_FOR_DEATH_MATCH;
      } else {
        this._maxPeopleCount = int(this.getSelectedMapParams().maxPeople) / 2;
        local3 = MIN_PLAYER_FOR_TEAM_BATTLE;
      }
      this._view.setSettingsPlayersLimit(local3,this._maxPeopleCount);
      this._view.setSettingsTimeLimit(0,local2 / SECONDS_IN_MINUTE,this._timeLimitInSec / SECONDS_IN_MINUTE);
      var local4:int = this._battlesLimits[this._battleMode.value].scoreLimit;
      this.scoreLimits[this._battleMode.value] = this.clamp(this.scoreLimits[this._battleMode.value],0,local4);
      var local5:int = this.scoreLimits[this._battleMode.value];
      switch(this._battleMode) {
        case BattleMode.DM:
          this._view.setSettingsScoreLimit(local4,local5,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperKillsLimitLabel,getIcon(BattleInfoIcons.KILL_LIMIT));
          this._view.setNameMaxPlayersStepper();
          break;
        case BattleMode.TDM:
          this._view.setSettingsScoreLimit(local4,local5,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperKillsLimitLabel,getIcon(BattleInfoIcons.KILL_LIMIT));
          this._view.setNameMaxPlayersTeamStepper();
          break;
        case BattleMode.CTF:
          this._view.setSettingsScoreLimit(local4,local5,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperFlagsLimitLabel,getIcon(BattleInfoIcons.CTF));
          this._view.setNameMaxPlayersTeamStepper();
          break;
        case BattleMode.CP:
          this._view.setSettingsScoreLimit(local4,local5,SCORE_STEP_CP,CreateBattleFormLabels.stepperDominationLimitLabel,getIcon(BattleInfoIcons.TEAM_SCORE));
          this._view.setNameMaxPlayersTeamStepper();
          break;
        case BattleMode.AS:
          this._view.setSettingsScoreLimit(local4,local5,SCORE_STEP_ASL,CreateBattleFormLabels.stepperDominationLimitLabel,new Bitmap(BattleModeIcons.getIcon(BattleMode.AS)));
          this._view.setNameMaxPlayersTeamStepper();
          break;
        case BattleMode.RUGBY:
          this._view.setSettingsScoreLimit(local4,local5,SCORE_STEP_COMMON,CreateBattleFormLabels.stepperDominationLimitLabel,new Bitmap(BattleModeIcons.getIcon(BattleMode.RUGBY)));
          this._view.setNameMaxPlayersTeamStepper();
      }
      this._view.updateOptions();
    }

    private function clamp(param1:int, param2:int, param3:int) : int {
      if(param1 < param2) {
        return param2;
      }
      if(param1 > param3) {
        return param3;
      }
      return param1;
    }

    public function onMapChange() : void {
      this.updateThemes();
      this.updateParams();
    }

    public function onThemeChange() : void {
      this._themeName = this._view.getSelectedThemeItem().themeName;
      this.updateParams();
    }

    private function updateParams() : void {
      this.updateRangeRank();
      this.setAvailableBattleTypes();
      this.selectBattleType(this._battleMode);
      this.saveMapParamInStorage();
      this._view.battleInfo.updatePreview(this.getSelectedMapParams().previewResource);
      this._view.battleInfo.setMatchmakingMark(this._view.getSelectMapItem().matchmakingMark);
      var local1:Object = this._view.getSelectedFormatItem();
      if(local1 == null || local1.index == 0) {
        this._view.setBattleName(this._view.getSelectMapItem().gameName);
      } else {
        this._view.setBattleName(this._view.getSelectMapItem().gameName + " " + local1.gameName);
      }
    }

    public function destroy() : void {
      this._view.destroy();
      this._view = null;
    }

    public function showForm() : void {
      this._isShowForm = true;
      if(this._currentRank != userPropertiesService.rank) {
        this._currentRank = userPropertiesService.rank;
        if(this._currentRank < MIN_RANK) {
          this._currentRank = MIN_RANK;
        }
        this._view.setCurrentRank(this._currentRank);
        this.updateAvailableMaps();
        this.selectDefaultMap();
      }
      achievementService.showStartButtonHelper();
      this._view.show();
    }

    public function hideForm() : void {
      this._isShowForm = false;
      this._view.hide();
      achievementService.hideStartButtonHelper();
    }

    private function checkedCorrectBattleParams() : void {
      if(this.isBattleParamsCorrect()) {
        this._view.unBlockedStartButton();
      } else {
        this._view.blockedStartButton();
      }
    }

    private function isBattleParamsCorrect() : Boolean {
      return Boolean(StringUtil.trim(this._view.getBattleName())) && (this._view.getTimeLimit() != 0 || this._view.getScoreLimit() != 0);
    }

    private function setAvailableBattleTypes() : void {
      this._view.setAvailableTypesBattle(this.getSelectedMapParams().battleModes);
    }

    private function updateRangeRank() : void {
      var local1:CreateBattleMapParams = this.getSelectedMapParams();
      var local2:Range = this.battleCreateParams.maxRange;
      var local3:int = Math.max(local2.min,local1.minRank);
      var local4:int = Math.min(local2.max,local1.maxRank);
      this._view.setRankIntervalRestriction(local3,local4,MIN_RANK_INTERVAL_LENGTH);
      var local5:Range = this.battleCreateParams.defaultRange;
      this._view.setMinRang(Math.max(local5.min,this._view.getMinRangValue()));
      this._view.setMaxRang(Math.min(local5.max,this._view.getMaxRangValue()));
    }

    private function updateThemes() : void {
      var local3:Array = null;
      var local4:String = null;
      var local5:String = null;
      var local6:SaveMapParams = null;
      var local7:CreateBattleMapParams = null;
      var local8:CreateBattleMapParams = null;
      var local9:Object = null;
      var local1:Long = this._view.getSelectMapItem().id;
      var local2:Dictionary = this._mapThemes[local1];
      if(local2 != null) {
        local3 = new Array();
        local4 = null;
        for(local5 in local2) {
          local8 = this._mapThemes[local1][local5];
          if(this._currentRank >= local8.minRank && this._currentRank <= local8.maxRank) {
            local3.push({
              "gameName":local5,
              "id":local8.id,
              "rang":0,
              "theme":local8.theme
            });
          }
          if(local8.defaultTheme != null && local8.defaultTheme.name == local8.theme.name) {
            local4 = local5;
          }
        }
        local3.sortOn(["gameName"]);
        this._view.setThemeInfo(local3);
        local6 = this.getSaveMapParams();
        if(local6 != null && local6.selectedThemes != null && local6.selectedThemes[local1] != null) {
          this._themeName = local6.selectedThemes[local1];
        } else if(local4 != null) {
          this._themeName = local4;
        }
        local7 = this._mapThemes[this._view.getSelectMapItem().id][this._themeName];
        if(this._themeName != null && this.isMapAndThemeAvailable(local7)) {
          this._view.setSelectMapThemeItemByField("themeName",this._themeName);
        } else {
          local9 = this._view.getSelectedThemeItem();
          this._themeName = local9 != null ? local9.themeName : null;
        }
        if(local3.length > 1) {
          this._view.showThemeForMap();
        } else {
          this._view.hideThemeForMap();
        }
      }
    }

    private function isMapAndThemeAvailable(param1:CreateBattleMapParams) : Boolean {
      return param1 != null && param1.enabled && this._currentRank >= param1.minRank && this._currentRank <= param1.maxRank;
    }

    private function getSelectedMapParams() : CreateBattleMapParams {
      return CreateBattleMapParams(this._mapThemes[this._view.getSelectMapItem().id][this._themeName]);
    }

    private function updateAvailableMaps() : void {
      var local1:CreateBattleMapParams = null;
      this._mapThemes = new Dictionary();
      this._mapParamsForCurrentRank = new Array();
      for each(local1 in this._mapsParams) {
        if(local1.enabled && this._currentRank <= local1.maxRank) {
          if(this._mapThemes[local1.id] == undefined) {
            this._mapThemes[local1.id] = new Dictionary();
            local1.currentRank = this._currentRank >= local1.minRank ? 0 : local1.minRank;
            this._mapParamsForCurrentRank.push(local1);
          }
          this._mapThemes[local1.id][local1.themeName] = local1;
        }
      }
      if(this._mapParamsForCurrentRank.length != 0) {
        this._mapParamsForCurrentRank.sortOn(["currentRank","gameName"],[Array.NUMERIC,null]);
        this._view.setMapsInfo(this._mapParamsForCurrentRank);
        return;
      }
      throw new ArgumentError("For your rank is not available maps");
    }

    private function selectDefaultMap() : void {
      var local1:String = null;
      var local2:SaveMapParams = this.getSaveMapParams();
      var local3:CreateBattleMapParams = this.getMapParams(local2.mapId,local2.themeName);
      if(this.isMapAndThemeAvailable(local3)) {
        local1 = local3.gameName;
        this._themeName = local3.themeName;
      } else {
        local1 = this._mapParamsForCurrentRank[0].gameName;
        this._themeName = this._mapParamsForCurrentRank[0].themeName;
      }
      this._view.selectMap("gameName",local1);
      this.onMapChange();
    }

    private function getMapParams(param1:Long, param2:String) : CreateBattleMapParams {
      var local3:int = int(this._mapsParams.length);
      var local4:int = 0;
      while(local4 < local3) {
        if(this._mapsParams[local4].id == param1 && this._mapsParams[local4].themeName == param2) {
          return this._mapsParams[local4];
        }
        local4++;
      }
      return null;
    }

    private function getSaveMapParams() : SaveMapParams {
      var local1:SaveMapParams = new SaveMapParams();
      var local2:SharedObject = storageService.getStorage();
      var local3:Vector.<Object> = local2.data.SelectedMap != null && local2.data.SelectedMap is Vector.<Object> ? local2.data.SelectedMap as Vector.<Object> : new Vector.<Object>();
      var local4:int = 0;
      while(local4 < local3.length) {
        if(local3[local4].userName == userPropertiesService.userName) {
          local1.mapId = Long.getLong(int(local3[local4].mapIdHigh),int(local3[local4].mapIdLow));
          local1.themeName = local3[local4].mapTheme;
          local1.selectedThemes = local3[local4].selectedThemes;
          break;
        }
        local4++;
      }
      return local1;
    }

    private function saveMapParamInStorage() : void {
      var local6:Object = null;
      var local1:SharedObject = storageService.getStorage();
      var local2:Vector.<Object> = local1.data.SelectedMap != null && local1.data.SelectedMap is Vector.<Object> ? local1.data.SelectedMap as Vector.<Object> : new Vector.<Object>();
      var local3:int = -1;
      var local4:int = 0;
      while(local4 < local2.length) {
        if(local2[local4].userName == userPropertiesService.userName) {
          local3 = local4;
          break;
        }
        local4++;
      }
      var local5:CreateBattleMapParams = this.getSelectedMapParams();
      if(local3 != -1) {
        local6 = local2[local3];
      } else {
        local6 = new Object();
        local6.userName = userPropertiesService.userName;
        local2.push(local6);
      }
      local6.mapIdLow = local5.id.low;
      local6.mapIdHigh = local5.id.high;
      local6.mapTheme = local5.themeName;
      if(local6.selectedThemes == null) {
        local6.selectedThemes = new Object();
      }
      local6.selectedThemes[local5.id] = local5.themeName;
      local1.data.SelectedMap = local2;
    }

    private function selectBattleType(param1:BattleMode) : void {
      if(this.isTypeBattleContainedSelectedMap(param1)) {
        this.setBattleMode(param1);
      } else {
        this.setBattleMode(this.getSelectedMapParams().battleModes[0]);
      }
    }

    private function isTypeBattleContainedSelectedMap(param1:BattleMode) : Boolean {
      var local2:Boolean = false;
      var local3:Vector.<BattleMode> = this.getSelectedMapParams().battleModes;
      var local4:int = 0;
      while(local4 < local3.length) {
        if(local3[local4] == param1) {
          local2 = true;
          break;
        }
        local4++;
      }
      return local2;
    }

    public function onCreateBattle() : void {
      var local1:BattleCreateParameters = null;
      if(this.isBattleParamsCorrect()) {
        local1 = new BattleCreateParameters();
        local1.battleMode = this._battleMode;
        local1.limits = new BattleLimits(this._view.getScoreLimit(),this._view.getTimeLimit() * SECONDS_IN_MINUTE);
        local1.mapId = this._view.getSelectedThemeItem().id;
        local1.theme = this._view.getSelectedThemeItem().theme;
        local1.maxPeopleCount = this._maxPeopleCount;
        local1.rankRange = new Range(this._view.getMaxRank(),this._view.getMinRank());
        local1.proBattle = true;
        local1.privateBattle = this._view.isPrivateBattle;
        local1.withoutSupplies = this._view.isNoSuppliesBattle;
        local1.withoutUpgrades = this._view.isWithoutUpgrades;
        local1.withoutDevices = this._view.isWithoutDevices;
        local1.withoutBonuses = this._view.isWithoutBonuses;
        local1.goldBoxesEnabled = this._view.isGoldBoxesEnabled;
        local1.autoBalance = this._view.isAutoBalance;
        local1.friendlyFire = this._view.isFriendlyFire;
        local1.withoutDrones = this._view.isWithoutDrones;
        local1.reArmorEnabled = this._view.isReArmor;
        local1.dependentCooldownEnabled = this._view.isDependentCooldownBattle;
        local1.equipmentConstraintsMode = this.getEquipmentConstraintsMode();
        local1.parkourMode = this.isParkourFormatItemSelected();
        local1.clanBattle = this._view.isClanBattle;
        local1.ultimatesEnabled = this._view.isUltimatesEnabled();
        local1.name = this._view.getBattleName();
        dispatchEvent(new CreateBattleEvent(local1));
        this.hideForm();
        achievementService.hideAllBubbles(true);
      }
    }

    private function isParkourFormatItemSelected() : Boolean {
      return this._view.getSelectedFormatItem().parkour;
    }

    private function getEquipmentConstraintsMode() : String {
      return this._view.getSelectedFormatItem().equipmentConstraintsMode;
    }

    private function createFormatBattleModeDatas() : Vector.<Object> {
      var local3:Object = null;
      var local1:Vector.<Object> = new Vector.<Object>();
      var local2:int = 0;
      local1.push({
        "index":local2++,
        "gameName":localeService.getText(TanksLocale.TEXT_FORMAT_NAME_NONE),
        "equipmentConstraintsMode":null,
        "parkour":false,
        "rang":0
      });
      for each(local3 in battleFormatUtil.getEquipmentConstraintsModes()) {
        local1.push({
          "index":local2++,
          "gameName":local3.name,
          "equipmentConstraintsMode":local3.mode,
          "parkour":false,
          "rang":0
        });
      }
      local1.push({
        "index":local2,
        "gameName":battleFormatUtil.getParkourFormatName(),
        "equipmentConstraintsMode":null,
        "parkour":true,
        "rang":0
      });
      return local1;
    }

    public function onFormatChange(param1:Event) : void {
      if(this.isParkourFormatItemSelected()) {
        this._view.resetDependentCooldownCheckBox();
      } else if(this.getEquipmentConstraintsMode() != null) {
        this._view.resetReArmorCheckbox();
        this._view.resetUpgradesAndDevicesCheckbox();
        this._view.resetUltimatesCheckBox();
      }
      this._view.updateOptions();
      this.updateParams();
    }

    public function onUpgradesOrDevicesChange(param1:Event) : void {
      if(!this._view.isWithoutUpgrades || !this._view.isWithoutDevices) {
        this.resetEquipConstraintsViewFormat();
      }
    }

    public function onReArmorChanged() : void {
      if(this._view.isReArmor) {
        this.resetEquipConstraintsViewFormat();
      }
    }

    private function resetEquipConstraintsViewFormat() : void {
      if(!this.isParkourFormatItemSelected()) {
        this.resetFormatComboBox();
      }
    }

    public function onDependentCooldownChange(param1:CheckBoxEvent) : void {
      if(this._view.isDependentCooldownBattle && this.isParkourFormatItemSelected()) {
        this.resetFormatComboBox();
      }
    }

    private function resetFormatComboBox() : void {
      this._view.selectFormatByIndex(NON_FORMAT_BATTLE_MODE_INDEX);
    }

    public function onUltimatesChanged(param1:CheckBoxEvent) : void {
      if(this._view.isUltimatesEnabled() && this.getEquipmentConstraintsMode() != null) {
        this._view.selectFormatByIndex(NON_FORMAT_BATTLE_MODE_INDEX);
      }
    }

    public function onBattleNameChange() : void {
      this._view.blockedStartButton();
      this._checkedBattleNameTimer.stop();
      if(this._view.getBattleNameLength() != 0) {
        this._view.hideInvalidRectangleBattleName();
        this._isCheckedServerBattleName = false;
        this._checkedBattleNameTimer.start();
      } else {
        this._view.showInvalidRectangleBattleName();
      }
    }

    private function getAutoName() : String {
      return this.getSelectedMapParams().gameName + " " + this._battleMode.name;
    }

    public function onBattleNameInFocus() : void {
      if(this._view.getBattleName() == this.getAutoName()) {
        this._isAutoName = false;
        this._view.setBattleName("");
        this._view.showInvalidRectangleBattleName();
        this._view.blockedStartButton();
      }
    }

    public function checkedBattleNameResult(param1:String) : void {
      this._isCheckedServerBattleName = true;
      this._checkedBattleNameTimer.stop();
      if(this._view.getBattleName() == this._battleNameBeforeCheck && this._battleNameBeforeCheck != param1) {
        this._isAutoName = false;
        this._view.setBattleName(param1);
      }
      this._view.resetProgressBattleNameCheckIcon();
      if(this._view.getBattleNameLength() != 0) {
        this._view.hideInvalidRectangleBattleName();
      }
      this.checkedCorrectBattleParams();
    }

    private function setAutoNameBattle() : void {
      this._isAutoName = true;
      this._isCheckedServerBattleName = true;
      this._view.setBattleName(this.getAutoName());
      this._view.hideInvalidRectangleBattleName();
    }

    public function onBattleNameOutFocus() : void {
      if(this._view.getBattleNameLength() == 0) {
        this.setAutoNameBattle();
        if(this.isBattleParamsCorrect()) {
          this._view.unBlockedStartButton();
        }
      }
    }

    private function onTimer(param1:TimerEvent) : void {
      this._view.setProgressBattleNameCheckIcon();
      this._view.blockedStartButton();
      this._battleNameBeforeCheck = this._view.getBattleName();
      this._checkedBattleNameTimer.stop();
      dispatchEvent(new CheckBattleNameEvent(CheckBattleNameEvent.CHECK_NAME,this._battleNameBeforeCheck));
    }
  }
}
