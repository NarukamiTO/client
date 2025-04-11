package alternativa.tanks.gui.shop.forms {
  import alternativa.tanks.calculators.ExchangeCalculator;
  import alternativa.tanks.gui.payment.controls.PaymentButton;
  import alternativa.tanks.gui.payment.controls.exchange.ExchangeGroup;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.TextFieldAutoSize;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.terminal.TerminalInstance;
  import projects.tanks.client.panel.model.payment.modes.terminal.TerminalPaymentCC;

  public class TerminalForm extends PayModeForm {
    private static const CALCULATOR_LABEL_HEIGHT:int = 50;
    private static const CALCULATOR_LABEL_OFFSET:int = 12;

    private var exchangeGroup:ExchangeGroup;
    private var calculatorLabel:LabelBase = new LabelBase();
    private var exchangeCalculator:ExchangeCalculator = new ExchangeCalculator(1,"RUB",0,50);
    private var terminalButtonsContainer:Sprite;
    private var withCalculator:Boolean;

    public function TerminalForm(param1:IGameObject, param2:TerminalPaymentCC) {
      super(param1);
      this.withCalculator = param2.withCalculator;
      if(this.withCalculator) {
        this.addCalculator(param2.text);
      }
      this.addTerminalLinkButtons(param2.terminals);
    }

    private function addCalculator(param1:String) : void {
      this.calculatorLabel.autoSize = TextFieldAutoSize.NONE;
      this.calculatorLabel.multiline = true;
      this.calculatorLabel.wordWrap = true;
      this.calculatorLabel.htmlText = param1;
      this.calculatorLabel.size = 14;
      addChild(this.calculatorLabel);
      this.exchangeGroup = new ExchangeGroup();
      this.exchangeGroup.hideButtons();
      this.exchangeGroup.setCalculator(this.exchangeCalculator);
      this.exchangeGroup.currency = "руб";
      addChild(this.exchangeGroup);
      this.exchangeGroup.width = int(ShopWindow.WINDOW_WIDTH / 2);
      this.exchangeGroup.x = int(ShopWindow.WINDOW_WIDTH / 2 - this.exchangeGroup.calculatorWidth() / 2) + 200;
      this.calculatorLabel.width = this.exchangeGroup.calculatorWidth();
      this.calculatorLabel.x = this.exchangeGroup.x + (this.exchangeGroup.width - this.calculatorLabel.width) / 2;
      this.calculatorLabel.y = this.exchangeGroup.y + this.exchangeGroup.calculatorHeight() + CALCULATOR_LABEL_OFFSET;
      this.calculatorLabel.height = CALCULATOR_LABEL_HEIGHT;
    }

    private function addTerminalLinkButtons(param1:Vector.<TerminalInstance>) : void {
      var local6:TerminalInstance = null;
      var local7:PaymentButton = null;
      var local8:Boolean = false;
      this.terminalButtonsContainer = new Sprite();
      var local2:int = this.withCalculator ? 3 : 5;
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      for each(local6 in param1) {
        local7 = new PaymentButton(local6.image);
        local7.url = local6.url;
        local8 = local3 % local2 == 0;
        local7.y = local8 ? local3 / local2 * (local7.height + 2) : local4;
        local7.x = local8 ? 0 : local5 + local7.width + 2;
        local7.addEventListener(MouseEvent.CLICK,this.onTerminalSelect);
        this.terminalButtonsContainer.addChild(local7);
        local4 = local7.y;
        local5 = local7.x;
        local3++;
      }
      addChild(this.terminalButtonsContainer);
    }

    private function onTerminalSelect(param1:MouseEvent) : void {
      navigateToURL(new URLRequest(PaymentButton(param1.target).url),"_blank");
    }

    override public function activate() : void {
      if(this.withCalculator) {
        this.exchangeCalculator.init(1,0,50);
        this.exchangeGroup.outputMaxValue = 19999;
        this.exchangeGroup.outputMinValue = 1;
        this.exchangeGroup.resetValue();
      }
    }

    override public function destroy() : void {
      var local1:PaymentButton = null;
      super.destroy();
      for each(local1 in this.terminalButtonsContainer) {
        local1.removeEventListener(MouseEvent.CLICK,this.onTerminalSelect);
      }
    }

    override public function isWithoutChosenItem() : Boolean {
      return true;
    }
  }
}
