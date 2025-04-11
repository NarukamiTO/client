package alternativa.tanks.service.payment {
  import projects.tanks.client.panel.model.payment.PaymentPackage;

  public class PaymentPackageInfo {
    private var _amountCrystals:int;
    private var _bonusCrystals:int;
    private var _price:Number;
    private var _premiumDurationInDays:int;

    public function PaymentPackageInfo(param1:PaymentPackage) {
      super();
      this._amountCrystals = param1.amountCrystals;
      this._bonusCrystals = param1.bonusCrystals;
      this._price = param1.price;
      this._premiumDurationInDays = param1.premiumDurationInDays;
    }

    public function get amountCrystals() : int {
      return this._amountCrystals;
    }

    public function set amountCrystals(param1:int) : void {
      this._amountCrystals = param1;
    }

    public function get bonusCrystals() : int {
      return this._bonusCrystals;
    }

    public function set bonusCrystals(param1:int) : void {
      this._bonusCrystals = param1;
    }

    public function get price() : Number {
      return this._price;
    }

    public function set price(param1:Number) : void {
      this._price = param1;
    }

    public function get premiumDurationInDays() : int {
      return this._premiumDurationInDays;
    }

    public function set premiumDurationInDays(param1:int) : void {
      this._premiumDurationInDays = param1;
    }
  }
}
