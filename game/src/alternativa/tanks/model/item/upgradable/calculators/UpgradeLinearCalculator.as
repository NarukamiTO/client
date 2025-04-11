package alternativa.tanks.model.item.upgradable.calculators {
  public class UpgradeLinearCalculator {
    private var initialValue:Number;
    private var step:Number;

    public function UpgradeLinearCalculator(param1:Number, param2:Number, param3:int) {
      super();
      this.initialValue = param1;
      if(param3 == 0) {
        this.step = 0;
      } else {
        this.step = (param2 - param1) / param3;
      }
    }

    public function getIntValue(param1:int) : int {
      return Math.round(this.getValue(param1));
    }

    public function getValue(param1:int) : Number {
      return this.initialValue + this.step * param1;
    }
  }
}
