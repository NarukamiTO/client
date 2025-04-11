package alternativa.tanks.gui.shop.forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.controls.ProceedButton;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.payment.event.ApproveFormEvent;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import assets.Diamond;
  import controls.base.LabelBase;
  import controls.checkbox.CheckBoxEvent;
  import controls.checkbox.MultilineCheckBox;
  import controls.labels.MouseDisabledLabel;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ApproveOneTimePurchaseForm extends PayModeForm {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PROCEED_BUTTON_WIDTH:int = 100;
    private static const WIDTH:int = 550;
    private static const GAP_BETWEEN_ELEMENTS:int = 10;

    private var warningLabel:LabelBase;
    private var idemnityLabel:MouseDisabledLabel;
    private var checkBox:MultilineCheckBox;
    private var proceedButton:ProceedButton;

    public function ApproveOneTimePurchaseForm(param1:IGameObject, param2:int, param3:String) {
      super(param1);
      this.addWarningLabel(param3);
      this.addIdemnityLabel(param2);
      this.addApprovingCheckBox();
      this.addProceedButton();
    }

    private function addWarningLabel(param1:String) : void {
      this.warningLabel = new LabelBase();
      this.warningLabel.htmlText = param1;
      this.warningLabel.x = -7;
      this.warningLabel.y = -11;
      this.warningLabel.multiline = true;
      this.warningLabel.wordWrap = true;
      this.warningLabel.width = WIDTH;
      this.warningLabel.size = 12;
      addChild(this.warningLabel);
    }

    private function addIdemnityLabel(param1:int) : void {
      this.idemnityLabel = new MouseDisabledLabel();
      this.idemnityLabel.y = this.warningLabel.y + this.warningLabel.textHeight + GAP_BETWEEN_ELEMENTS;
      this.idemnityLabel.x = this.warningLabel.x;
      this.idemnityLabel.text = localeService.getText(TanksLocale.TEXT_SHOP_ONE_TIME_PURCHASE_CONDITIONS_COMPENSATION) + "      " + FormatUtils.valueToString(param1,0,false);
      addChild(this.idemnityLabel);
      var local2:Diamond = new Diamond();
      local2.y = this.idemnityLabel.y + 3;
      local2.x = this.idemnityLabel.x + this.idemnityLabel.textWidth + 5;
      addChild(local2);
    }

    private function addApprovingCheckBox() : void {
      this.checkBox = new MultilineCheckBox();
      this.checkBox.labelWidth = WIDTH;
      this.checkBox.label = localeService.getText(TanksLocale.TEXT_SHOP_ONE_TIME_PURCHASE_CONDITIONS_AGREEMENT);
      this.checkBox.verticalLabelCorrectionBy(5);
      this.checkBox.y = this.idemnityLabel.y + this.idemnityLabel.textHeight + GAP_BETWEEN_ELEMENTS;
      this.checkBox.x = this.idemnityLabel.x;
      this.checkBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.checkBoxStateChanged);
      addChild(this.checkBox);
    }

    private function checkBoxStateChanged(param1:CheckBoxEvent) : void {
      this.proceedButton.enable = this.checkBox.checked;
    }

    private function addProceedButton() : void {
      this.proceedButton = new ProceedButton();
      this.proceedButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_PROCEED_TEXT);
      this.proceedButton.addEventListener(MouseEvent.CLICK,this.onProceedClick);
      this.proceedButton.width = PROCEED_BUTTON_WIDTH;
      this.proceedButton.enable = false;
      this.proceedButton.y = this.checkBox.y + this.checkBox.height + (GAP_BETWEEN_ELEMENTS >> 1);
      this.proceedButton.x = this.width - this.proceedButton.width >> 1;
      addChild(this.proceedButton);
    }

    private function onProceedClick(param1:MouseEvent) : void {
      dispatchEvent(new ApproveFormEvent());
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override public function get height() : Number {
      return this.proceedButton.y + this.proceedButton.height - 7;
    }
  }
}
