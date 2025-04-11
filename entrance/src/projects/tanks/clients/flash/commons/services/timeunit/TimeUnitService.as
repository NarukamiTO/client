package projects.tanks.clients.flash.commons.services.timeunit {
  import alternativa.osgi.service.locale.ILocaleService;

  public class TimeUnitService implements ITimeUnitService {
    [Inject]
    public static var localeService:ILocaleService;

    public function TimeUnitService() {
      super();
    }

    private static function getRuTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      var local4:TimeUnitNames = new TimeUnitNames();
      param3 %= 100;
      if(param3 >= 11 && param3 <= 19) {
        local4.dayName = "дней";
      } else {
        param3 %= 10;
        if(param3 == 1) {
          local4.dayName = "день";
        } else if(param3 >= 2 && param3 <= 4) {
          local4.dayName = "дня";
        } else {
          local4.dayName = "дней";
        }
      }
      if(param2 == 1 || param2 == 21) {
        local4.hourName = "час";
      } else if(param2 >= 2 && param2 <= 4 || param2 >= 22 && param2 <= 24) {
        local4.hourName = "часа";
      } else if(param2 >= 5 && param2 <= 20) {
        local4.hourName = "часов";
      }
      if(param1 == 0 || param1 == 1 || param1 == 21 || param1 == 31 || param1 == 41 || param1 == 51) {
        local4.minuteName = "минуту";
      } else if(param1 >= 2 && param1 <= 4 || param1 >= 22 && param1 <= 24 || param1 >= 32 && param1 <= 34 || param1 >= 42 && param1 <= 44 || param1 >= 52 && param1 <= 54) {
        local4.minuteName = "минуты";
      } else if(param1 >= 5 && param1 <= 20 || param1 >= 25 && param1 <= 30 || param1 >= 35 && param1 <= 40 || param1 >= 45 && param1 <= 50 || param1 >= 55 && param1 <= 60) {
        local4.minuteName = "минут";
      }
      return local4;
    }

    private static function getEnTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      var local4:TimeUnitNames = new TimeUnitNames();
      if(param3 == 1) {
        local4.dayName = "day";
      } else {
        local4.dayName = "days";
      }
      if(param2 == 1) {
        local4.hourName = "hour";
      } else {
        local4.hourName = "hours";
      }
      if(param1 == 1 || param1 == 0) {
        local4.minuteName = "minute";
      } else {
        local4.minuteName = "minutes";
      }
      return local4;
    }

    private static function getDeTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      var local4:TimeUnitNames = new TimeUnitNames();
      if(param3 == 1) {
        local4.dayName = "Tag";
      } else {
        local4.dayName = "Tage";
      }
      if(param2 == 1) {
        local4.hourName = "Stunde";
      } else {
        local4.hourName = "Stunden";
      }
      if(param1 == 1 || param1 == 0) {
        local4.minuteName = "Minute";
      } else {
        local4.minuteName = "Minuten";
      }
      return local4;
    }

    private static function getBrTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      var local4:TimeUnitNames = new TimeUnitNames();
      if(param3 == 1) {
        local4.dayName = "dia";
      } else {
        local4.dayName = "dias";
      }
      if(param2 == 1) {
        local4.hourName = "hora";
      } else {
        local4.hourName = "horas";
      }
      if(param1 == 1 || param1 == 0) {
        local4.minuteName = "minuto";
      } else {
        local4.minuteName = "minutos";
      }
      return local4;
    }

    private static function getEsTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      var local4:TimeUnitNames = new TimeUnitNames();
      if(param3 == 1) {
        local4.dayName = "día";
      } else {
        local4.dayName = "días";
      }
      if(param2 == 1) {
        local4.hourName = "hora";
      } else {
        local4.hourName = "horas";
      }
      if(param1 == 1 || param1 == 0) {
        local4.minuteName = "minuto";
      } else {
        local4.minuteName = "minutos";
      }
      return local4;
    }

    private static function getCnTimeUnitNames() : TimeUnitNames {
      var local1:TimeUnitNames = new TimeUnitNames();
      local1.dayName = "天";
      local1.hourName = "小时";
      local1.minuteName = "分鐘";
      return local1;
    }

    private static function getFaTimeUnitNames() : TimeUnitNames {
      var local1:TimeUnitNames = new TimeUnitNames();
      local1.dayName = "روز";
      local1.hourName = "ساعت";
      local1.minuteName = "دقیقه";
      return local1;
    }

    private static function getPlTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      var local4:TimeUnitNames = new TimeUnitNames();
      if(param3 == 1) {
        local4.dayName = "dzień";
      } else {
        local4.dayName = "dni";
      }
      if(param2 == 1) {
        local4.hourName = "godzina";
      } else {
        local4.hourName = "godzin";
      }
      if(param1 == 0) {
        local4.minuteName = "minut";
      } else if(param1 == 1) {
        local4.minuteName = "minuta";
      } else if(param1 >= 2 && param1 <= 4 || param1 >= 22 && param1 <= 24 || param1 >= 32 && param1 <= 34 || param1 >= 42 && param1 <= 44 || param1 >= 52 && param1 <= 54) {
        local4.minuteName = "minuty";
      } else {
        local4.minuteName = "minut";
      }
      return local4;
    }

    public function getLocalizedTimeString(param1:int, param2:int, param3:int) : String {
      var local4:String = "";
      var local5:TimeUnitNames = this.getTimeUnitNames(param1,param2,param3);
      if(param3 == 0 && param2 == 0 && param1 == 0) {
        return "1 " + local5.minuteName;
      }
      if(param3 != 0) {
        local4 = param3 + " " + local5.dayName;
      }
      if(param2 != 0) {
        local4 = local4 + " " + param2 + " " + local5.hourName;
      }
      if(param1 != 0) {
        local4 = local4 + " " + param1 + " " + local5.minuteName;
      }
      return local4;
    }

    public function getLocalizedDaysString(param1:int) : String {
      return param1 + " " + this.getLocalizedDaysName(param1);
    }

    public function getLocalizedDaysName(param1:int) : String {
      return this.getTimeUnitNames(0,0,param1).dayName;
    }

    public function getLocalizedShortDaysName(param1:int) : String {
      switch(localeService.language) {
        case "cn":
        case "fa":
          return this.getLocalizedDaysName(param1);
        default:
          return this.getLocalizedDaysName(param1).charAt(0);
      }
    }

    public function getTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames {
      switch(localeService.language) {
        case "ru":
          return getRuTimeUnitNames(param1,param2,param3);
        case "de":
          return getDeTimeUnitNames(param1,param2,param3);
        case "pt_BR":
          return getBrTimeUnitNames(param1,param2,param3);
        case "pl":
          return getPlTimeUnitNames(param1,param2,param3);
        case "es":
          return getEsTimeUnitNames(param1,param2,param3);
        case "cn":
          return getCnTimeUnitNames();
        case "fa":
          return getFaTimeUnitNames();
        case "en":
      }
      return getEnTimeUnitNames(param1,param2,param3);
    }
  }
}
