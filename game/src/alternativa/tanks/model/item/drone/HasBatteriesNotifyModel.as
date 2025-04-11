package alternativa.tanks.model.item.drone {
  import alternativa.tanks.service.battery.BatteriesService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.garage.models.item.drone.HasBatteriesNotifyModelBase;
  import projects.tanks.client.garage.models.item.drone.IHasBatteriesNotifyModelBase;

  [ModelInfo]
  public class HasBatteriesNotifyModel extends HasBatteriesNotifyModelBase implements IHasBatteriesNotifyModelBase, ObjectLoadListener {
    [Inject]
    public static var batteryService:BatteriesService;

    public function HasBatteriesNotifyModel() {
      super();
    }

    public function objectLoaded() : void {
      batteryService.setHasBatteries(getInitParam().hasBatteries);
    }

    public function setHasBatteries(param1:Boolean) : void {
      batteryService.setHasBatteries(param1);
    }
  }
}
