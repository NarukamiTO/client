package projects.tanks.client.panel.model.payment {
  public class CrystalsPaymentCC {
    private var _accountId:String;
    private var _calculatorEnabled:Boolean;
    private var _crystalCost:Number;
    private var _defaultAmountOfCrystals:int;
    private var _greaterMaximumCrystalsMessage:String;
    private var _greaterMaximumMoneyMessage:String;
    private var _lessMinimumCrystalsMessage:String;
    private var _lessMinimumMoneyMessage:String;
    private var _manualDescription:String;
    private var _paymentPackages:Vector.<PaymentPackage>;

    public function CrystalsPaymentCC(param1:String = null, param2:Boolean = false, param3:Number = 0, param4:int = 0, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null, param10:Vector.<PaymentPackage> = null) {
      super();
      this._accountId = param1;
      this._calculatorEnabled = param2;
      this._crystalCost = param3;
      this._defaultAmountOfCrystals = param4;
      this._greaterMaximumCrystalsMessage = param5;
      this._greaterMaximumMoneyMessage = param6;
      this._lessMinimumCrystalsMessage = param7;
      this._lessMinimumMoneyMessage = param8;
      this._manualDescription = param9;
      this._paymentPackages = param10;
    }

    public function get accountId() : String {
      return this._accountId;
    }

    public function set accountId(param1:String) : void {
      this._accountId = param1;
    }

    public function get calculatorEnabled() : Boolean {
      return this._calculatorEnabled;
    }

    public function set calculatorEnabled(param1:Boolean) : void {
      this._calculatorEnabled = param1;
    }

    public function get crystalCost() : Number {
      return this._crystalCost;
    }

    public function set crystalCost(param1:Number) : void {
      this._crystalCost = param1;
    }

    public function get defaultAmountOfCrystals() : int {
      return this._defaultAmountOfCrystals;
    }

    public function set defaultAmountOfCrystals(param1:int) : void {
      this._defaultAmountOfCrystals = param1;
    }

    public function get greaterMaximumCrystalsMessage() : String {
      return this._greaterMaximumCrystalsMessage;
    }

    public function set greaterMaximumCrystalsMessage(param1:String) : void {
      this._greaterMaximumCrystalsMessage = param1;
    }

    public function get greaterMaximumMoneyMessage() : String {
      return this._greaterMaximumMoneyMessage;
    }

    public function set greaterMaximumMoneyMessage(param1:String) : void {
      this._greaterMaximumMoneyMessage = param1;
    }

    public function get lessMinimumCrystalsMessage() : String {
      return this._lessMinimumCrystalsMessage;
    }

    public function set lessMinimumCrystalsMessage(param1:String) : void {
      this._lessMinimumCrystalsMessage = param1;
    }

    public function get lessMinimumMoneyMessage() : String {
      return this._lessMinimumMoneyMessage;
    }

    public function set lessMinimumMoneyMessage(param1:String) : void {
      this._lessMinimumMoneyMessage = param1;
    }

    public function get manualDescription() : String {
      return this._manualDescription;
    }

    public function set manualDescription(param1:String) : void {
      this._manualDescription = param1;
    }

    public function get paymentPackages() : Vector.<PaymentPackage> {
      return this._paymentPackages;
    }

    public function set paymentPackages(param1:Vector.<PaymentPackage>) : void {
      this._paymentPackages = param1;
    }

    public function toString() : String {
      var local1:String = "CrystalsPaymentCC [";
      local1 += "accountId = " + this.accountId + " ";
      local1 += "calculatorEnabled = " + this.calculatorEnabled + " ";
      local1 += "crystalCost = " + this.crystalCost + " ";
      local1 += "defaultAmountOfCrystals = " + this.defaultAmountOfCrystals + " ";
      local1 += "greaterMaximumCrystalsMessage = " + this.greaterMaximumCrystalsMessage + " ";
      local1 += "greaterMaximumMoneyMessage = " + this.greaterMaximumMoneyMessage + " ";
      local1 += "lessMinimumCrystalsMessage = " + this.lessMinimumCrystalsMessage + " ";
      local1 += "lessMinimumMoneyMessage = " + this.lessMinimumMoneyMessage + " ";
      local1 += "manualDescription = " + this.manualDescription + " ";
      local1 += "paymentPackages = " + this.paymentPackages + " ";
      return local1 + "]";
    }
  }
}
