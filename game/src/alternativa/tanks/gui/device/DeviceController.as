package alternativa.tanks.gui.device {
  import alternativa.tanks.gui.confirm.ConfirmAlertEvent;
  import alternativa.tanks.gui.confirm.DeviceConfirmAlert;
  import alternativa.tanks.model.item.device.ItemDevicesGarage;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.device.UpdateDevicesEvent;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.money.IMoneyService;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class DeviceController {
    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var deviceService:DeviceService;

    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    private var devicePanels:Vector.<DevicePanel>;
    private var targetItem:IGameObject;
    private var deviceForPurchase:IGameObject;

    public function DeviceController(param1:Vector.<DevicePanel>, param2:IGameObject) {
      var local3:DevicePanel = null;
      super();
      this.devicePanels = param1;
      this.targetItem = param2;
      for each(local3 in param1) {
        local3.buyButton.addEventListener(MouseEvent.CLICK,this.buyButtonClick);
        local3.mountButton.addEventListener(MouseEvent.CLICK,this.mountButtonClick);
      }
      deviceService.addEventListener(UpdateDevicesEvent.EVENT,this.onDevicesUpdate);
      this.updateDevicePanels();
    }

    private function onDevicesUpdate(param1:UpdateDevicesEvent) : void {
      this.updateDevicePanels();
    }

    private function mountButtonClick(param1:MouseEvent) : void {
      var local2:IGameObject = DevicePanel(param1.target.parent).device;
      var local3:ItemDevicesGarage = ItemDevicesGarage(this.targetItem.adapt(ItemDevicesGarage));
      if(local2 != null) {
        local3.insertDevice(local2);
      } else {
        local3.removeDevice();
      }
      this.updateDevicePanels();
    }

    private function buyButtonClick(param1:MouseEvent) : void {
      var local4:DeviceConfirmAlert = null;
      var local2:IGameObject = DevicePanel(param1.target.parent).device;
      var local3:int = int(itemService.getPrice(local2));
      if(moneyService.checkEnough(local3)) {
        this.deviceForPurchase = local2;
        local4 = new DeviceConfirmAlert(local2,local3);
        local4.addEventListener(ConfirmAlertEvent.BUY_ITEM,this.onPurchaseConfirmed);
        local4.addEventListener(Event.CANCEL,this.onPurchaseCanceled);
      }
    }

    private function onPurchaseConfirmed(param1:ConfirmAlertEvent) : void {
      var local2:ItemDevicesGarage = ItemDevicesGarage(this.targetItem.adapt(ItemDevicesGarage));
      var local3:int = int(itemService.getPrice(this.deviceForPurchase));
      moneyService.spend(local3);
      local2.buyDevice(this.deviceForPurchase,local3);
      this.removeDeviceConfirmAlertListeners(DeviceConfirmAlert(param1.target));
      this.updateDevicePanels();
    }

    private function onPurchaseCanceled(param1:Event) : void {
      this.removeDeviceConfirmAlertListeners(DeviceConfirmAlert(param1.target));
    }

    private function removeDeviceConfirmAlertListeners(param1:DeviceConfirmAlert) : void {
      param1.removeEventListener(ConfirmAlertEvent.BUY_ITEM,this.onPurchaseConfirmed);
      param1.removeEventListener(Event.CANCEL,this.onPurchaseCanceled);
    }

    public function updateDevicePanels() : void {
      var local2:DevicePanel = null;
      var local1:IGameObject = deviceService.getInsertedDevice(this.targetItem);
      for each(local2 in this.devicePanels) {
        local2.updatePanel(local2.device == local1);
      }
    }

    public function destroy() : void {
      var local1:DevicePanel = null;
      deviceService.removeEventListener(UpdateDevicesEvent.EVENT,this.onDevicesUpdate);
      for each(local1 in this.devicePanels) {
        local1.buyButton.removeEventListener(MouseEvent.CLICK,this.buyButtonClick);
        local1.mountButton.removeEventListener(MouseEvent.CLICK,this.mountButtonClick);
      }
    }
  }
}
