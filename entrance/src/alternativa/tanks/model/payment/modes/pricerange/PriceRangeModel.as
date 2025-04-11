package alternativa.tanks.model.payment.modes.pricerange {
  import projects.tanks.client.panel.model.payment.modes.pricerange.IPriceRangeModelBase;
  import projects.tanks.client.panel.model.payment.modes.pricerange.PriceRangeModelBase;

  [ModelInfo]
  public class PriceRangeModel extends PriceRangeModelBase implements IPriceRangeModelBase, PriceRange {
    public function PriceRangeModel() {
      super();
    }

    public function priceIsValid(param1:Number) : Boolean {
      if(!getInitParam().enabled) {
        return true;
      }
      return param1 >= getInitParam().minimum;
    }
  }
}
