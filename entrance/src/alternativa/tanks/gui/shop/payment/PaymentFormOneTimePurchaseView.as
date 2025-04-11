package alternativa.tanks.gui.shop.payment {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.components.itemcategoriesview.ItemCategoriesView;
  import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryView;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.forms.ApproveOneTimePurchaseForm;
  import alternativa.tanks.gui.shop.paymentform.item.PaymentFormItemBase;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButtonClickDisable;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButtonDiscount;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import alternativa.tanks.model.payment.shop.indemnity.Indemnity;
  import alternativa.tanks.model.payment.shop.quantityrestriction.QuantityRestriction;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PaymentFormOneTimePurchaseView extends PaymentView {
    [Inject]
    public static var localeService:ILocaleService;

    private static const PAYMENT_MODE_ID:Long = Long.ZERO;

    private var view:ItemCategoriesView;
    private var selectedItem:IGameObject;
    private var chosenPayMode:IGameObject;
    private var _width:int;
    private var _height:int;

    public function PaymentFormOneTimePurchaseView(param1:IGameObject, param2:IGameObject) {
      super();
      this.selectedItem = param1;
      this.chosenPayMode = param2;
      this.view = new ItemCategoriesView();
      addChild(this.view);
      this.addSelectedItemView();
      this.addPaymentCategory();
      this.addApproveForm();
    }

    private function addSelectedItemView() : void {
      var local1:ItemsCategoryView = new ItemsCategoryView(localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_YOUR_CHOICE),"",this.selectedItem.id);
      var local2:ShopButton = ShopItemView(this.selectedItem.adapt(ShopItemView)).getButtonView();
      ShopButtonClickDisable(local2).disableClick();
      ShopButtonDiscount(local2).applyPayModeDiscountAndUpdatePriceLabel(this.chosenPayMode);
      local1.addItem(local2);
      this.view.addCategory(local1);
    }

    private function addPaymentCategory() : void {
      var local1:ItemsCategoryView = new ItemsCategoryView(localeService.getText(TanksLocale.TEXT_SHOP_ONE_TIME_PURCHASE_CONDITIONS_HEADER),"",PAYMENT_MODE_ID);
      this.view.addCategory(local1);
    }

    private function addApproveForm() : void {
      var local1:String = !!this.selectedItem.hasModel(QuantityRestriction) ? localeService.getText(TanksLocale.TEXT_SHOP_ONE_TIME_PURCHASE_CONDITIONS_DESCRIPTION_WITH_LIMIT) : localeService.getText(TanksLocale.TEXT_SHOP_ONE_TIME_PURCHASE_CONDITIONS_DESCRIPTION);
      var local2:ApproveOneTimePurchaseForm = new ApproveOneTimePurchaseForm(this.chosenPayMode,Indemnity(this.selectedItem.adapt(Indemnity)).getIndemnitySize(),local1);
      this.view.addItem(PAYMENT_MODE_ID,new PaymentFormItemBase(local2));
      local2.activate();
    }

    override public function render(param1:int, param2:int) : void {
      this._width = param1;
      this._height = param2;
      this.view.render(param1,param2);
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function destroy() : void {
      super.destroy();
      this.view.destroy();
      this.selectedItem = null;
      this.chosenPayMode = null;
      this.view = null;
    }
  }
}
