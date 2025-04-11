package projects.tanks.clients.fp10.TanksLauncher.service {
  import flash.external.ExternalInterface;
  import projects.tanks.clients.tankslauncershared.service.Locale;

  public class LocaleService {
    private static var _currentLocale:String = Locale.EN;

    public function LocaleService() {
      super();
    }

    public static function get anotherGameServerUrl() : String {
      var local1:String = null;
      var local2:String = null;
      switch(currentLocale) {
        case Locale.CN:
          local1 = "http://3dtank.com";
          break;
        default:
          local1 = "http://tankionline.com/" + currentLocale.toLowerCase();
      }
      if(ExternalInterface.available) {
        local2 = ExternalInterface.call("getPreferGameServerUrl");
        if(local2 != null) {
          local1 = local2;
        }
      }
      return local1;
    }

    public static function get currentLocale() : String {
      return _currentLocale;
    }

    public static function updateCurrentLocale(param1:String) : void {
      if(param1) {
        param1 = param1.toUpperCase();
        if(Locale.LOCALES.indexOf(param1) != -1) {
          _currentLocale = Locale.LOCALES[Locale.LOCALES.indexOf(param1)];
        }
      }
    }
  }
}
