package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  public class UidUtil {
    public function UidUtil() {
      super();
    }

    public static function userNameWithoutClanTag(param1:String) : String {
      var local2:int = int(param1.indexOf("] "));
      if(local2 > 0) {
        return param1.substr(local2 + 2);
      }
      return param1;
    }
  }
}
