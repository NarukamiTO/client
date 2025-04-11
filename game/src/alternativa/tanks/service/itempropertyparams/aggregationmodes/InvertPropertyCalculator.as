package alternativa.tanks.service.itempropertyparams.aggregationmodes {
  import alternativa.tanks.model.item.upgradable.calculators.LinearPropertyValueCalculator;

  public class InvertPropertyCalculator extends LinearPropertyValueCalculator {
    public function InvertPropertyCalculator(param1:Number, param2:Number, param3:int) {
      super(param1,param2,param3);
    }

    override public function getNumberValue(param1:int) : Number {
      return 1 / super.getNumberValue(param1);
    }
  }
}
