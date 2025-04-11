package alternativa.tanks.view.battlelist {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controllers.battlelist.BattleListItemParams;
  import alternativa.tanks.controllers.battlelist.IBattleListViewControllerCallback;
  import alternativa.tanks.model.quest.common.gui.window.buttons.skin.GreenBigButtonSkin;
  import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.tanks.view.battlelist.battleitem.BattleListItem;
  import alternativa.tanks.view.battlelist.forms.BattleListRenderer;
  import alternativa.tanks.view.battlelist.help.LockedMapsHelper;
  import alternativa.tanks.view.battlelist.modefilter.BattleModeCheckBox;
  import alternativa.types.Long;
  import controls.BigButton;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import fl.controls.LabelButton;
  import fl.controls.List;
  import fl.controls.ScrollBar;
  import fl.data.DataProvider;
  import fl.events.ListEvent;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.TankWindowWithHeader;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;
  import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.probattle.IUserProBattleService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import utils.ScrollStyleUtils;

  public class BattleListView extends Sprite implements IBattleListView {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var userProBattleService:IUserProBattleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var battleSelectActionsService:UserBattleSelectActionsService;

    [Inject]
    public static var battleCreateFormService:IBattleCreateFormService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var reconnectService:ReconnectService;

    [Inject]
    public static var panelView:IPanelView;

    [Inject]
    public static var localeService:ILocaleService;

    private static const MIN_FLASH_WIDTH:int = 970;
    private static const MIN_FLASH_HEIGHT:int = 530;
    private static const HEADER_HEIGHT:int = 60;
    private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 7;
    private static const RESIZE_DELAY:int = 400;

    private const HELPER_GROUP_KEY:String = "BattleSelectModel";
    private const HELPER_NOT_AVAILABLE:int = 1;

    private var _lockedMapsHelper:LockedMapsHelper;
    private var _callback:IBattleListViewControllerCallback;
    private var _window:TankWindowWithHeader;
    private var _inner:TankWindowInner;
    private var _createBattleButton:DefaultButtonBase;
    private var findBattleButton:BigButton = new BigButton();
    private var _battleList:List;
    private var battleModeItems:Vector.<BattleModeCheckBox>;
    private var _dataProvider:DataProvider;
    private var _timeOutResize:uint;
    private var iconWidth:int = 100;
    private var lastSelectedBattleId:Long;

    public function BattleListView() {
      super();
      this._window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CURRENT_BATTLES);
      addChild(this._window);
      this._inner = new TankWindowInner(100,100,TankWindowInner.GREEN);
      this._inner.showBlink = true;
      addChild(this._inner);
      this._dataProvider = new DataProvider();
      this._battleList = new List();
      this._battleList.rowHeight = 20;
      this._battleList.setStyle("cellRenderer",BattleListRenderer);
      this._battleList.dataProvider = this._dataProvider;
      this._battleList.focusEnabled = true;
      addChild(this._battleList);
      this._battleList.move(15,70);
      this._battleList.verticalLineScrollSize = 12;
      ScrollStyleUtils.setGreenStyle(this._battleList);
      this._createBattleButton = new DefaultButtonBase();
      this._createBattleButton.label = LocaleBattleList.showBattleCreateFormLabel;
      this._createBattleButton.visible = !battleCreateFormService.battleCreationDisabled;
      addChild(this._createBattleButton);
      this.findBattleButton.setBigText();
      this.findBattleButton.width = 200;
      this.findBattleButton.label = localeService.getText(TanksLocale.TEXT_FIND_BATTLE_BUTTON_TEXT);
      this.findBattleButton.y = 12;
      this.findBattleButton.setSkin(GreenBigButtonSkin.GREEN_SKIN);
      this.findBattleButton.enabled = true;
      addChild(this.findBattleButton);
      this.initBattleModeFilter();
      this.resize();
    }

    private function initBattleModeFilter() : void {
      this.battleModeItems = new Vector.<BattleModeCheckBox>();
      this.createBattleModeCheckBox(BattleMode.DM);
      this.createBattleModeCheckBox(BattleMode.TDM);
      this.createBattleModeCheckBox(BattleMode.CTF);
      this.createBattleModeCheckBox(BattleMode.CP);
      this.createBattleModeCheckBox(BattleMode.AS);
      this.createBattleModeCheckBox(BattleMode.RUGBY);
      this.createBattleModeCheckBox(BattleMode.JGR);
      this.resize();
    }

    private function createBattleModeCheckBox(param1:BattleMode) : void {
      var local2:BattleModeCheckBox = new BattleModeCheckBox(param1);
      addChild(local2);
      this.battleModeItems.push(local2);
    }

    public function setCallBack(param1:IBattleListViewControllerCallback) : void {
      this._callback = param1;
    }

    public function show(param1:BattleMode) : void {
      if(!this.getContainer().contains(this)) {
        this.resize();
        this.setEvents();
        this.getContainer().addChild(this);
        this._lockedMapsHelper = new LockedMapsHelper();
        helpService.registerHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE,this._lockedMapsHelper,false);
        this.getBattleModeCheckBox(param1).isPressed = true;
      }
    }

    private function setEvents() : void {
      this.getStage().addEventListener(Event.RESIZE,this.onResize);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
      this._createBattleButton.addEventListener(MouseEvent.CLICK,this.onShowCreateBattleFormButtonClick);
      this._battleList.addEventListener(ListEvent.ITEM_CLICK,this.onBattleListItemClick);
      this._battleList.addEventListener(Event.CHANGE,this.onListChange);
      this.findBattleButton.addEventListener(MouseEvent.CLICK,this.onBackToMatchmakingClick);
      var local1:int = int(this.battleModeItems.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.battleModeItems[local2].addEventListener(Event.CHANGE,this.onBattleModeChange);
        local2++;
      }
    }

    public function hide() : void {
      if(this.getContainer().contains(this)) {
        this.removeEvents();
        this.getContainer().removeChild(this);
        helpService.hideHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
        helpService.unregisterHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
      }
    }

    public function destroy() : void {
      this.removeEvents();
      var local1:int = int(this.battleModeItems.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.battleModeItems[local2].destroy();
        local2++;
      }
      clearTimeout(this._timeOutResize);
      this.battleModeItems = null;
      this._lockedMapsHelper = null;
      this._callback = null;
    }

    private function removeEvents() : void {
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
      this.getStage().removeEventListener(Event.RESIZE,this.onResize);
      this._createBattleButton.removeEventListener(MouseEvent.CLICK,this.onShowCreateBattleFormButtonClick);
      this._battleList.removeEventListener(ListEvent.ITEM_CLICK,this.onBattleListItemClick);
      this._battleList.removeEventListener(Event.CHANGE,this.onListChange);
      this.findBattleButton.removeEventListener(MouseEvent.CLICK,this.onBackToMatchmakingClick);
      var local1:int = int(this.battleModeItems.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.battleModeItems[local2].removeEventListener(Event.CHANGE,this.onBattleModeChange);
        local2++;
      }
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      this.findBattleButton.enabled = true;
    }

    private function onBattleModeChange(param1:Event) : void {
      var local2:BattleModeCheckBox = BattleModeCheckBox(param1.currentTarget);
      this._callback.onBattleModeChange(local2.battleMode,local2.isPressed);
    }

    public function unPressFilter(param1:BattleMode) : void {
      this.getBattleModeCheckBox(param1).isPressed = false;
    }

    public function lockFilter(param1:BattleMode) : void {
      this.getBattleModeCheckBox(param1).lock = true;
    }

    public function unLockFilter(param1:BattleMode) : void {
      this.getBattleModeCheckBox(param1).lock = false;
    }

    private function getBattleModeCheckBox(param1:BattleMode) : BattleModeCheckBox {
      var local2:BattleModeCheckBox = null;
      for each(local2 in this.battleModeItems) {
        if(local2.battleMode == param1) {
          return local2;
        }
      }
      return null;
    }

    private function updateScrollOnEnterFrame(param1:Event) : void {
      var local4:Sprite = null;
      var local5:Sprite = null;
      var local2:ScrollBar = this._battleList.verticalScrollBar;
      var local3:int = 0;
      while(local3 < local2.numChildren) {
        local4 = Sprite(local2.getChildAt(local3));
        if(local4.hitArea != null) {
          local5 = local4.hitArea;
          local5.graphics.clear();
        } else {
          local5 = new Sprite();
          local5.mouseEnabled = false;
          local4.hitArea = local5;
          this._battleList.addChild(local5);
        }
        local5.graphics.beginFill(0,0);
        if(local4 is LabelButton) {
          local5.graphics.drawRect(local2.x - ADDITIONAL_SCROLL_AREA_HEIGHT,local4.y - 14,local4.width + ADDITIONAL_SCROLL_AREA_HEIGHT,local4.height + 28);
        } else {
          local5.graphics.drawRect(local2.x - ADDITIONAL_SCROLL_AREA_HEIGHT,local4.y,local4.width + ADDITIONAL_SCROLL_AREA_HEIGHT,local4.height);
        }
        local5.graphics.endFill();
        local3++;
      }
    }

    public function resize(param1:Boolean = true) : void {
      clearTimeout(this._timeOutResize);
      var local2:int = Math.max(MIN_FLASH_WIDTH,this.getStage().stageWidth) / 3;
      var local3:int = Math.max(this.getStage().stageHeight - HEADER_HEIGHT,MIN_FLASH_HEIGHT);
      this._window.width = local2;
      this._window.height = local3;
      this.x = local2;
      this.y = HEADER_HEIGHT;
      this._inner.width = local2 - 22;
      this._inner.height = local3 - 115;
      this._inner.x = 11;
      this._inner.y = 67;
      this.findBattleButton.x = (local2 - this.findBattleButton.width) / 2;
      var local4:int = this._inner.width - (this._battleList.verticalScrollBar.visible ? 0 : 4);
      this._battleList.setSize(local4,this._inner.height - 8);
      var local5:int = int(this.battleModeItems.length);
      var local6:int = 0;
      while(local6 < local5) {
        if(local6 == 0) {
          this.battleModeItems[local6].x = 11;
        } else {
          this.battleModeItems[local6].x = this.battleModeItems[local6 - 1].x + this.battleModeItems[local6 - 1].width + 5;
        }
        this.battleModeItems[local6].y = local3 - 42;
        local6++;
      }
      this._createBattleButton.x = local2 - this._createBattleButton.width - 11;
      this._createBattleButton.y = local3 - 42;
      this.resizeItems(local4);
      if(param1) {
        this.resizeWithDelay();
      }
    }

    private function resizeItems(param1:int) : void {
      var local3:Object = null;
      this.iconWidth = param1 - (this._battleList.verticalScrollBar.visible ? 35 : 20);
      var local2:int = 0;
      while(local2 < this._dataProvider.length) {
        local3 = this._dataProvider.getItemAt(local2);
        BattleListItem(local3.iconNormal).resize(this.iconWidth);
        this._dataProvider.invalidateItemAt(local2);
        local2++;
      }
    }

    private function resizeWithDelay() : void {
      clearTimeout(this._timeOutResize);
      this._timeOutResize = setTimeout(this.onResizeWithDelay,RESIZE_DELAY);
    }

    private function onResizeWithDelay() : void {
      this.resize(false);
    }

    public function sortBattleList() : void {
      if(this._dataProvider.length == 0) {
        return;
      }
      this._dataProvider.sortOn(["suspicionLevel","accessible","createdAt"],[Array.NUMERIC,Array.DESCENDING,0]);
    }

    public function resetSelectedItem() : void {
      this._battleList.selectedItem = null;
    }

    public function createItem(param1:BattleListItemParams, param2:Boolean) : void {
      var local3:Object = new Object();
      var local4:BattleInfoBaseParams = param1.params;
      var local5:BattleCreateParameters = local4.createParams;
      local3.id = param1.id;
      local3.accessible = param1.accessible;
      local3.iconNormal = local3.iconSelected = new BattleListItem(param1,this.iconWidth);
      local3.suspicionLevel = local4.suspicionLevel.value;
      local3.dat = param1;
      local3.friends = local4.friends;
      local3.modeIndex = this.getModeSortIndex(local5.battleMode);
      var local6:BattleLimits = local5.limits;
      local3.timeLimit = local6.timeLimitInSec == 0 ? 999999 : local6.timeLimitInSec;
      local3.scoreLimit = local6.scoreLimit == 0 ? 0 : local6.scoreLimit;
      local3.mapName = local4.mapName;
      local3.customName = local4.customName;
      local3.formatName = param1.formatName;
      local3.proBattle = local5.proBattle ? 0 : 1;
      local3.isFull = this.isFullBattle(param1);
      local3.createdAt = param1.id.toString();
      if(this.getItemIndex(param1.id) < 0) {
        this._dataProvider.addItem(local3);
      }
      if(param2) {
        this.sortBattleList();
        this.resize();
        helpService.hideHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
      }
    }

    private function getModeSortIndex(param1:BattleMode) : int {
      switch(param1) {
        case BattleMode.CTF:
          return 1;
        case BattleMode.DM:
          return 2;
        case BattleMode.TDM:
          return 3;
        case BattleMode.CP:
          return 4;
        case BattleMode.AS:
          return 5;
        case BattleMode.RUGBY:
          return 6;
        default:
          return 0;
      }
    }

    private function isFullBattle(param1:BattleListItemParams) : Boolean {
      if(param1.isDM) {
        return param1.dmParams.users.length == param1.params.createParams.maxPeopleCount;
      }
      return param1.teamParams.usersRed.length == param1.params.createParams.maxPeopleCount && param1.teamParams.usersBlue.length == param1.params.createParams.maxPeopleCount;
    }

    public function removeItem(param1:Long) : void {
      var local2:int = this.getItemIndex(param1);
      if(local2 >= 0) {
        this._dataProvider.removeItemAt(local2);
        this.resizeWithDelay();
      }
    }

    public function setSelect(param1:Long) : void {
      var local2:int = this.getItemIndex(param1);
      if(local2 >= 0) {
        this._battleList.selectedIndex = local2;
        this._battleList.scrollToSelected();
        if(this.getStage().focus != this._battleList) {
          this.getStage().focus = this._battleList;
        }
        this.lastSelectedBattleId = BattleListItemParams(this._battleList.selectedItem.dat).id;
      } else {
        this._battleList.selectedItem = null;
      }
      this._battleList.drawNow();
    }

    public function updateSuspicious(param1:Long, param2:BattleSuspicionLevel) : void {
      var local4:Object = null;
      var local5:BattleListItemParams = null;
      var local3:int = this.getItemIndex(param1);
      if(local3 >= 0) {
        local4 = this._dataProvider.getItemAt(local3);
        local5 = local4.dat;
        BattleListItem(local4.iconNormal).updateSuspicion(param2);
        local4.suspicionLevel = param2.value;
        this._dataProvider.invalidateItemAt(local3);
        this.sortBattleList();
      }
    }

    public function updateUsersCount(param1:Long) : void {
      var local3:Object = null;
      var local4:BattleListItemParams = null;
      var local2:int = this.getItemIndex(param1);
      if(local2 >= 0) {
        local3 = this._dataProvider.getItemAt(local2);
        local4 = local3.dat;
        BattleListItem(local3.iconNormal).updateUsersCount();
        local3.isFull = this.isFullBattle(local4);
        this._dataProvider.invalidateItemAt(local2);
      }
    }

    public function updateBattleName(param1:Long) : void {
      var local2:int = this.getItemIndex(param1);
      if(local2 >= 0) {
        BattleListItem(this._dataProvider.getItemAt(local2).iconNormal).updateBattleName();
        this._dataProvider.invalidateItemAt(local2);
      }
    }

    public function swapTeams(param1:Long) : void {
      var local3:Object = null;
      var local4:BattleListItemParams = null;
      var local2:int = this.getItemIndex(param1);
      if(local2 >= 0) {
        local3 = this._dataProvider.getItemAt(local2);
        local4 = local3.dat;
        BattleListItem(local3.iconNormal).updateUsersCount();
        local3.isFull = this.isFullBattle(local4);
        this._dataProvider.invalidateItemAt(local2);
      }
    }

    public function updateAccessibleItems() : void {
      var local3:Object = null;
      var local4:BattleListItemParams = null;
      var local5:Range = null;
      var local6:Boolean = false;
      var local1:int = int(this._dataProvider.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this._dataProvider.getItemAt(local2);
        local4 = local3.dat;
        local5 = local4.params.createParams.rankRange;
        local6 = local5.min <= userPropertiesService.rank && userPropertiesService.rank <= local5.max;
        local4.accessible = local6;
        BattleListItem(local3.iconNormal).updateAccessible();
        local3.accessible = local6;
        this._dataProvider.invalidateItemAt(local2);
        local2++;
      }
      this.sortBattleList();
    }

    public function getItemIndex(param1:Long) : int {
      var local4:Object = null;
      var local2:int = int(this._dataProvider.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this._dataProvider.getItemAt(local3);
        if(local4.id == param1) {
          return local3;
        }
        local3++;
      }
      return -1;
    }

    private function onResize(param1:Event) : void {
      this.resize();
    }

    private function onShowCreateBattleFormButtonClick(param1:MouseEvent) : void {
      this._callback.onShowCreateBattleFormButtonClick();
    }

    private function onBattleListItemClick(param1:ListEvent) : void {
      var local2:Long = BattleListItemParams(param1.item.dat).id;
      if(local2 != this.lastSelectedBattleId) {
        this.lastSelectedBattleId = local2;
      }
      this._callback.onBattleListItemClick(BattleListItemParams(param1.item.dat).params.battle);
      battleSelectActionsService.battleSelected(BattleListItemParams(param1.item.dat).createParams.battleMode,local2);
      var local3:Boolean = BattleListItemParams(param1.item.dat).accessible;
      if(!local3) {
        this._lockedMapsHelper.targetPoint = new Point(this.getStage().mouseX,this.getStage().mouseY);
        helpService.showHelper(this.HELPER_GROUP_KEY,this.HELPER_NOT_AVAILABLE);
      }
    }

    private function onListChange(param1:Event) : void {
      if(this._battleList.selectedItem != null) {
        this._callback.onBattleListItemChange(BattleListItemParams(this._battleList.selectedItem.dat).params.battle);
      }
    }

    private function onBackToMatchmakingClick(param1:MouseEvent) : void {
      this.findBattleButton.enabled = false;
      this._callback.onBackToMatchmakingClick();
    }

    private function getContainer() : DisplayObjectContainer {
      return display.systemLayer;
    }

    private function getStage() : Stage {
      return display.stage;
    }

    public function setBattleButtonEnabled(param1:Boolean) : void {
      this.findBattleButton.enabled = param1;
    }

    public function setBattleCreationEnabled(param1:Boolean) : void {
      this._createBattleButton.visible = param1;
    }
  }
}
