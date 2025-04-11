package alternativa.tanks.controllers.battleinfo {
  public class TimeStringUtils {
    public function TimeStringUtils() {
      super();
    }

    public static function getTimeStr(param1:int) : String {
      var local2:String = null;
      var local3:int = int(param1 / 60);
      var local4:int = param1 - local3 * 60;
      return String(local3) + ":" + (local4 > 9 ? String(local4) : "0" + String(local4));
    }
  }
}
