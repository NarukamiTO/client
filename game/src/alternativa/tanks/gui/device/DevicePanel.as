package alternativa.tanks.gui.device {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.buttons.TimerButton;
  import alternativa.tanks.gui.buttons.TimerButtonEvent;
  import alternativa.tanks.gui.crystalbutton.CrystalButton;
  import alternativa.tanks.gui.device.list.DeviceBorder;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceOwningType;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.temporaryitem.ITemporaryItemService;
  import base.DiscreteSprite;
  import controls.labels.MouseDisabledLabel;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerWithIcon;
  import flash.display.Bitmap;
  import flash.utils.getTimer;
  import forms.ColorConstants;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class DevicePanel extends DiscreteSprite implements IImageResource {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var temporaryItemService:ITemporaryItemService;

    [Inject]
    public static var deviceService:DeviceService;

    private static const ICON_SIZE:int = 64;
    private static const DESCRIPTION_WIDTH:int = 200;

    private var icon:Bitmap = new Bitmap();

    public var buyButton:CrystalButton = new CrystalButton();
    public var mountButton:TimerButton = new TimerButton();
    public var rentTimerWithIcon:CountDownTimerWithIcon = new CountDownTimerWithIcon(false);

    private var border:DeviceBorder;
    private var iconResource:ImageResource;
    private var iconLoadListener:ImageResourceLoadingWrapper;
    private var timer:CountDownTimer;

    public var device:IGameObject;
    public var targetItem:IGameObject;

    public function DevicePanel(param1:IGameObject, param2:IGameObject) {
      super();
      this.targetItem = param1;
      this.device = param2;
      this.icon.x = 30;
      this.icon.y = 20;
      if(param2 == null) {
        this.icon.bitmapData = DevicesIcons.iconDefaultDeviceBitmap;
      } else {
        this.iconResource = itemService.getPreviewResource(param2);
        if(Boolean(this.iconResource.isLazy) && !this.iconResource.isLoaded) {
          this.iconLoadListener = new ImageResourceLoadingWrapper(this);
          if(!this.iconResource.isLoading) {
            this.iconResource.loadLazyResource(this.iconLoadListener);
          } else {
            this.iconResource.addLazyListener(this.iconLoadListener);
          }
        } else {
          this.icon.bitmapData = this.iconResource.data;
        }
      }
      addChild(this.icon);
      var local3:MouseDisabledLabel = new MouseDisabledLabel();
      local3.size = 18;
      local3.color = ColorConstants.GREEN_TEXT;
      local3.width = DESCRIPTION_WIDTH;
      local3.wordWrap = true;
      local3.x = this.icon.x + ICON_SIZE + 10;
      local3.y = 20;
      local3.text = param2 != null ? itemService.getName(param2) : localeService.getText(TanksLocale.TEXT_DEVICES_STANDARD_SETTINGS);
      addChild(local3);
      var local4:MouseDisabledLabel = new MouseDisabledLabel();
      local4.color = ColorConstants.GREEN_TEXT;
      local4.multiline = true;
      local4.wordWrap = true;
      local4.width = DESCRIPTION_WIDTH;
      local4.x = local3.x;
      local4.y = local3.y + local3.height + 8;
      local4.text = param2 != null ? itemService.getDescription(param2) : localeService.getText(TanksLocale.TEXT_DEVICES_STANDARD_SETTINGS_DESCRIPTION);
      addChild(local4);
      this.border = new DeviceBorder(local4.y + local4.height + 20,this.getDeviceOwnType() == DeviceOwningType.BOUGHT);
      this.border.x = 10;
      addChild(this.border);
      this.mountButton.x = this.border.x + this.border.width - this.mountButton.width - 20;
      this.mountButton.y = this.border.height - this.mountButton.height * 2 - 10 >> 1;
      addChild(this.mountButton);
      this.buyButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_BUY_TEXT));
      this.buyButton.setCost(param2 != null ? int(itemService.getPrice(param2)) : 0);
      this.buyButton.setSale(param2 != null && itemService.getDiscount(param2) != 0);
      this.buyButton.x = this.mountButton.x;
      this.buyButton.y = this.border.height - this.buyButton.height >> 1;
      addChild(this.buyButton);
      this.rentTimerWithIcon.x = this.icon.x;
      this.rentTimerWithIcon.y = this.buyButton.y + this.buyButton.height - this.rentTimerWithIcon.height;
      addChild(this.rentTimerWithIcon);
    }

    public function updatePanel(param1:Boolean) : void {
      this.stopCountDownTimer();
      var local2:DeviceOwningType = this.getDeviceOwnType();
      this.buyButton.visible = local2 != DeviceOwningType.BOUGHT;
      this.mountButton.visible = local2 != DeviceOwningType.NOT_OWNED;
      if(local2 != DeviceOwningType.NOT_OWNED) {
        this.mountButton.enabled = !param1;
        this.mountButton.label = localeService.getText(param1 ? TanksLocale.TEXT_GARAGE_EQUIPPED_TEXT : TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
        if(this.mountButton.enabled) {
          this.updateMountButtonTimer();
        }
      }
      if(local2 == DeviceOwningType.RENT) {
        this.startCountDownTimer();
      }
      if(local2 == DeviceOwningType.BOUGHT) {
        this.mountButton.y = this.border.height - this.mountButton.height >> 1;
      }
    }

    private function updateMountButtonTimer() : void {
      var local1:CountDownTimer = delayMountCategoryService.getDownTimer(this.targetItem);
      if(Boolean(lobbyLayoutService.inBattle()) && local1.getRemainingSeconds() > 0 && Boolean(itemService.isMounted(this.targetItem))) {
        this.mountButton.startTimer(local1);
        this.mountButton.addEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      }
    }

    private function stopCountDownTimer() : void {
      this.rentTimerWithIcon.visible = false;
      if(this.timer != null) {
        this.rentTimerWithIcon.stop();
        this.timer.stop();
        this.timer = null;
      }
    }

    private function startCountDownTimer() : void {
      this.stopCountDownTimer();
      this.timer = new CountDownTimer();
      this.timer.start(getTimer() + temporaryItemService.getCurrentTimeRemainingMSec(this.device));
      this.rentTimerWithIcon.start(this.timer);
      this.rentTimerWithIcon.visible = true;
    }

    public function destroy() : void {
      if(this.iconLoadListener != null) {
        this.iconResource.removeLazyListener(this.iconLoadListener);
      }
      this.stopCountDownTimer();
      this.mountButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
    }

    public function setPreviewResource(param1:ImageResource) : void {
      this.icon.bitmapData = param1.data;
    }

    private function getDeviceOwnType() : DeviceOwningType {
      return deviceService.getDeviceOwnType(this.device);
    }

    private function onCompletedTimer(param1:TimerButtonEvent) : void {
      TimerButton(param1.target).enabled = true;
    }
  }
}
