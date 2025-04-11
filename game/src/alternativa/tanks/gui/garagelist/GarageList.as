package alternativa.tanks.gui.garagelist {
  import alternativa.tanks.gui.resistance.GarageResistancesIconsUtils;
  import assets.Diamond;
  import assets.icons.GarageItemBackground;
  import assets.icons.IconGarageMod;
  import assets.icons.InputCheckIcon;
  import base.DiscreteSprite;
  import controls.Money;
  import controls.base.LabelBase;
  import controls.labels.CountDownTimerLabel;
  import controls.saleicons.SaleIcons;
  import controls.timer.CountDownTimer;
  import fl.controls.LabelButton;
  import fl.controls.ScrollBar;
  import fl.controls.ScrollBarDirection;
  import fl.controls.TileList;
  import fl.data.DataProvider;
  import fl.events.ListEvent;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;
  import flash.system.Capabilities;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.getTimer;
  import forms.events.PartsListEvent;
  import forms.premium.PremiumItemLock;
  import forms.ranks.BigRankIcon;
  import forms.ranks.RankIcon;
  import forms.registration.CallsignIconStates;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
  import utils.ScrollStyleUtils;

  public class GarageList extends DiscreteSprite implements IResourceLoadingListener {
    private static const SALE_RED_LABEL:Bitmap = SaleIcons.createSaleRedLabelInstance();
    private static const mountedIconClass:Class = GarageList_mountedIconClass;
    private static const mountedIcon:BitmapData = new mountedIconClass().bitmapData;
    private static const MIN_POSIBLE_SPEED:Number = 70;
    private static const MAX_DELTA_FOR_SELECT:Number = 7;
    private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 3;
    private static const PREMIUM_ITEM_LOCK_X:int = 118;
    private static const PREMIUM_ITEM_LOCK_Y:int = 58;

    private var list:TileList;
    private var dp:DataProvider;
    private var _selectedItem:IGameObject = null;
    private var previousPositionX:Number;
    private var currrentPositionX:Number;
    private var sumDragWay:Number;
    private var lastItemIndex:int;
    private var previousTime:int;
    private var currentTime:int;
    private var scrollSpeed:Number = 0;
    private var _width:int;
    private var _height:int;

    public function GarageList() {
      super();
      this.init();
    }

    private function init() : void {
      this.dp = new DataProvider();
      this.list = new TileList();
      this.list.dataProvider = this.dp;
      this.list.rowCount = 1;
      this.list.rowHeight = 130;
      this.list.columnWidth = 203;
      this.list.setStyle("cellRenderer",GarageListRenderer);
      this.list.direction = ScrollBarDirection.HORIZONTAL;
      this.list.focusEnabled = false;
      this.list.horizontalScrollBar.focusEnabled = false;
      addChild(this.list);
      addEventListener(Event.ADDED_TO_STAGE,this.addListeners);
      addEventListener(Event.REMOVED_FROM_STAGE,this.removeListeners);
      ScrollStyleUtils.setGreenStyle(this.list);
    }

    public function get selectedItem() : IGameObject {
      return this._selectedItem;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.ceil(param1);
      this.list.width = this._width;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set height(param1:Number) : void {
      this._height = Math.ceil(param1);
      this.list.height = this._height;
    }

    override public function get height() : Number {
      return this._height;
    }

    private function updateScrollOnEnterFrame(param1:Event) : void {
      var local4:Sprite = null;
      var local5:Sprite = null;
      var local2:ScrollBar = this.list.horizontalScrollBar;
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
          this.list.addChild(local5);
        }
        local5.graphics.beginFill(0,0);
        if(local4 is LabelButton) {
          local5.graphics.drawRect(local4.y - 14,local2.y - ADDITIONAL_SCROLL_AREA_HEIGHT,local4.height + 28,local4.width + ADDITIONAL_SCROLL_AREA_HEIGHT);
        } else {
          local5.graphics.drawRect(local4.y,local2.y - ADDITIONAL_SCROLL_AREA_HEIGHT,local4.height,local4.width + ADDITIONAL_SCROLL_AREA_HEIGHT);
        }
        local5.graphics.endFill();
        local3++;
      }
    }

    private function onMouseDown(param1:MouseEvent) : void {
      this.scrollSpeed = 0;
      var local2:Rectangle = this.list.horizontalScrollBar.getBounds(stage);
      local2.top -= ADDITIONAL_SCROLL_AREA_HEIGHT;
      if(!local2.contains(param1.stageX,param1.stageY)) {
        this.sumDragWay = 0;
        this.previousPositionX = this.currrentPositionX = param1.stageX;
        this.currentTime = this.previousTime = getTimer();
        this.lastItemIndex = this.list.selectedIndex;
        stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
    }

    private function onMouseMove(param1:MouseEvent) : void {
      this.previousPositionX = this.currrentPositionX;
      this.currrentPositionX = param1.stageX;
      this.previousTime = this.currentTime;
      this.currentTime = getTimer();
      var local2:Number = this.currrentPositionX - this.previousPositionX;
      this.sumDragWay += Math.abs(local2);
      if(this.sumDragWay > MAX_DELTA_FOR_SELECT) {
        this.list.horizontalScrollPosition -= local2;
      }
      param1.updateAfterEvent();
    }

    private function onMouseUp(param1:MouseEvent) : void {
      stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      var local2:Number = (getTimer() - this.previousTime) / 1000;
      if(local2 == 0) {
        local2 = 0.1;
      }
      var local3:Number = param1.stageX - this.previousPositionX;
      this.scrollSpeed = local3 / local2;
      this.previousTime = this.currentTime;
      this.currentTime = getTimer();
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event) : void {
      this.previousTime = this.currentTime;
      this.currentTime = getTimer();
      var local2:Number = (this.currentTime - this.previousTime) / 1000;
      this.list.horizontalScrollPosition -= this.scrollSpeed * local2;
      var local3:Number = Number(this.list.horizontalScrollPosition);
      var local4:Number = Number(this.list.maxHorizontalScrollPosition);
      if(Math.abs(this.scrollSpeed) > MIN_POSIBLE_SPEED && 0 < local3 && local3 < local4) {
        this.scrollSpeed *= Math.exp(-1.5 * local2);
      } else {
        this.scrollSpeed = 0;
        removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
    }

    private function selectItemWithDoubleClick(param1:ListEvent) : void {
      var local2:GarageListRendererData = null;
      if(this.sumDragWay < MAX_DELTA_FOR_SELECT) {
        local2 = GarageListRendererData(param1.item);
        this.scrollSpeed = 0;
        if(this._selectedItem != local2.id) {
          this._selectedItem = local2.id;
          this.list.selectedItem = local2;
          this.list.scrollToSelected();
        }
        dispatchEvent(new PartsListEvent(PartsListEvent.ITEM_DOUBLE_CLICK));
      } else {
        this.list.addEventListener(Event.CHANGE,this.onChangeItem);
      }
    }

    private function selectItem(param1:ListEvent) : void {
      var local2:GarageListRendererData = null;
      if(this.sumDragWay < MAX_DELTA_FOR_SELECT) {
        local2 = GarageListRendererData(param1.item);
        this.scrollSpeed = 0;
        if(this._selectedItem != local2.id) {
          this._selectedItem = local2.id;
          this.list.selectedItem = local2;
          this.list.scrollToSelected();
          dispatchEvent(new PartsListEvent(PartsListEvent.SELECT_PARTS_LIST_ITEM));
        }
        dispatchEvent(new PartsListEvent(PartsListEvent.ITEM_CLICK));
      } else {
        this.list.addEventListener(Event.CHANGE,this.onChangeItem);
      }
    }

    private function onChangeItem(param1:Event) : void {
      this.list.selectedIndex = this.lastItemIndex;
      this.list.removeEventListener(Event.CHANGE,this.onChangeItem);
    }

    private function update(param1:IGameObject, param2:String, param3:* = null, param4:Boolean = true) : void {
      var local5:int = this.indexById(param1);
      if(local5 != -1) {
        this.updateByIndex(local5,param2,param3,param4);
      }
    }

    private function updateByIndex(param1:int, param2:String, param3:*, param4:Boolean) : void {
      var local5:GarageListRendererData = GarageListRendererData(this.dp.getItemAt(param1));
      local5[param2] = param3;
      if(param4) {
        local5.iconNormal = this.createIcon(local5,false);
        local5.iconSelected = this.createIcon(local5,true);
        this.dp.replaceItemAt(local5,param1);
        this.dp.invalidateItemAt(param1);
      }
    }

    public function mount(param1:IGameObject) : void {
      this.update(param1,"installed",true);
    }

    public function unmount(param1:IGameObject) : void {
      this.update(param1,"installed",false);
    }

    public function updateCount(param1:IGameObject, param2:int) : void {
      this.update(param1,"count",param2);
    }

    public function updateDiscountWithTimer(param1:IGameObject, param2:int, param3:CountDownTimer) : void {
      this.update(param1,"discount",param2,false);
      this.update(param1,"timerDiscount",param3);
    }

    public function updateDiscountAndCost(param1:IGameObject, param2:int, param3:CountDownTimer, param4:int) : void {
      this.update(param1,"discount",param2,false);
      this.update(param1,"timerDiscount",param3,false);
      this.updateCost(param1,param4);
    }

    public function updatePreview(param1:ImageResource) : void {
      var local2:GarageListRendererData = null;
      var local3:int = 0;
      while(local3 < this.dp.length) {
        local2 = GarageListRendererData(this.dp.getItemAt(local3));
        if(local2.preview.id == param1.id) {
          this.update(local2.id,"preview",param1);
        }
        local3++;
      }
    }

    public function deleteItem(param1:IGameObject) : void {
      var local2:int = this.indexById(param1);
      var local3:Object = this.dp.getItemAt(local2);
      if(this.list.selectedIndex == local2) {
        this._selectedItem = null;
        this.list.selectedItem = null;
      }
      this.dp.removeItem(local3);
    }

    public function select(param1:IGameObject) : void {
      var local2:int = 0;
      this.scrollSpeed = 0;
      if(this._selectedItem != param1) {
        local2 = this.indexById(param1);
        this.list.selectedIndex = local2;
        this._selectedItem = param1;
        dispatchEvent(new PartsListEvent(PartsListEvent.SELECT_PARTS_LIST_ITEM));
      }
    }

    public function scrollTo(param1:IGameObject) : void {
      this.scrollSpeed = 0;
      var local2:int = this.indexById(param1);
      this.list.scrollToIndex(local2);
    }

    public function unselect() : void {
      this._selectedItem = null;
      this.list.selectedItem = null;
    }

    private function createIcon(param1:GarageListRendererData, param2:Boolean) : DisplayObject {
      var local5:BitmapData = null;
      var local9:GarageItemBackground = null;
      var local14:Bitmap = null;
      var local15:IconGarageMod = null;
      var local16:Bitmap = null;
      var local17:CountDownTimer = null;
      var local18:CountDownTimerLabel = null;
      var local3:Sprite = new DiscreteSprite();
      var local4:Sprite = new DiscreteSprite();
      var local6:LabelBase = new LabelBase();
      var local7:LabelBase = new LabelBase();
      var local8:LabelBase = new LabelBase();
      var local10:Diamond = new Diamond();
      var local11:InputCheckIcon = new InputCheckIcon();
      if((param1.preview as ImageResource).data == null) {
        local4.addChild(local11);
        local11.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_PROGRESS);
        local11.x = 200 - local11.width >> 1;
        local11.y = 130 - local11.height >> 1;
        param1.preview.addLazyListener(this);
      } else {
        local14 = new Bitmap(param1.preview.data);
        local14.x = 200 - param1.preview.data.width >> 1;
        local14.y = 18;
        local4.addChild(local14);
        GarageResistancesIconsUtils.addIconsToParent(local14,param1.id);
      }
      var local12:Boolean = param1.rank > 0 || param1.showLockPremium;
      if(local12) {
        if(param1.type != ItemCategoryEnum.PLUGIN) {
          this.addLockItem(param1,local4);
        }
        param1.installed = false;
      } else if(param1.garageElement && param1.mod != -1) {
        local15 = new IconGarageMod(param1.mod);
        local4.addChild(local15);
        local15.x = 159;
        local15.y = 8;
      }
      if(param1.type == ItemCategoryEnum.INVENTORY || param1.count > 1) {
        param1.installed = false;
        local4.addChild(local8);
        local8.x = 15;
        local8.y = 100;
        local8.autoSize = TextFieldAutoSize.NONE;
        local8.size = 16;
        local8.align = TextFormatAlign.LEFT;
        local8.width = 100;
        local8.height = 25;
        local8.text = param1.count == 0 ? " " : "×" + String(param1.count);
      }
      if(local12) {
        if(param2) {
          local9 = new GarageItemBackground(GarageItemBackground.OFF_NORMAL_SELECTED);
        } else {
          local9 = new GarageItemBackground(GarageItemBackground.OFF_NORMAL);
        }
        local8.color = local7.color = local6.color = 12632256;
      } else if(param1.garageElement || param1.type == ItemCategoryEnum.INVENTORY) {
        local8.color = local7.color = local6.color = 11194762;
        if(param2) {
          local9 = new GarageItemBackground(GarageItemBackground.GUN_INSTALLED_SELECTED);
        } else {
          local9 = new GarageItemBackground(GarageItemBackground.GUN_INSTALLED);
        }
      } else {
        local8.color = local7.color = local6.color = 5898034;
        if(param2) {
          local9 = new GarageItemBackground(GarageItemBackground.GUN_NORMAL_SELECTED);
        } else {
          local9 = new GarageItemBackground(GarageItemBackground.GUN_NORMAL);
        }
      }
      if(param1.installed) {
        local16 = new Bitmap(mountedIcon);
        local16.x = 2;
        local16.y = 2;
        local4.addChild(local16);
      }
      local6.text = param1.name;
      if(!param1.garageElement && param1.crystalPrice > 0) {
        local7.text = Money.numToString(param1.crystalPrice,false);
        local7.x = 181 - local7.textWidth;
        local7.y = 3;
        local4.addChild(local10);
        local4.addChild(local7);
        local10.x = 186;
        local10.y = 6;
      }
      local6.y = 3;
      local6.x = 3;
      local4.addChildAt(local9,0);
      local4.addChild(local6);
      var local13:LabelBase = new LabelBase();
      if(param1.discount > 0 && (param1.rank <= 0 || param1.garageElement)) {
        SALE_RED_LABEL.y = local9.height - SALE_RED_LABEL.height - 8;
        SALE_RED_LABEL.x = local9.width - SALE_RED_LABEL.width - 2;
        local4.addChild(SALE_RED_LABEL);
        local13.color = 16777215;
        local13.align = TextFormatAlign.CENTER;
        local13.text = "-" + String(param1.discount) + "%";
        local13.size = 13;
        local13.x = int(SALE_RED_LABEL.x + SALE_RED_LABEL.width / 2 - local13.textWidth / 2);
        local13.y = SALE_RED_LABEL.y + 6;
        local4.addChild(local13);
        if(param1.timerDiscount != null) {
          local17 = param1.timerDiscount;
          if(local17.getEndTime() > getTimer()) {
            local18 = new CountDownTimerLabel();
            local18.color = 15258050;
            local18.start(param1.timerDiscount);
            local18.y = SALE_RED_LABEL.y + 18;
            local18.autoSize = TextFieldAutoSize.NONE;
            local18.align = TextFormatAlign.CENTER;
            local18.width = SALE_RED_LABEL.width - 8;
            local18.x = int(SALE_RED_LABEL.x + SALE_RED_LABEL.width / 2 - local18.width / 2);
            local3.addChild(local18);
          } else {
            param1.timerDiscount = null;
            local13.y += 5;
          }
        } else {
          local13.y += 5;
        }
      }
      local5 = new BitmapData(local4.width,local4.height,true,0);
      local5.draw(local4);
      local3.addChildAt(new Bitmap(local5),0);
      return local3;
    }

    private function addLockItem(param1:GarageListRendererData, param2:Sprite) : void {
      if(param1.rank > 0) {
        param2.addChild(this.createRankIcon(param1));
      } else {
        param2.addChild(this.createPremiumIcon());
      }
    }

    private function createRankIcon(param1:GarageListRendererData) : RankIcon {
      var local2:RankIcon = new BigRankIcon();
      if(param1.showLockPremium) {
        local2.setPremium(param1.rank);
        local2.x = PREMIUM_ITEM_LOCK_X;
        local2.y = PREMIUM_ITEM_LOCK_Y;
      } else {
        local2.setDefaultAccount(param1.rank);
        local2.x = 135;
        local2.y = 65;
      }
      return local2;
    }

    private function createPremiumIcon() : Bitmap {
      var local1:Bitmap = PremiumItemLock.createInstance();
      local1.x = PREMIUM_ITEM_LOCK_X;
      local1.y = PREMIUM_ITEM_LOCK_Y;
      return local1;
    }

    public function indexById(param1:IGameObject) : int {
      var local2:GarageListRendererData = null;
      var local3:int = 0;
      while(local3 < this.dp.length) {
        local2 = GarageListRendererData(this.dp.getItemAt(local3));
        if(local2.id == param1) {
          return local3;
        }
        local3++;
      }
      return -1;
    }

    public function updateCost(param1:IGameObject, param2:int) : void {
      this.update(param1,"crystalPrice",param2);
    }

    public function updateShowLockPremium(param1:IGameObject, param2:Boolean) : void {
      this.update(param1,"showLockPremium",param2);
    }

    public function getItemAt(param1:int) : IGameObject {
      return GarageListRendererData(this.dp.getItemAt(param1)).id;
    }

    public function itemsCount() : int {
      return this.dp.length;
    }

    private function scrollList(param1:MouseEvent) : void {
      this.scrollSpeed = 0;
      this.list.horizontalScrollPosition -= param1.delta * (Boolean(Capabilities.os.search("Linux") != -1) ? 50 : 10);
    }

    public function onResourceLoadingComplete(param1:Resource) : void {
      this.updatePreview(param1 as ImageResource);
    }

    private function addListeners(param1:Event) : void {
      this.list.horizontalScrollBar.addEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
      this.list.addEventListener(ListEvent.ITEM_CLICK,this.selectItem);
      this.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.selectItemWithDoubleClick);
      addEventListener(MouseEvent.MOUSE_WHEEL,this.scrollList);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
    }

    private function removeListeners(param1:Event) : void {
      this.list.horizontalScrollBar.removeEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
      this.list.removeEventListener(ListEvent.ITEM_CLICK,this.selectItem);
      this.list.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.selectItemWithDoubleClick);
      removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      removeEventListener(MouseEvent.MOUSE_WHEEL,this.scrollList);
      removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
    }

    public function onResourceLoadingError(param1:Resource, param2:String) : void {
    }

    public function onResourceLoadingFatalError(param1:Resource, param2:String) : void {
    }

    public function onResourceLoadingProgress(param1:Resource, param2:int) : void {
    }

    public function onResourceLoadingStart(param1:Resource) : void {
    }

    public function destroy() : void {
      removeDisplayObject(this.list);
      this.removePreviewLazyListeners();
      this.dp.removeAll();
      this.list.removeAll();
      this.list = null;
      this.dp = null;
    }

    private function removePreviewLazyListeners() : void {
      var local1:GarageListRendererData = null;
      var local2:int = 0;
      while(local2 < this.dp.length) {
        local1 = GarageListRendererData(this.dp.getItemAt(local2));
        local1.preview.removeLazyListener(this);
        local2++;
      }
    }

    public function clearList() : void {
      this.removePreviewLazyListeners();
      this.dp.removeAll();
    }

    public function addItem(param1:GarageListRendererData) : void {
      param1.iconNormal = this.createIcon(param1,false);
      param1.iconSelected = this.createIcon(param1,true);
      this.dp.addItem(param1);
    }

    public function sort() : void {
      this.dp.sortOn(["appearanceTime","garageElement","rank","showLockPremium","sort"],[Array.DESCENDING,Array.DESCENDING,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC]);
    }
  }
}
