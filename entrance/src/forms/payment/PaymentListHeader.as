package forms.payment {
  import alternativa.osgi.service.locale.ILocaleService;
  import assets.Diamond;
  import controls.statassets.StatHeaderButton;
  import flash.display.Sprite;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PaymentListHeader extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static var _withSMSText:Boolean = false;

    private var number:StatHeaderButton = new StatHeaderButton();
    private var smsText:StatHeaderButton = new StatHeaderButton(false);
    private var cost:StatHeaderButton = new StatHeaderButton();
    private var crystals:StatHeaderButton = new StatHeaderButton();
    private var cr:Diamond = new Diamond();

    protected var _width:int = 800;

    public function PaymentListHeader() {
      super();
      this.number.height = this.cost.height = this.smsText.height = this.crystals.height = 18;
      this.number.label = localeService.getText(TanksLocale.TEXT_PAYMENT_SMSNUMBERS_NUMBER_HEADER_LABEL_TEXT);
      this.smsText.label = localeService.getText(TanksLocale.TEXT_PAYMENT_SMSNUMBERS_SMSTEXT_HEADER_LABEL_TEXT);
      this.cost.label = localeService.getText(TanksLocale.TEXT_PAYMENT_SMSNUMBERS_COST_HEADER_LABEL_TEXT);
      addChild(this.number);
      addChild(this.smsText);
      this.smsText.visible = _withSMSText;
      addChild(this.cost);
      addChild(this.crystals);
      addChild(this.cr);
      this.number.width = 70;
      this.cost.x = 72;
      this.cr.y = 5;
      this.draw();
    }

    public function set withSMSText(param1:Boolean) : void {
      _withSMSText = param1;
      this.draw();
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.draw();
    }

    private function draw() : void {
      var local1:int = _withSMSText ? 80 : int((this._width - 70) / 2);
      this.smsText.visible = _withSMSText;
      this.cost.x = 72;
      if(_withSMSText) {
        this.smsText.x = 72;
        this.smsText.width = this._width - 210;
        this.cost.x = 72 + this.smsText.width + 2;
      }
      this.cost.width = local1;
      this.crystals.x = this.cost.x + this.cost.width + 2;
      this.crystals.width = int(this._width - this.crystals.x - 3);
      this.cr.x = this.crystals.x + this.crystals.width - this.cr.width - 3;
    }
  }
}
