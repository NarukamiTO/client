package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.tanks.model.garage.Tank3DViewer;
  import alternativa.tanks.model.garage.temperature.TemperatureConfig;
  import alternativa.tanks.model.garage.temperature.TemperatureConfigImpl;
  import alternativa.tanks.service.battery.BatteriesService;
  import alternativa.tanks.service.battery.BatteriesServiceImpl;
  import alternativa.tanks.service.delaymountcategory.DelayMountCategoryServiceImpl;
  import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
  import alternativa.tanks.service.device.DeviceService;
  import alternativa.tanks.service.device.DeviceServiceImpl;
  import alternativa.tanks.service.garage.GarageService;
  import alternativa.tanks.service.garage.GarageServiceImpl;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item.ItemServiceImpl;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsServiceImpl;
  import alternativa.tanks.service.resistance.ResistanceService;
  import alternativa.tanks.service.resistance.ResistanceServiceImpl;
  import alternativa.tanks.service.temporaryitem.ITemporaryItemService;
  import alternativa.tanks.service.temporaryitem.TemporaryItemService;
  import alternativa.tanks.service.temporaryitemnotify.ITemporaryItemNotifyService;
  import alternativa.tanks.service.temporaryitemnotify.TemporaryItemNotifyService;

  public class GarageModelActivator implements IBundleActivator {
    public function GarageModelActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      param1.registerService(ItemService,new ItemServiceImpl());
      param1.registerService(ITemporaryItemService,new TemporaryItemService());
      param1.registerService(ITemporaryItemNotifyService,new TemporaryItemNotifyService());
      param1.registerService(ITank3DViewer,new Tank3DViewer());
      param1.registerService(ItemPropertyParamsService,new ItemPropertyParamsServiceImpl());
      param1.registerService(GarageService,new GarageServiceImpl());
      param1.registerService(IDelayMountCategoryService,new DelayMountCategoryServiceImpl());
      param1.registerService(TemperatureConfig,new TemperatureConfigImpl());
      param1.registerService(DeviceService,new DeviceServiceImpl());
      param1.registerService(ResistanceService,new ResistanceServiceImpl());
      param1.registerService(BatteriesService,new BatteriesServiceImpl());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
