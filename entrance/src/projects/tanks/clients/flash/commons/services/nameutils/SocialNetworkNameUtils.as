package projects.tanks.clients.flash.commons.services.nameutils {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class SocialNetworkNameUtils {
    [Inject]
    public static var localeService:ILocaleService;

    public function SocialNetworkNameUtils() {
      super();
    }

    public static function makeSocialNetworkNameFromId(param1:String) : String {
      switch(param1) {
        case "vkontakte":
          return localeService.getText(TanksLocale.TEXT_VKONTAKTE_NAME);
        case "facebook":
          return localeService.getText(TanksLocale.TEXT_FACEBOOK_NAME);
        default:
          return param1.substr(0,1).toUpperCase() + param1.substr(1);
      }
    }
  }
}
