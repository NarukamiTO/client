package alternativa.tanks.gui.payment.controls.exchange {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.calculators.IExchangeCalculator;
  import alternativa.tanks.gui.icons.CrystalIcon;
  import alternativa.tanks.gui.payment.controls.*;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.payment.IPaymentService;
  import base.DiscreteSprite;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.numeric.NumericEditor;
  import controls.numeric.NumericEditorEvent;
  import controls.numeric.NumericStepper;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.text.TextFieldAutoSize;
  import mx.utils.StringUtil;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;

  public class ExchangeGroup extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var helperService:IHelpService;

    private static const BUTTON_BIG_WIDTH:int = 174;
    private static const BUTTON_SMALL_WIDTH:int = 100;
    private static const MIN_BIG_LOD_WIDTH:int = 380;
    private static const OUTPUT_BIG_WIDTH:Number = 174;
    private static const OUTPUT_SMALL_WIDTH:Number = 207;
    private static const INPUT_BIG_WIDTH:Number = 89;
    private static const INPUT_SMALL_WIDTH:Number = 157;
    private static const SPACE_MODULE:int = 7;
    private static const bitmapExchange:Class = ExchangeGroup_bitmapExchange;
    private static const exchangeBd:BitmapData = new bitmapExchange().bitmapData;

    protected var input:NumericStepper;
    protected var output:NumericEditor;

    private var crystalIcon:Bitmap;
    private var exchangeIcon:Bitmap;

    private const spaceModule:int = 3;

    protected var _currency:String;
    protected var currencyTF:LabelBase = new LabelBase();
    protected var calculator:IExchangeCalculator;

    private var isMessagesSet:Boolean = false;
    private var valid:Boolean = true;
    private var bonusInfo:BonusLabel;
    private var premiumInfo:PremiumLabel;

    protected var proceedButton:ProceedButton;
    protected var backButton:DefaultButtonBase;

    private var calculatorContainer:Sprite;
    private var buttonsContainer:Sprite;
    private var _width:int;
    private var _buttonsOffset:int;
    private var _packagesEnabled:Boolean = true;
    private var _backButtonVisible:Boolean;
    private var _round:int;

    public function ExchangeGroup(param1:Boolean = false, param2:Boolean = true) {
      super();
      this._backButtonVisible = param2;
      this.buttonsContainer = new DiscreteSprite();
      addChild(this.buttonsContainer);
      this.calculatorContainer = new DiscreteSprite();
      addChild(this.calculatorContainer);
      this.backButton = this.createBackButton();
      this.buttonsContainer.addChild(this.backButton);
      this.backButton.visible = this._backButtonVisible;
      this.proceedButton = this.createProceedButton();
      this.buttonsContainer.addChild(this.proceedButton);
      this._currency = "";
      this.input = new NumericStepper(param1);
      this.input.setStep(10);
      this.calculatorContainer.addChild(this.input);
      this.crystalIcon = CrystalIcon.createInstance();
      this.calculatorContainer.addChild(this.crystalIcon);
      this.exchangeIcon = new Bitmap(exchangeBd);
      this.calculatorContainer.addChild(this.exchangeIcon);
      this.output = new NumericEditor(param1);
      this.output.setPrecision(2);
      this.calculatorContainer.addChild(this.output);
      this.input.addEventListener(NumericEditorEvent.CHANGE,this.onInputChange);
      this.output.addEventListener(NumericEditorEvent.CHANGE,this.onOutputChange);
      this.currencyTF.autoSize = TextFieldAutoSize.LEFT;
      this.output.addChild(this.currencyTF);
      this.bonusInfo = new BonusLabel();
      this.calculatorContainer.addChild(this.bonusInfo);
      this.premiumInfo = new PremiumLabel();
      this.calculatorContainer.addChild(this.premiumInfo);
    }

    protected function createProceedButton() : ProceedButton {
      var local1:ProceedButton = new ProceedButton();
      local1.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      local1.enable = false;
      local1.addEventListener(MouseEvent.CLICK,this.onProceedButtonClick);
      return local1;
    }

    protected function createBackButton() : DefaultButtonBase {
      var local1:DefaultButtonBase = new DefaultButtonBase();
      local1.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_BACK_TEXT);
      local1.addEventListener(MouseEvent.CLICK,this.onReturnButtonClick);
      return local1;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.selectLOD();
      this.calculatorContainer.x = (this._width - this.calculatorContainer.width) * 0.5;
      this.buttonsContainer.x = this.calculatorContainer.x;
    }

    protected function selectLOD() : void {
      var local1:Number = NaN;
      this.currencyTF.x = 0;
      if(this._width >= MIN_BIG_LOD_WIDTH) {
        this.input.setWidth(INPUT_BIG_WIDTH);
        local1 = this.bonusInfo.visible ? OUTPUT_BIG_WIDTH - this.bonusInfo.width - SPACE_MODULE - this.spaceModule : OUTPUT_BIG_WIDTH;
        this.output.setWidth(local1);
        this.proceedButton.width = BUTTON_BIG_WIDTH;
        this.backButton.width = BUTTON_BIG_WIDTH;
        this.crystalIcon.x = this.input.width + this.spaceModule;
        this.exchangeIcon.rotation = 0;
        this.exchangeIcon.y = (this.output.height - this.exchangeIcon.height) * 0.5;
        this.exchangeIcon.x = this.crystalIcon.x + this.crystalIcon.width + this.spaceModule * 2;
        this.output.x = this.exchangeIcon.x + this.exchangeIcon.width + this.spaceModule * 2;
        this.output.y = 0;
      } else {
        this.input.setWidth(INPUT_SMALL_WIDTH);
        local1 = this.bonusInfo.visible ? OUTPUT_SMALL_WIDTH - this.bonusInfo.width - SPACE_MODULE - this.spaceModule : OUTPUT_SMALL_WIDTH;
        this.output.setWidth(local1);
        this.proceedButton.width = BUTTON_SMALL_WIDTH;
        this.backButton.width = BUTTON_SMALL_WIDTH;
        this.crystalIcon.x = this.input.width + this.spaceModule;
        this.exchangeIcon.rotation = 90;
        this.exchangeIcon.x = (this.crystalIcon.x + this.crystalIcon.width - this.exchangeIcon.width) * 0.5;
        this.exchangeIcon.y = this.input.height + this.spaceModule;
        this.output.x = 0;
        this.output.y = this.exchangeIcon.y + this.exchangeIcon.height + this.spaceModule;
      }
      this.proceedButton.x = this.backButton.width + SPACE_MODULE;
      this.bonusInfo.x = this.output.x + this.output.width;
      this.bonusInfo.y = this.output.y - this.spaceModule;
      this.premiumInfo.x = this.bonusInfo.x + this.bonusInfo.width;
      this.premiumInfo.y = this.output.y + (this.output.height - this.premiumInfo.height >> 1);
      this.output.tf.textField.width = int(this.output.width - this.currencyTF.width - 16) - this.spaceModule;
      this.currencyTF.x = int(this.output.width - this.currencyTF.width - 14) - this.spaceModule;
      this.currencyTF.y = SPACE_MODULE;
      this.alignButtonsContainer();
    }

    protected function alignButtonsContainer() : void {
      this.buttonsContainer.y = this.calculatorContainer.height + 18 + this._buttonsOffset;
    }

    protected function onProceedButtonClick(param1:MouseEvent) : void {
      stage.focus = this.proceedButton;
      dispatchEvent(new ExchangeGroupEvent(ExchangeGroupEvent.PROCEED));
    }

    private function onReturnButtonClick(param1:MouseEvent) : void {
      dispatchEvent(new ExchangeGroupEvent(ExchangeGroupEvent.RETURN));
    }

    public function setCalculator(param1:IExchangeCalculator) : void {
      this.calculator = param1;
    }

    public function recalculateBonus() : void {
      this.bonus = this.calculator.calculateBonus(this.output.getValue());
    }

    public function get inputValue() : int {
      return this.input.intValue;
    }

    public function getCrystalsWithoutPackets(param1:Number) : int {
      return this.calculator.calculateCrystalsWithoutPackets(param1);
    }

    public function set inputValue(param1:int) : void {
      if(this.input.intValue != param1) {
        this.input.setValue(param1);
        this.outputValue = this.calculator.calculateUsingPaymentPackages(this.input.intValue);
        this.bonus = this.calculator.calculateBonus(this.output.getValue());
        this.premiumDuration = this.calculator.calculatePremiumDuration(this.output.getValue());
      }
    }

    public function set outputMinValue(param1:Number) : void {
      this.output.setMinValue(param1);
      this.input.setMinValue(this.calculator.calculateCrystalsWithoutPackets(param1));
    }

    public function set outputMaxValue(param1:Number) : void {
      this.output.setMaxValue(param1);
      var local2:int = int(this.calculator.calculateCrystalsWithoutPackets(param1));
      this.input.setMaxValue(local2);
      this.input.setMaxChars(local2.toString().length);
    }

    public function get outputValue() : Number {
      return this.output.getValue();
    }

    public function set outputValue(param1:Number) : void {
      if(this._round == 0) {
        param1 = Math.ceil(param1);
      }
      if(this.output.getValue() != param1) {
        this.output.setValue(param1,false);
      }
    }

    public function get currency() : String {
      return this._currency;
    }

    public function set currency(param1:String) : void {
      this._currency = param1;
      this.currencyTF.text = this._currency;
    }

    public function set round(param1:int) : void {
      this._round = param1;
      this.output.setPrecision(param1);
    }

    protected function set bonus(param1:int) : void {
      if(param1 > 0) {
        this.bonusInfo.setCrystals(param1);
      }
      this.bonusInfo.visible = param1 > 0 && this._packagesEnabled;
      this.selectLOD();
    }

    protected function set premiumDuration(param1:int) : void {
      if(param1 > 0) {
        this.premiumInfo.setPremiumDuration(param1);
      }
      this.premiumInfo.visible = param1 > 0 && this._packagesEnabled;
      this.selectLOD();
    }

    protected function onInputChange(param1:NumericEditorEvent) : void {
      if(param1.isChangedByUser() && param1.isValid()) {
        this.outputValue = this.calculator.calculate(this.input.intValue);
        this.bonus = this.calculator.calculateBonus(this.output.getValue());
        this.premiumDuration = this.calculator.calculatePremiumDuration(this.output.getValue());
        paymentService.setCrystals(this.input.intValue);
      }
      this.setValid(param1.isValid());
    }

    protected function onOutputChange(param1:NumericEditorEvent) : void {
      if(param1.isChangedByUser() && param1.isValid()) {
        this.input.setValue(this.calculator.calculateInverse(this.output.getValue()));
        this.bonus = this.calculator.calculateBonus(this.output.getValue());
        this.premiumDuration = this.calculator.calculatePremiumDuration(this.output.getValue());
        paymentService.setCrystals(this.input.intValue);
      }
      this.setValid(param1.isValid());
    }

    protected function setValid(param1:Boolean) : void {
      this.valid = param1;
      this.proceedEnable = param1;
    }

    public function resetValue() : void {
      this.inputValue = paymentService.getCrystals();
      this.outputValue = this.calculator.calculate(this.inputValue);
      this.input.selectAllIfFocused();
      this.output.selectAllIfFocused();
      this.valid = true;
      if(!this.isMessagesSet) {
        this.isMessagesSet = true;
        this.input.setGreaterMaximumMessage(paymentService.getGreaterMaximumCrystalsMessage());
        this.input.setLessMinimumMessage(paymentService.getLessMinimumCrystalsMessage());
      }
      var local1:String = paymentService.getGreaterMaximumMoneyMessage();
      if(local1 != null) {
        this.output.setGreaterMaximumMessage(StringUtil.substitute(local1,"{0}",this.currency));
      }
      var local2:String = paymentService.getLessMinimumMoneyMessage();
      if(local2 != null) {
        this.output.setLessMinimumMessage(StringUtil.substitute(local2,"{0}",this.currency));
      }
    }

    public function isValid() : Boolean {
      return this.valid;
    }

    public function get proceedEnable() : Boolean {
      return this.proceedButton.enable;
    }

    public function set proceedEnable(param1:Boolean) : void {
      this.proceedButton.enable = param1;
    }

    public function get buttonsOffset() : int {
      return this._buttonsOffset;
    }

    public function set buttonsOffset(param1:int) : void {
      if(this._buttonsOffset != param1) {
        this._buttonsOffset = param1;
        this.alignButtonsContainer();
      }
    }

    public function get packagesEnabled() : Boolean {
      return this._packagesEnabled;
    }

    public function set packagesEnabled(param1:Boolean) : void {
      this._packagesEnabled = param1;
      this.backButton.visible = param1 && this._backButtonVisible;
      this.bonusInfo.visible = param1;
      this.premiumInfo.visible = param1;
    }

    public function calculatorWidth() : int {
      return this.calculatorContainer.width;
    }

    public function calculatorHeight() : int {
      return this.calculatorContainer.height;
    }

    public function hideButtons() : void {
      this.buttonsContainer.visible = false;
    }

    public function alignHelper() : Boolean {
      if(this.proceedEnable && parent != null && this.proceedButton.visible) {
        achievementService.setPaymentResumeButtonTargetPoint(this.proceedButton.localToGlobal(new Point(5,29)));
        return true;
      }
      return false;
    }
  }
}
