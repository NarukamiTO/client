package platform.clients.fp10.libraries.alternativapartnersflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters.SocialNetworkParameters;
  import platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters.SocialNetworkParametersAdapt;
  import platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters.SocialNetworkParametersEvents;
  import platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters.SocialNetworkParametersModel;
  import platform.clients.fp10.libraries.alternativapartners.service.impl.PartnerService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListenerAdapt;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListenerEvents;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartnerAdapt;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartnerEvents;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegisterAdapt:ModelRegistry;
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(AddressService,function(param1:Object):void {
        PartnerService.addressService = AddressService(param1);
      },function():AddressService {
        return PartnerService.addressService;
      });
      osgi.injectService(LogService,function(param1:Object):void {
        PartnerService.log = LogService(param1);
      },function():LogService {
        return PartnerService.log;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        PartnerService.paramsService = ILauncherParams(param1);
      },function():ILauncherParams {
        return PartnerService.paramsService;
      });
      modelRegisterAdapt = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegisterAdapt.registerAdapt(SocialNetworkParameters,SocialNetworkParametersAdapt);
      modelRegisterAdapt.registerEvents(SocialNetworkParameters,SocialNetworkParametersEvents);
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new SocialNetworkParametersModel());
      modelRegisterAdapt.registerAdapt(IParametersListener,IParametersListenerAdapt);
      modelRegisterAdapt.registerEvents(IParametersListener,IParametersListenerEvents);
      modelRegisterAdapt.registerAdapt(IPartner,IPartnerAdapt);
      modelRegisterAdapt.registerEvents(IPartner,IPartnerEvents);
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
