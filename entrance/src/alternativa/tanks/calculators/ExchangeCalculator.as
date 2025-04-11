package alternativa.tanks.calculators {
  import alternativa.tanks.service.payment.IPaymentPackagesService;
  import alternativa.tanks.service.payment.IPaymentService;

  public class ExchangeCalculator implements IExchangeCalculator {
    [Inject]
    public static var paymentPackagesService:IPaymentPackagesService;

    [Inject]
    public static var paymentService:IPaymentService;

    private static const RUB_CURRENCY:String = "RUB";

    private var multiplier:Number;
    private var addition:Number;
    private var currencyRate:Number;
    private var _currency:String;

    public function ExchangeCalculator(param1:Number, param2:String, param3:Number = 0, param4:Number = 0) {
      super();
      this.multiplier = param1;
      this._currency = param2;
      this.addition = param3;
      this.currencyRate = param4;
    }

    public function set currency(param1:String) : void {
      this._currency = param1;
    }

    public function calculateWithoutPackets(param1:int) : Number {
      return CalculatorHelper.toMoney((param1 * this.multiplier + this.addition) / this.currencyRate);
    }

    public function calculateCrystalsWithoutPackets(param1:Number) : int {
      return CalculatorHelper.toCrystals((param1 * this.currencyRate - this.addition) / this.multiplier);
    }

    public function calculate(param1:int) : Number {
      var local2:int = paymentPackagesService.numPackages(RUB_CURRENCY);
      var local3:Number = this.calculatePackages(param1 * paymentService.getCrystalCost(),paymentPackagesService.getPrice,paymentPackagesService.getPrice,local2);
      var local4:int = this.calculatePackages(local3,paymentPackagesService.getPrice,paymentPackagesService.getPackageCrystals,local2);
      var local5:int = param1 - local4;
      if(local5 < 0) {
        local5 = 0;
      }
      var local6:Number = local5 * this.multiplier + this.applyCommission(local3);
      return local6 > 0 ? CalculatorHelper.toMoney(local6 / this.currencyRate) : 0;
    }

    public function calculateUsingPaymentPackages(param1:int) : Number {
      var local2:Number = NaN;
      if(paymentPackagesService.hasPackagesInCurrency(this._currency)) {
        local2 = paymentPackagesService.getPackagePrice(this._currency,param1);
        if(local2 > 0) {
          return CalculatorHelper.toMoney(local2 * this.multiplier / paymentService.getCrystalCost() + this.addition);
        }
      }
      return this.calculate(param1);
    }

    public function calculateInverse(param1:Number) : int {
      var local2:int = paymentPackagesService.numPackages(RUB_CURRENCY);
      var local3:Number = (param1 * this.currencyRate - this.addition) / this.multiplier * paymentService.getCrystalCost();
      var local4:Number = this.calculatePackages(local3,paymentPackagesService.getPrice,paymentPackagesService.getPrice,local2);
      var local5:int = this.calculatePackages(local3,paymentPackagesService.getPrice,paymentPackagesService.getPackageCrystals,local2);
      var local6:Number = (local3 - local4) / paymentService.getCrystalCost();
      return CalculatorHelper.toCrystals(local5 + local6);
    }

    public function calculateBonus(param1:Number) : int {
      var local2:Number = (param1 * this.currencyRate - this.addition) / this.multiplier * paymentService.getCrystalCost();
      return this.calculatePackages(local2,paymentPackagesService.getPrice,paymentPackagesService.getBonusCrystals,paymentPackagesService.numPackages(RUB_CURRENCY));
    }

    public function calculatePremiumDuration(param1:Number) : int {
      var local2:Number = (param1 * this.currencyRate - this.addition) / this.multiplier * paymentService.getCrystalCost();
      return this.calculatePackages(local2,paymentPackagesService.getPrice,paymentPackagesService.getPremiumDuration,paymentPackagesService.numPackages(RUB_CURRENCY));
    }

    public function init(param1:Number, param2:Number = 0, param3:Number = 0) : void {
      this.multiplier = param1;
      this.addition = param2;
      this.currencyRate = param3;
    }

    private function applyCommission(param1:Number) : Number {
      return param1 / paymentService.getCrystalCost() * this.multiplier + this.addition;
    }

    private function calculatePackages(param1:Number, param2:Function, param3:Function, param4:int) : Number {
      var local8:int = 0;
      var local9:int = 0;
      var local5:Number = param1;
      var local6:Number = 0;
      var local7:int = param4 - 1;
      while(local7 >= 0) {
        local8 = param2(local7,RUB_CURRENCY);
        local9 = int(local5 / local8);
        local6 += param3(local7,RUB_CURRENCY) * local9;
        local5 -= local8 * local9;
        if(local5 == 0) {
          break;
        }
        local7--;
      }
      return local6;
    }
  }
}
