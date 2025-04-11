package utils {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class TimeFormatter {
    [Inject]
    public static var localeService:ILocaleService;

    private static const MINUTE:int = 60;
    private static const HOUR:int = MINUTE * 60;
    private static const DAY:int = HOUR * 24;

    public function TimeFormatter() {
      super();
    }

    public static function format(param1:int) : String {
      var local2:int = param1 / DAY;
      param1 %= DAY;
      var local3:int = param1 / HOUR;
      param1 %= HOUR;
      var local4:int = param1 / MINUTE;
      var local5:int = param1 % MINUTE;
      return formatDHMS(local2,local3,local4,local5);
    }

    public static function formatDHMS(param1:int, param2:int, param3:int, param4:int) : String {
      var local5:String = "";
      var local6:Boolean = localeService.language == "cn";
      if(param1 > 0) {
        local5 = add(param1,TanksLocale.TEXT_TIME_LABEL_DAY,local5);
        if(!local6) {
          local5 = add(param2,TanksLocale.TEXT_TIME_LABEL_HOUR,local5);
        }
      } else if(param2 > 0) {
        local5 = add(param2,TanksLocale.TEXT_TIME_LABEL_HOUR,local5);
        if(!local6) {
          local5 = add(param3,TanksLocale.TEXT_TIME_LABEL_MINUTE,local5);
        }
      } else if(param3 > 0) {
        local5 = add(param3,TanksLocale.TEXT_TIME_LABEL_MINUTE,local5);
        if(!local6) {
          local5 = add(param4,TanksLocale.TEXT_TIME_LABEL_SECOND,local5);
        }
      } else {
        local5 = add(param4,TanksLocale.TEXT_TIME_LABEL_SECOND,local5);
      }
      return local5;
    }

    private static function add(param1:int, param2:String, param3:String) : String {
      if(param1 > 0) {
        if(param3.length > 0) {
          param3 += " ";
        }
        param3 += param1 + localeService.getText(param2);
      }
      return param3;
    }
  }
}
