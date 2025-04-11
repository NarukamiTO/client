package alternativa.tanks.model.item.upgradable.calculators {
  public class BasePropertyCalculator implements PropertyCalculator, PropertyValueCalculator {
    private var precision:int;
    private var factor:Number;
    private var calculator:PropertyValueCalculator;

    public function BasePropertyCalculator(param1:int, param2:PropertyValueCalculator) {
      super();
      this.calculator = param2;
      this.precision = param1;
      this.factor = this.factor = Math.pow(10,-param1);
    }

    public function getValue(param1:int) : String {
      var local2:Number = this.getRoundValue(param1);
      return this.valueToString(local2);
    }

    public function getNumberValue(param1:int) : Number {
      return this.calculate(param1);
    }

    public function getDelta(param1:int) : String {
      var local3:String = null;
      var local2:Number = this.round(this.getRoundValue(param1 + 1) - this.getRoundValue(param1));
      if(this.calculate(1) - this.calculate(0) < 0) {
        local3 = "−";
        local2 = -local2;
      } else {
        local3 = "+";
      }
      return local3 + this.valueToString(local2);
    }

    private function valueToString(param1:Number) : String {
      return param1.toFixed(this.precision);
    }

    private function getRoundValue(param1:int) : Number {
      return this.round(this.calculate(param1));
    }

    private function calculate(param1:int) : Number {
      return this.calculator.getNumberValue(param1);
    }

    private function round(param1:Number) : Number {
      return Math.round(param1 / this.factor) * this.factor;
    }

    public function getPrecision() : int {
      return this.precision;
    }
  }
}
