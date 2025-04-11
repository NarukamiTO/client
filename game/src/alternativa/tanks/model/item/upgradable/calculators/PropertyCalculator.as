package alternativa.tanks.model.item.upgradable.calculators {
  public interface PropertyCalculator {
    function getValue(param1:int) : String;
    function getPrecision() : int;
    function getDelta(param1:int) : String;
  }
}
