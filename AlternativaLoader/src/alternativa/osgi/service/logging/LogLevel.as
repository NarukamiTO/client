package alternativa.osgi.service.logging {
  public class LogLevel {
    public static const TRACE:LogLevel = new LogLevel(1,"TRACE");
    public static const DEBUG:LogLevel = new LogLevel(2,"DEBUG");
    public static const INFO:LogLevel = new LogLevel(3,"INFO");
    public static const WARNING:LogLevel = new LogLevel(4,"WARNING");
    public static const ERROR:LogLevel = new LogLevel(5,"ERROR");

    private var value:int;
    private var name:String;

    public function LogLevel(param1:int, param2:String) {
      super();
      this.value = param1;
      this.name = param2;
    }

    public static function byValue(param1:int) : LogLevel {
      switch(param1) {
        case 1:
          return TRACE;
        case 2:
          return DEBUG;
        case 3:
          return INFO;
        case 4:
          return WARNING;
        case 5:
          return ERROR;
        default:
          return TRACE;
      }
    }

    public static function byName(param1:String) : LogLevel {
      switch(param1) {
        case "TRACE":
          return LogLevel.TRACE;
        case "DEBUG":
          return LogLevel.DEBUG;
        case "INFO":
          return LogLevel.INFO;
        case "WARNING":
          return LogLevel.WARNING;
        case "ERROR":
          return LogLevel.ERROR;
        default:
          return LogLevel.TRACE;
      }
    }

    public function getValue() : int {
      return this.value;
    }

    public function getName() : String {
      return this.name;
    }

    public function toString() : String {
      return "[LogLevel " + this.name + " " + this.value + "]";
    }
  }
}
