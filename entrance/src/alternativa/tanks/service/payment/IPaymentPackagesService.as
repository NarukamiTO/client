package alternativa.tanks.service.payment {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.payment.CrystalsPaymentCC;

  public interface IPaymentPackagesService extends IEventDispatcher {
    function getPackageCrystals(param1:int, param2:String) : int;
    function getBonusCrystals(param1:int, param2:String) : int;
    function getPrice(param1:int, param2:String) : Number;
    function getPremiumDuration(param1:int, param2:String) : int;
    function hasPremium(param1:int, param2:String) : Boolean;
    function numPackages(param1:String) : int;
    function hasPackagesInCurrency(param1:String) : Boolean;
    function getPackagePrice(param1:String, param2:int) : Number;
    function get calculatorEnabled() : Boolean;
    function init(param1:CrystalsPaymentCC) : void;
    function isInitialized() : Boolean;
  }
}
