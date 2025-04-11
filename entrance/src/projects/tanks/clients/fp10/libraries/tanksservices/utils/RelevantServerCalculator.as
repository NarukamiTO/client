package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  public class RelevantServerCalculator {
    public static const MAX_RANK:int = 31;

    private static const FRONT_GAP_PERCENT:Number = 0.09;

    public function RelevantServerCalculator() {
      super();
    }

    public static function getBestLocaleServer(param1:int, param2:int) : int {
      return Math.round(getFloatBestServer(getCoefForCalculateServer(param1),param2));
    }

    public static function getFloatBestServer(param1:Number, param2:int) : Number {
      var local3:Number = param1 * param2 + Math.ceil(FRONT_GAP_PERCENT * param2);
      return Math.min(local3,param2);
    }

    public static function getCoefForCalculateServer(param1:int) : Number {
      return 2 - Math.pow(param1,0.205);
    }
  }
}
