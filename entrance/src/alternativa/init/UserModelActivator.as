package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.servermodels.GoogleEntranceModel;
  import alternativa.tanks.servermodels.IGoogleEntranceModel;
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.service.IExternalEntranceService;
  import alternativa.tanks.service.IPasswordParamsService;
  import alternativa.tanks.service.IRegistrationUXService;
  import alternativa.tanks.service.impl.ExternalEntranceService;
  import alternativa.tanks.service.impl.PasswordParamsService;
  import alternativa.tanks.service.impl.RegistrationUXService;

  public class UserModelActivator implements IBundleActivator {
    private static var _osgi:OSGi;

    public function UserModelActivator() {
      super();
    }

    public static function registerClientFacade(param1:IEntranceClientFacade) : void {
      if(_osgi.getService(IEntranceClientFacade) != null) {
        _osgi.unregisterService(IEntranceClientFacade);
      }
      _osgi.registerService(IEntranceClientFacade,param1);
    }

    public static function registerServerFacade(param1:IEntranceServerFacade) : void {
      if(_osgi.getService(IEntranceServerFacade) != null) {
        _osgi.unregisterService(IEntranceServerFacade);
      }
      _osgi.registerService(IEntranceServerFacade,param1);
    }

    public static function unregisterClientFacade() : void {
      _osgi.unregisterService(IEntranceClientFacade);
    }

    public static function unregisterServerFacade() : void {
      _osgi.unregisterService(IEntranceServerFacade);
    }

    public function start(param1:OSGi) : void {
      _osgi = param1;
      param1.registerService(IPasswordParamsService,new PasswordParamsService());
      param1.registerService(IExternalEntranceService,new ExternalEntranceService());
      param1.registerService(IRegistrationUXService,new RegistrationUXService());
      param1.registerService(IGoogleEntranceModel,new GoogleEntranceModel());
      new EntranceContext((param1.getService(IDisplay) as IDisplay).contentUILayer);
    }

    public function stop(param1:OSGi) : void {
      param1.unregisterService(IPasswordParamsService);
      param1.unregisterService(IExternalEntranceService);
      param1.unregisterService(IRegistrationUXService);
    }
  }
}
