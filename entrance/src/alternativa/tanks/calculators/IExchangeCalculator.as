package alternativa.tanks.calculators {
  public interface IExchangeCalculator {
    function calculateWithoutPackets(param1:int) : Number;
    function calculateCrystalsWithoutPackets(param1:Number) : int;
    function calculate(param1:int) : Number;
    function calculateUsingPaymentPackages(param1:int) : Number;
    function calculateInverse(param1:Number) : int;
    function calculateBonus(param1:Number) : int;
    function calculatePremiumDuration(param1:Number) : int;
  }
}
