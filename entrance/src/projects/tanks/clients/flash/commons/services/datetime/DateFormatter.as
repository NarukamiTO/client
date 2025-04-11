package projects.tanks.clients.flash.commons.services.datetime {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import flash.globalization.DateTimeFormatter;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DateFormatter {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var logService:LogService;

    private static var dateFormat:DateTimeFormatter;
    private static var timeFormat:DateTimeFormatter;
    private static var timeFormatMessageChat:DateTimeFormatter;

    public function DateFormatter() {
      super();
    }

    public static function formatDateToLocalized(param1:Date) : String {
      if(dateFormat == null) {
        dateFormat = new DateTimeFormatter("");
        dateFormat.setDateTimePattern(localeService.getText(TanksLocale.TEXT_DATE_FORMAT));
      }
      return dateFormat.format(param1);
    }

    public static function formatTime(param1:Date) : String {
      if(timeFormat == null) {
        timeFormat = new DateTimeFormatter("");
        timeFormat.setDateTimePattern("HH:mm");
      }
      return timeFormat.format(param1);
    }

    public static function formatTimeForChatToLocalized(param1:Date) : String {
      if(timeFormatMessageChat == null) {
        timeFormatMessageChat = new DateTimeFormatter("");
        timeFormatMessageChat.setDateTimePattern("HH:mm");
      }
      return timeFormatMessageChat.format(param1);
    }
  }
}
