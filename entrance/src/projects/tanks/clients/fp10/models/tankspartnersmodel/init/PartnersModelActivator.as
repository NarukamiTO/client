package projects.tanks.clients.fp10.models.tankspartnersmodel.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.services.SteamDataService;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.services.SteamDataServiceImpl;

  public class PartnersModelActivator implements IBundleActivator {
    public function PartnersModelActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      param1.registerService(SteamDataService,new SteamDataServiceImpl());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
