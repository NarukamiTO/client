package alternativa.tanks.calculators {
  import flash.geom.Point;

  public class LinearUtil {
    public function LinearUtil() {
      super();
    }

    public static function interpolateX(param1:Point, param2:Point, param3:Number) : Number {
      return param1.y + (param3 - param1.x) / (param2.x - param1.x) * (param2.y - param1.y);
    }

    public static function interpolateY(param1:Point, param2:Point, param3:Number) : Number {
      return param1.x + (param3 - param1.y) / (param2.y - param1.y) * (param2.x - param1.x);
    }
  }
}
