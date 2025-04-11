package platform.clients.fp10.commonsflash {
  import alternativa.model.description.DescriptionModel;
  import alternativa.model.description.IDescription;
  import alternativa.model.description.IDescriptionAdapt;
  import alternativa.model.description.IDescriptionEvents;
  import alternativa.model.timeperiod.TimePeriod;
  import alternativa.model.timeperiod.TimePeriodAdapt;
  import alternativa.model.timeperiod.TimePeriodEvents;
  import alternativa.model.timeperiod.TimePeriodModel;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      osgi = param1;
      var local2:ModelRegistry = osgi.getService(ModelRegistry) as ModelRegistry;
      local2.add(new DescriptionModel());
      var local3:ModelRegistry = osgi.getService(ModelRegistry) as ModelRegistry;
      local3.registerAdapt(IDescription,IDescriptionAdapt);
      local3.registerEvents(IDescription,IDescriptionEvents);
      local3.registerAdapt(TimePeriod,TimePeriodAdapt);
      local3.registerEvents(TimePeriod,TimePeriodEvents);
      local2.add(new TimePeriodModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
