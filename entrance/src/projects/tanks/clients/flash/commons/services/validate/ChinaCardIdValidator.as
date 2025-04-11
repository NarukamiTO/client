package projects.tanks.clients.flash.commons.services.validate {
  public class ChinaCardIdValidator {
    private static const KEY:Vector.<int> = Vector.<int>([7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]);
    private static const AUTH:Vector.<String> = Vector.<String>(["1","0","x","9","8","7","6","5","4","3","2"]);
    private static const REGIONS_LIST:Vector.<String> = Vector.<String>(["11","12","13","14","15","21","22","23","31","32","33","34","35","36","37","41","42","43","44","45","46","50","51","52","53","54","61","62","63","64","65","71","81","82","91"]);
    private static const VALID_ID_LENGTH:int = 18;
    private static const MOD_CHECK_SUM:int = 11;

    public function ChinaCardIdValidator() {
      super();
    }

    public static function isValidIdNumber(param1:String) : Boolean {
      var local13:Number = NaN;
      var local2:int = param1.length;
      if(local2 != VALID_ID_LENGTH) {
        return false;
      }
      var local3:int = 0;
      while(local3 < local2) {
        local13 = Number(param1.charCodeAt(local3));
        if(local13 < 48 || local13 > 57) {
          return false;
        }
        local3++;
      }
      var local4:String = param1.substr(0,2);
      if(REGIONS_LIST.indexOf(local4) == -1) {
        return false;
      }
      var local5:Date = new Date();
      var local6:Number = local5.fullYear;
      var local7:int = parseInt(param1.substr(6,4));
      if(local7 < 1900 || local7 > local6) {
        return false;
      }
      var local8:int = parseInt(param1.substr(10,2));
      var local9:int = parseInt(param1.substr(12,2));
      if(local8 < 1 || local8 > 12 || local9 < 1 || local9 > 31) {
        return false;
      }
      var local10:int = 0;
      var local11:int = local2 - 1;
      var local12:int = 0;
      while(local12 < local11) {
        local10 += KEY[local12] * parseInt(param1.substr(local12,1));
        local12++;
      }
      if(param1.charAt(local11).toLowerCase() != AUTH[local10 % MOD_CHECK_SUM]) {
        return false;
      }
      return true;
    }
  }
}
