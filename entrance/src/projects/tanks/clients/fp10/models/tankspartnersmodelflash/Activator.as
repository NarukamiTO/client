package projects.tanks.clients.fp10.models.tankspartnersmodelflash {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.service.address.AddressService;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.china3rdplatform.China3rdPlatformLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.china3rdplatform.China3rdPlatformPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.ifeng.IfengModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.kuaiwan.KuaiwanModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.mobilesdk.ChinaMobileSDKEntranceModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner2144.Partner2144Model;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner360platform.Partner360PlatformModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner4399.Partner4399Model;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner7k7k.Partner7k7kModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.china.tmall.TmallModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.armorgames.ArmorGamesLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.asiasoft.AsiaSoftFakeModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.facebook.FacebookInternalLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.facebook.FacebookPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.fakepartner.FakePartnerLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.idnet.IdNetLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.kongregate.KongregateLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.kongregate.KongregatePaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.mailru.MailruGamesLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.mailru.MailruGamesPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.miniclip.MiniclipLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.miniplay.MiniplayLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.miniplay.MiniplayPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.odnoklassniki.OdnoklassnikiInternalLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.odnoklassniki.OdnoklassnikiPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.rambler.RamblerLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.rambler.RamblerPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam.SteamLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam.SteamPaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.vkontakte.VkontakteInternalLoginModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.vkontakte.VkontaktePaymentModel;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.services.SteamDataService;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var modelRegister:ModelRegistry;
      var _osgi:OSGi = param1;
      osgi = _osgi;
      osgi.injectService(AddressService,function(param1:Object):void {
        China3rdPlatformLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return China3rdPlatformLoginModel.addressService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        China3rdPlatformPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return China3rdPlatformPaymentModel.paymentWindowService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        IfengModel.addressService = AddressService(param1);
      },function():AddressService {
        return IfengModel.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        KuaiwanModel.addressService = AddressService(param1);
      },function():AddressService {
        return KuaiwanModel.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        Partner2144Model.addressService = AddressService(param1);
      },function():AddressService {
        return Partner2144Model.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        Partner360PlatformModel.addressService = AddressService(param1);
      },function():AddressService {
        return Partner360PlatformModel.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        Partner4399Model.addressService = AddressService(param1);
      },function():AddressService {
        return Partner4399Model.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        Partner7k7kModel.addressService = AddressService(param1);
      },function():AddressService {
        return Partner7k7kModel.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        TmallModel.addressService = AddressService(param1);
      },function():AddressService {
        return TmallModel.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        ArmorGamesLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return ArmorGamesLoginModel.addressService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        FacebookInternalLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return FacebookInternalLoginModel.addressService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        FacebookPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return FacebookPaymentModel.paymentWindowService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        IdNetLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return IdNetLoginModel.addressService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        KongregateLoginModel.displayService = IDisplay(param1);
      },function():IDisplay {
        return KongregateLoginModel.displayService;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        KongregateLoginModel.launcherParams = ILauncherParams(param1);
      },function():ILauncherParams {
        return KongregateLoginModel.launcherParams;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        KongregatePaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return KongregatePaymentModel.paymentWindowService;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        MailruGamesLoginModel.paramsService = ILauncherParams(param1);
      },function():ILauncherParams {
        return MailruGamesLoginModel.paramsService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        MailruGamesPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return MailruGamesPaymentModel.paymentWindowService;
      });
      osgi.injectService(IDisplay,function(param1:Object):void {
        MiniclipLoginModel.displayService = IDisplay(param1);
      },function():IDisplay {
        return MiniclipLoginModel.displayService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        MiniplayLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return MiniplayLoginModel.addressService;
      });
      osgi.injectService(ILauncherParams,function(param1:Object):void {
        MiniplayLoginModel.paramsService = ILauncherParams(param1);
      },function():ILauncherParams {
        return MiniplayLoginModel.paramsService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        MiniplayPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return MiniplayPaymentModel.paymentWindowService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        OdnoklassnikiInternalLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return OdnoklassnikiInternalLoginModel.addressService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        OdnoklassnikiPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return OdnoklassnikiPaymentModel.paymentWindowService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        RamblerLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return RamblerLoginModel.addressService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        RamblerPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return RamblerPaymentModel.paymentWindowService;
      });
      osgi.injectService(SteamDataService,function(param1:Object):void {
        SteamLoginModel.steamDataService = SteamDataService(param1);
      },function():SteamDataService {
        return SteamLoginModel.steamDataService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        SteamPaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return SteamPaymentModel.paymentWindowService;
      });
      osgi.injectService(SteamDataService,function(param1:Object):void {
        SteamPaymentModel.steamDataService = SteamDataService(param1);
      },function():SteamDataService {
        return SteamPaymentModel.steamDataService;
      });
      osgi.injectService(AddressService,function(param1:Object):void {
        VkontakteInternalLoginModel.addressService = AddressService(param1);
      },function():AddressService {
        return VkontakteInternalLoginModel.addressService;
      });
      osgi.injectService(PaymentWindowService,function(param1:Object):void {
        VkontaktePaymentModel.paymentWindowService = PaymentWindowService(param1);
      },function():PaymentWindowService {
        return VkontaktePaymentModel.paymentWindowService;
      });
      modelRegister = osgi.getService(ModelRegistry) as ModelRegistry;
      modelRegister.add(new China3rdPlatformLoginModel());
      modelRegister.add(new China3rdPlatformPaymentModel());
      modelRegister.add(new IfengModel());
      modelRegister.add(new KuaiwanModel());
      modelRegister.add(new ChinaMobileSDKEntranceModel());
      modelRegister.add(new Partner2144Model());
      modelRegister.add(new Partner360PlatformModel());
      modelRegister.add(new Partner4399Model());
      modelRegister.add(new Partner7k7kModel());
      modelRegister.add(new TmallModel());
      modelRegister.add(new ArmorGamesLoginModel());
      modelRegister.add(new AsiaSoftFakeModel());
      modelRegister.add(new FacebookInternalLoginModel());
      modelRegister.add(new FacebookPaymentModel());
      modelRegister.add(new FakePartnerLoginModel());
      modelRegister.add(new IdNetLoginModel());
      modelRegister.add(new KongregateLoginModel());
      modelRegister.add(new KongregatePaymentModel());
      modelRegister.add(new MailruGamesLoginModel());
      modelRegister.add(new MailruGamesPaymentModel());
      modelRegister.add(new MiniclipLoginModel());
      modelRegister.add(new MiniplayLoginModel());
      modelRegister.add(new MiniplayPaymentModel());
      modelRegister.add(new OdnoklassnikiInternalLoginModel());
      modelRegister.add(new OdnoklassnikiPaymentModel());
      modelRegister.add(new RamblerLoginModel());
      modelRegister.add(new RamblerPaymentModel());
      modelRegister.add(new SteamLoginModel());
      modelRegister.add(new SteamPaymentModel());
      modelRegister.add(new VkontakteInternalLoginModel());
      modelRegister.add(new VkontaktePaymentModel());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
