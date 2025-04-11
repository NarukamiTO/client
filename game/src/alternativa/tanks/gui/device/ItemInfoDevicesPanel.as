package alternativa.tanks.gui.device {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryViewGrid;
  import alternativa.tanks.gui.skins.ItemSkinsWindow;
  import alternativa.tanks.gui.skins.ShotSkinsWindow;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.item.availabledevices.AvailableDevices;
  import alternativa.tanks.model.item.device.ItemDevicesGarage;
  import alternativa.tanks.model.item.skins.AvailableShotSkins;
  import alternativa.tanks.model.item.skins.AvailableSkins;
  import alternativa.tanks.model.item.skins.MountShotSkin;
  import alternativa.tanks.model.item.skins.MountSkin;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.device.UpdateDevicesEvent;
  import alternativa.tanks.service.item.ItemService;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class ItemInfoDevicesPanel extends Sprite implements IImageResource {
    [Inject]
    public static var deviceService:DeviceService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const NUMBER_OF_DEVICES:int = 3;
    private static const SLOT_SKIN:int = 0;
    private static const SLOT_DEVICE:int = 1;
    private static const SLOT_SHOT_COLOR:int = 2;

    private var deviceButtons:Vector.<DeviceButton>;
    private var imageResources:Vector.<ImageResource>;
    private var loadListeners:Vector.<ImageResourceLoadingWrapper>;
    private var targetItem:IGameObject;
    private var panel:ItemsCategoryViewGrid;
    private var skinsWindow:DialogWindow = null;

    public function ItemInfoDevicesPanel() {
      var local3:DeviceButton = null;
      this.deviceButtons = new Vector.<DeviceButton>(NUMBER_OF_DEVICES,true);
      this.imageResources = new Vector.<ImageResource>(NUMBER_OF_DEVICES,true);
      this.loadListeners = new Vector.<ImageResourceLoadingWrapper>(NUMBER_OF_DEVICES,true);
      this.panel = new ItemsCategoryViewGrid();
      super();
      var local1:LabelBase = new LabelBase();
      local1.text = localeService.getText(TanksLocale.TEXT_DEVICES);
      local1.size = 18;
      local1.color = ColorConstants.GREEN_TEXT;
      local1.x = -3;
      addChild(local1);
      this.panel.y = local1.y + local1.height + 4;
      this.panel.columnCount = NUMBER_OF_DEVICES;
      this.panel.horizontalSpacing = 8;
      var local2:int = 0;
      while(local2 < this.deviceButtons.length) {
        local3 = new DeviceButton(local2);
        this.deviceButtons[local2] = local3;
        this.panel.addItem(local3);
        local2++;
      }
      addChild(this.panel);
      this.panel.render();
      deviceService.addEventListener(UpdateDevicesEvent.EVENT,this.onDeviceChanged);
    }

    public function init(param1:IGameObject) : void {
      this.targetItem = param1;
      this.updateButtons();
    }

    private function updateButtons() : void {
      this.removeListeners();
      var local1:int = 0;
      while(local1 < this.deviceButtons.length) {
        this.updateGradeButton(local1);
        local1++;
      }
    }

    private function updateGradeButton(param1:int) : void {
      this.removeLazyListener(param1);
      var local2:DeviceButton = this.deviceButtons[param1];
      local2.visible = false;
      local2.setUnclickable();
      switch(param1) {
        case SLOT_SKIN:
          local2.visible = true;
          if(AvailableSkins(this.targetItem.adapt(AvailableSkins)).getSkins().length > 0) {
            local2.setClickable();
            local2.addEventListener(MouseEvent.CLICK,this.onDeviceButtonClick);
            this.setDeviceButtonImage(SLOT_SKIN);
          }
          break;
        case SLOT_SHOT_COLOR:
          if(this.targetItem.hasModel(AvailableShotSkins)) {
            local2.visible = true;
            if(AvailableShotSkins(this.targetItem.adapt(AvailableShotSkins)).getSkins().length > 0) {
              local2.setClickable();
              local2.addEventListener(MouseEvent.CLICK,this.onDeviceButtonClick);
              this.setDeviceButtonImage(SLOT_SHOT_COLOR);
            }
          }
          break;
        default:
          if(this.targetItem.hasModel(ItemDevicesGarage)) {
            local2.visible = true;
            if(deviceService.isDevicesAvailable(this.targetItem)) {
              if(!lobbyLayoutService.inBattle() || Boolean(battleInfoService.reArmorEnabled) || !itemService.isMounted(this.targetItem)) {
                local2.addEventListener(MouseEvent.CLICK,this.onDeviceButtonClick);
                local2.setClickable();
              }
              this.setDeviceButtonImage(SLOT_DEVICE);
              if(deviceService.isSale(this.targetItem)) {
                local2.setSale(true);
              }
            }
          }
      }
    }

    private function setDeviceButtonImage(param1:int) : void {
      var local2:ImageResource = null;
      var local3:IGameObject = null;
      if(param1 == SLOT_SKIN) {
        local3 = MountSkin(this.targetItem.adapt(MountSkin)).getMountedSkin();
        local2 = this.targetItem == local3 ? null : itemService.getPreviewResource(local3);
      } else if(param1 == SLOT_SHOT_COLOR) {
        local3 = MountShotSkin(this.targetItem.adapt(MountShotSkin)).getMountedSkin();
        local2 = this.targetItem == local3 ? null : itemService.getPreviewResource(local3);
      } else {
        local2 = deviceService.getInsertedDevicePreview(this.targetItem);
      }
      if(local2 == null) {
        this.deviceButtons[param1].setDevicesAvailableIcon();
        return;
      }
      if(Boolean(local2.isLazy) && !local2.isLoaded) {
        this.imageResources[param1] = local2;
        this.loadListeners[param1] = new ImageResourceLoadingWrapper(this);
        if(!local2.isLoading) {
          local2.loadLazyResource(this.loadListeners[param1]);
        } else {
          local2.addLazyListener(this.loadListeners[param1]);
        }
      } else {
        this.deviceButtons[param1].setDeviceImage(local2.data);
      }
    }

    private function onDeviceButtonClick(param1:MouseEvent) : void {
      var event:MouseEvent = param1;
      var grade:int = int(this.deviceButtons.indexOf(event.target));
      if(grade == SLOT_SKIN) {
        this.skinsWindow = new ItemSkinsWindow(this.targetItem,function():void {
          skinsWindow.removeEventListener(Event.CHANGE,onDeviceChanged);
          skinsWindow = null;
        });
        this.skinsWindow.addEventListener(Event.CHANGE,this.onDeviceChanged);
        return;
      }
      if(grade == SLOT_SHOT_COLOR) {
        this.skinsWindow = new ShotSkinsWindow(this.targetItem,function():void {
          skinsWindow.removeEventListener(Event.CHANGE,onDeviceChanged);
          skinsWindow = null;
        });
        this.skinsWindow.addEventListener(Event.CHANGE,this.onDeviceChanged);
        return;
      }
      if(deviceService.getAvailableDevices(this.targetItem) != null) {
        new DevicesWindow(this.targetItem);
      } else {
        blurService.blurGameContent();
        modalLoaderService.show();
        deviceService.addEventListener(DevicesLoadedEvent.DEVICES_LOADED,this.devicesLoaded);
        AvailableDevices(this.targetItem.adapt(AvailableDevices)).loadDevices();
      }
    }

    private function devicesLoaded(param1:DevicesLoadedEvent) : void {
      deviceService.removeEventListener(DevicesLoadedEvent.DEVICES_LOADED,this.devicesLoaded);
      modalLoaderService.hideForcibly();
      blurService.unblurGameContent();
      new DevicesWindow(this.targetItem);
    }

    public function destroy() : void {
      this.removeListeners();
      deviceService.removeEventListener(UpdateDevicesEvent.EVENT,this.onDeviceChanged);
      this.deviceButtons = null;
      this.imageResources = null;
      this.loadListeners = null;
      this.targetItem = null;
      if(this.skinsWindow is ItemSkinsWindow) {
        (this.skinsWindow as ItemSkinsWindow).close();
      }
      if(this.skinsWindow is ShotSkinsWindow) {
        (this.skinsWindow as ShotSkinsWindow).close();
      }
    }

    private function removeListeners() : void {
      var local1:DeviceButton = null;
      for each(local1 in this.deviceButtons) {
        local1.removeEventListener(MouseEvent.CLICK,this.onDeviceButtonClick);
      }
      this.removeLazyListeners();
    }

    private function removeLazyListeners() : void {
      var local1:int = 0;
      while(local1 < this.deviceButtons.length) {
        this.removeLazyListener(local1);
        local1++;
      }
    }

    private function removeLazyListener(param1:int) : void {
      if(this.imageResources[param1] != null && this.loadListeners[param1] != null) {
        this.imageResources[param1].removeLazyListener(this.loadListeners[param1]);
      }
    }

    private function onDeviceChanged(param1:Event) : void {
      this.updateButtons();
    }

    public function setPreviewResource(param1:ImageResource) : void {
      var local2:int = int(this.imageResources.indexOf(param1));
      this.deviceButtons[local2].setDeviceImage(param1.data);
    }
  }
}
