package alternativa.tanks.gui.shop.payment {
  import alternativa.tanks.gui.payment.events.SMSformEvent;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.payment.forms.commons.DescriptionBlock;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.forms.SMSForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import platform.client.fp10.core.type.IGameObject;

  public class PaymentFormWithoutChosenItemView extends PaymentView {
    private static const MAX_INNER_WINDOW_HEIGHT:int = 160;
    private static const MIN_INNER_WINDOW_HEIGHT:int = 70;

    private var chosenPayMode:IGameObject;
    private var descriptionBlock:DescriptionBlock;
    private var view:PayModeForm;
    private var previousHeight:int;

    public function PaymentFormWithoutChosenItemView(param1:IGameObject) {
      super();
      this.chosenPayMode = param1;
      this.descriptionBlock = new DescriptionBlock(param1,MAX_INNER_WINDOW_HEIGHT);
      addChild(this.descriptionBlock);
      this.view = PayModeView(param1.adapt(PayModeView)).getView();
      this.view.y = this.descriptionBlock.getHeight();
      this.view.addEventListener(SMSformEvent.SELECT_COUNTRY,this.onSMSformCountrySelected);
      addChild(this.view);
      this.previousHeight = this.view.getMinHeight();
    }

    override public function render(param1:int, param2:int) : void {
      super.render(param1,param2);
      var local3:int = this.previousHeight - param2;
      var local4:int = this.descriptionBlock.getInnerWindowHeight();
      if(param2 < this.view.getMinHeight() && local4 > MIN_INNER_WINDOW_HEIGHT && local3 > 0) {
        this.updateView(Math.max(local4 - local3,MIN_INNER_WINDOW_HEIGHT));
      } else if(local3 < 0 && local4 < MAX_INNER_WINDOW_HEIGHT) {
        this.updateView(Math.min(local4 - local3,MAX_INNER_WINDOW_HEIGHT));
      }
      this.previousHeight = param2;
      if(this.view is SMSForm) {
        SMSForm(this.view).resize(param1,param2 - this.descriptionBlock.getHeight());
      }
    }

    private function updateView(param1:int) : void {
      this.descriptionBlock.updateHeight(param1);
      this.view.y = this.descriptionBlock.getHeight();
    }

    private function onSMSformCountrySelected(param1:SMSformEvent) : void {
      this.descriptionBlock.updateDescription();
    }
  }
}
