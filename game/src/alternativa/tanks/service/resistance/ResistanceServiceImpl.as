package alternativa.tanks.service.resistance {
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.model.item.resistance.MountedResistances;
  import alternativa.tanks.model.item.resistance.view.MountedResistancesPanel;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.item.ItemService;
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;

  public class ResistanceServiceImpl implements ResistanceService {
    [Inject]
    public static var garageService:GarageService;

    [Inject]
    public static var userGarageActionsService:UserGarageActionsService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var delayMountCategoryService:IDelayMountCategoryService;

    [Inject]
    public static var itemService:ItemService;

    private var view:MountedResistancesPanel = null;
    private var mountedResistancesObject:MountedResistances = null;

    public function ResistanceServiceImpl() {
      super();
    }

    public function getView() : MountedResistancesPanel {
      return this.view;
    }

    public function registerView(param1:MountedResistancesPanel) : void {
      this.view = param1;
    }

    public function registerModel(param1:IGameObject) : void {
      var local4:IGameObject = null;
      this.mountedResistancesObject = MountedResistances(param1.adapt(MountedResistances));
      var local2:* = this.mountedResistancesObject.getMounted();
      var local3:uint = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        if(local4 != null) {
          if(this.isAllResist(local4)) {
            this.getView().setAllResist(local4);
            return;
          }
          this.getView().setResistInCell(local3,local4);
        }
        local3++;
      }
    }

    public function unregisterModel() : void {
      this.mountedResistancesObject = null;
    }

    public function unregisterView() : void {
      this.view = null;
    }

    public function mountBought(param1:IGameObject) : void {
      var local2:IGameObject = null;
      var local3:int = 0;
      for each(local2 in itemService.getModifications(param1)) {
        local3 = this.getView().getIndex(local2);
        if(local3 != -1) {
          this.getView().unequipResist(local2);
          this.mount(local3,param1);
          break;
        }
        this.mountIntoFreeSlot(param1);
      }
    }

    public function mount(param1:int, param2:IGameObject) : void {
      if(this.canBeMount(param2)) {
        if(this.isAllResist(param2)) {
          this.unmountAll();
          this.getView().setAllResist(param2);
        } else {
          this.getView().unequipResist(param2);
          this.getView().setResistInCell(param1,param2);
        }
        this.mountedResistancesObject.mount(param1,param2);
        garageService.getView().mountItem(param2);
        garageService.getView().getItemInfoPanel().onMountItem();
      }
    }

    public function mountIntoFreeSlot(param1:IGameObject) : void {
      var local2:int = 0;
      if(!this.isMounted(param1)) {
        local2 = this.getView().getFreeSlot();
        if(local2 > -1) {
          this.mount(local2,param1);
        }
      }
    }

    public function unmount(param1:IGameObject) : void {
      this.getView().unequipResist(param1);
      this.mountedResistancesObject.unmount(param1);
      garageService.getView().unmountItem(param1);
      garageService.getView().getItemInfoPanel().onMountItem();
    }

    public function isMounted(param1:IGameObject) : Boolean {
      if(this.mountedResistancesObject != null) {
        return this.mountedResistancesObject.getMounted().indexOf(param1) >= 0;
      }
      return false;
    }

    private function unmountAll() : void {
      var local2:IGameObject = null;
      var local1:Vector.<IGameObject> = new Vector.<IGameObject>();
      for each(local2 in this.mountedResistancesObject.getMounted()) {
        if(local2 != null) {
          local1.push(local2);
        }
      }
      for each(local2 in local1) {
        this.unmount(local2);
      }
    }

    private function isAllResist(param1:IGameObject) : Boolean {
      var local3:ItemPropertyValue = null;
      if(param1 == null) {
        return false;
      }
      var local2:Vector.<ItemPropertyValue> = itemService.getProperties(param1);
      for each(local3 in local2) {
        if(local3.getProperty() == ItemGarageProperty.ALL_RESISTANCE) {
          return true;
        }
      }
      return false;
    }

    public function setOnlyUnmountMode() : void {
      this.getView().onlyUnmountMode();
    }

    public function canBeMount(param1:IGameObject) : Boolean {
      if(!battleInfoService.isInBattle()) {
        return true;
      }
      if(!battleInfoService.reArmorEnabled) {
        return false;
      }
      var local2:CountDownTimer = delayMountCategoryService.getDownTimer(param1);
      if(local2 != null && local2.getRemainingSeconds() > 0) {
        return false;
      }
      return true;
    }
  }
}
