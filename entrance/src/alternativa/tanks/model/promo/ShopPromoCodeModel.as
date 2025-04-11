package alternativa.tanks.model.promo {
  import alternativa.tanks.gui.ThanksForPurchaseWindow;
  import alternativa.tanks.gui.shop.payment.promo.PromoCodeActivateForm;
  import alternativa.tanks.gui.shop.payment.promo.SendPromoCodeEvent;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.promo.ShopPromoCodeButton;
  import alternativa.tanks.model.donationalert.ThanksForDonationFormService;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;
  import projects.tanks.client.panel.model.shop.promo.IShopPromoCodeModelBase;
  import projects.tanks.client.panel.model.shop.promo.ShopPromoCodeModelBase;

  [ModelInfo]
  public class ShopPromoCodeModel extends ShopPromoCodeModelBase implements IShopPromoCodeModelBase, ObjectUnloadListener, ShopPromoCode, ShopItemView {
    [Inject]
    public static var thanksForDonationFormService:ThanksForDonationFormService;

    private var form:PromoCodeActivateForm;

    public function ShopPromoCodeModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new ShopPromoCodeButton(object);
    }

    public function codeActivated(param1:Vector.<GoodInfoData>) : void {
      var local2:ThanksForPurchaseWindow = null;
      this.form.codeActivatedSuccessful();
      if(param1.length > 0) {
        local2 = thanksForDonationFormService.getThanksForPurchaseForm(param1,false);
        local2.addInDialogLayer();
      }
    }

    public function codeIsInvalid() : void {
      this.form.activateFailed();
    }

    public function codeActivationBlocked() : void {
      this.form.activateFailed();
    }

    public function getForm() : PromoCodeActivateForm {
      if(!this.form) {
        this.createForm();
      }
      return this.form;
    }

    private function createForm() : void {
      this.form = new PromoCodeActivateForm();
      this.form.addEventListener(SendPromoCodeEvent.SEND_PROMO_CODE,getFunctionWrapper(this.promoCodeActivationTry));
    }

    private function promoCodeActivationTry(param1:SendPromoCodeEvent) : void {
      server.activatePromoCode(param1.getPromoCode());
    }

    public function objectUnloaded() : void {
      if(Boolean(this.form)) {
        this.form.removeEventListener(SendPromoCodeEvent.SEND_PROMO_CODE,getFunctionWrapper(this.promoCodeActivationTry));
      }
      this.form = null;
    }
  }
}
