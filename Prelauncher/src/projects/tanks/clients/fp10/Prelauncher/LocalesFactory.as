package projects.tanks.clients.fp10.Prelauncher {
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.Prelauncher.locales.BR.LocaleBR;
  import projects.tanks.clients.fp10.Prelauncher.locales.CN.LocaleCN;
  import projects.tanks.clients.fp10.Prelauncher.locales.DE.LocaleDE;
  import projects.tanks.clients.fp10.Prelauncher.locales.EN.LocaleEn;
  import projects.tanks.clients.fp10.Prelauncher.locales.ES.LocaleES;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.locales.PL.LocalePL;
  import projects.tanks.clients.fp10.Prelauncher.locales.RU.LocaleRU;

  public class LocalesFactory {
    private static var locales:Dictionary;

    public function LocalesFactory() {
      super();
    }

    private static function initLocales() : void {
      locales = new Dictionary();
      locales[Locales.RU] = new LocaleRU();
      locales[Locales.EN] = new LocaleEn();
      locales[Locales.DE] = new LocaleDE();
      locales[Locales.CN] = new LocaleCN();
      locales[Locales.BR] = new LocaleBR();
      locales[Locales.PL] = new LocalePL();
      locales[Locales.ES] = new LocaleES();
    }

    public static function getLocale(locale:String) : Locale {
      if(locales == null) {
        initLocales();
      }
      if(locales[locale] == null) {
        return locales[Locales.RU];
      }
      return locales[locale];
    }
  }
}
