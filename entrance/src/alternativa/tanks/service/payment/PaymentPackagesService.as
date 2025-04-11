package alternativa.tanks.service.payment {
  import flash.events.EventDispatcher;
  import projects.tanks.client.panel.model.payment.CrystalsPaymentCC;
  import projects.tanks.client.panel.model.payment.PaymentPackage;

  public class PaymentPackagesService extends EventDispatcher implements IPaymentPackagesService {
    private var packages:Object;
    private var _calculatorEnabled:Boolean;
    private var initialized:Boolean = false;

    public function PaymentPackagesService() {
      super();
    }

    public function init(param1:CrystalsPaymentCC) : void {
      this._calculatorEnabled = param1.calculatorEnabled;
      var local2:int = int(param1.paymentPackages.length);
      this.packages = {};
      var local3:int = 0;
      while(local3 < local2) {
        this.addPackage(param1.paymentPackages[local3]);
        local3++;
      }
      this.sortPackages();
      this.initialized = true;
      dispatchEvent(new PaymentPackageEvent(PaymentPackageEvent.PACKAGES_ADDED));
    }

    public function isInitialized() : Boolean {
      return this.initialized;
    }

    private function addPackage(param1:PaymentPackage) : void {
      if(!this.packages[param1.currency]) {
        this.packages[param1.currency] = new Vector.<PaymentPackageInfo>();
      }
      var local2:PaymentPackageInfo = new PaymentPackageInfo(param1);
      this.packages[param1.currency].push(local2);
    }

    private function sortPackages() : void {
      var currency:String = null;
      var sortFunction:Function = function(param1:PaymentPackageInfo, param2:PaymentPackageInfo):int {
        return param1.amountCrystals < param2.amountCrystals ? -1 : 1;
      };
      for(currency in this.packages) {
        this.getPackagesOfCurrency(currency).sort(sortFunction);
      }
    }

    private function getPackagesOfCurrency(param1:String) : Vector.<PaymentPackageInfo> {
      if(this.packages[param1] == null) {
        param1 = "RUB";
      }
      return Vector.<PaymentPackageInfo>(this.packages[param1]);
    }

    public function getPackageCrystals(param1:int, param2:String) : int {
      return this.getPackagesOfCurrency(param2)[param1].amountCrystals;
    }

    public function getBonusCrystals(param1:int, param2:String) : int {
      return this.getPackagesOfCurrency(param2)[param1].bonusCrystals;
    }

    public function numPackages(param1:String) : int {
      return this.getPackagesOfCurrency(param1).length;
    }

    public function getPrice(param1:int, param2:String) : Number {
      return this.getPackagesOfCurrency(param2)[param1].price;
    }

    public function getPremiumDuration(param1:int, param2:String) : int {
      return this.getPackagesOfCurrency(param2)[param1].premiumDurationInDays;
    }

    public function hasPremium(param1:int, param2:String) : Boolean {
      return this.getPremiumDuration(param1,param2) > 0;
    }

    public function get calculatorEnabled() : Boolean {
      return this._calculatorEnabled;
    }

    public function hasPackagesInCurrency(param1:String) : Boolean {
      return this.packages[param1] != null;
    }

    public function getPackagePrice(param1:String, param2:int) : Number {
      var local4:PaymentPackageInfo = null;
      var local3:Vector.<PaymentPackageInfo> = this.getPackagesOfCurrency(param1);
      for each(local4 in local3) {
        if(local4.amountCrystals == param2) {
          return local4.price;
        }
      }
      return 0;
    }
  }
}
