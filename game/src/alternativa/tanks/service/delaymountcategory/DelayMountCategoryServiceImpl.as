package alternativa.tanks.service.delaymountcategory {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.service.item.ItemService;
  import controls.timer.CountDownTimer;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;

  public class DelayMountCategoryServiceImpl implements IDelayMountCategoryService {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var logService:LogService;

    private var timers:Dictionary = new Dictionary();

    public function DelayMountCategoryServiceImpl() {
      super();
    }

    public function getDownTimer(param1:IGameObject) : CountDownTimer {
      var local2:ItemCategoryEnum = itemService.getCategory(param1);
      return this.timers[local2];
    }

    public function createTimers(param1:DelayMountCategoryCC) : void {
      this.createTimer(ItemCategoryEnum.ARMOR,param1.delayMountArmorInSec);
      this.createTimer(ItemCategoryEnum.WEAPON,param1.delayMountWeaponInSec);
      this.createTimer(ItemCategoryEnum.RESISTANCE_MODULE,param1.delayMountResistanceInSec);
      this.createTimer(ItemCategoryEnum.DRONE,param1.delayMountDroneInSec);
    }

    private function createTimer(param1:ItemCategoryEnum, param2:int) : void {
      var local3:CountDownTimer = new CountDownTimer();
      local3.start(param2 * 1000 + getTimer());
      this.timers[param1] = local3;
    }

    public function destroyTimers() : void {
      var local1:CountDownTimer = null;
      for each(local1 in this.timers) {
        if(local1 != null) {
          local1.destroy();
        }
      }
      delete this.timers[ItemCategoryEnum.ARMOR];
      delete this.timers[ItemCategoryEnum.RESISTANCE_MODULE];
      delete this.timers[ItemCategoryEnum.WEAPON];
      delete this.timers[ItemCategoryEnum.DRONE];
    }

    public function resetTimers() : void {
      var local1:CountDownTimer = null;
      for each(local1 in this.timers) {
        if(local1 != null) {
          local1.stop();
        }
      }
    }
  }
}
