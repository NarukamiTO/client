package alternativa.tanks.help {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DateTimeHelper {
    [Inject]
    public static var localeService:ILocaleService;

    private static const MILLISECONDS_IN_SECOND:int = 1000;
    private static const DAY_IN_MILLISECONDS:int = 24 * 60 * 60 * MILLISECONDS_IN_SECOND;

    public function DateTimeHelper() {
      super();
    }

    public static function formatDateTimeWithExpiredLabel(param1:Date) : String {
      var local3:Number = NaN;
      var local2:String = " ";
      if(!isNaN(param1.date)) {
        local3 = param1.getTime() - new Date().getTime();
        if(local3 < DAY_IN_MILLISECONDS) {
          local2 = localeService.getText(TanksLocale.TEXT_PREMIUM_COMPLETION_IN) + DateFormatter.formatTime(param1);
        } else {
          local2 = localeService.getText(TanksLocale.TEXT_PREMIUM_COMPLETION) + DateFormatter.formatDateToLocalized(param1);
        }
      }
      return local2;
    }

    public static function convertSecondsToMilliseconds(param1:int) : Number {
      return Number(param1) * MILLISECONDS_IN_SECOND;
    }
  }
}
