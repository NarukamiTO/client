package alternativa.tanks.model.item.device {
  import alternativa.tanks.model.item.temporary.ITemporaryItem;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.item.ItemService;
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.device.IItemDevicesGarageModelBase;
  import projects.tanks.client.garage.models.item.device.ItemDevicesCC;
  import projects.tanks.client.garage.models.item.device.ItemDevicesGarageModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class ItemDevicesGarageModel extends ItemDevicesGarageModelBase implements IItemDevicesGarageModelBase, ItemDevicesGarage {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var deviceService:DeviceService;

    public function ItemDevicesGarageModel() {
      super();
    }

    public function insertDevice(param1:IGameObject) : void {
      server.insertDeviceByLightObject(param1);
      deviceService.insertDevice(object,param1);
    }

    public function removeDevice() : void {
      server.removeDevice();
      getInitParam().preview = null;
      deviceService.removeDevice(object);
    }

    public function buyDevice(param1:IGameObject, param2:int) : void {
      server.buyDevice(param1,param2);
      ITemporaryItem(param1.adapt(ITemporaryItem)).markAsInfinityLifeTimeItem();
      if(this.haveAbilityMountDevice(object)) {
        this.insertDevice(param1);
      }
    }

    private function haveAbilityMountDevice(param1:IGameObject) : Boolean {
      if(!lobbyLayoutService.inBattle()) {
        return true;
      }
      if(!itemService.isMounted(param1)) {
        return true;
      }
      if(!battleInfoService.reArmorEnabled) {
        return false;
      }
      var local2:CountDownTimer = delayMountCategoryService.getDownTimer(param1);
      return local2.getRemainingSeconds() <= 0;
    }

    public function getParams() : ItemDevicesCC {
      return getInitParam();
    }
  }
}
