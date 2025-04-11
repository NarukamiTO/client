package alternativa.tanks.calculators {
  public class CalculatorHelper {
    public function CalculatorHelper() {
      super();
    }

    public static function toCrystals(param1:Number) : int {
      return int(param1 + 1e-8);
    }

    public static function toMoney(param1:Number) : Number {
      return Math.ceil(param1 * 100 - 1e-8) * 0.01;
    }
  }
}
