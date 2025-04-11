package alternativa.tanks.gui.shop.payment {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.components.itemcategoriesview.ItemCategoriesView;
  import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryView;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.payment.item.PayModeButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButtonClickDisable;
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemAdditionalDescriptionLabel;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsView;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import alternativa.tanks.model.payment.shop.description.ShopItemAdditionalDescription;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PayModeChooseView extends PaymentView {
    [Inject]
    public static var localeService:ILocaleService;

    private static const COLUMN_COUNT:int = 5;
    private static const COLUMN_SPACING:int = 2;
    private static const PAYMENT_CATEGORY_ID:Long = Long.ZERO;
    private static const PAYMENT_CATEGORY_WITH_DISCOUNT_ID:Long = Long.getLong(0,1);

    private var view:ItemCategoriesView;
    private var selectedItem:IGameObject;
    private var _width:int;
    private var _height:int;

    public function PayModeChooseView(param1:IGameObject) {
      super();
      this.selectedItem = param1;
      this.view = new ItemCategoriesView();
      addChild(this.view);
      this.addSelectedItemView();
    }

    private function addSelectedItemView() : void {
      var local5:ShopItemDetailsView = null;
      var local1:ItemsCategoryView = new ItemsCategoryView(localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_YOUR_CHOICE),"",this.selectedItem.id);
      local1.items.horizontalSpacing = 50;
      var local2:ShopButton = ShopItemView(this.selectedItem.adapt(ShopItemView)).getButtonView();
      var local3:ShopButtonClickDisable = ShopButtonClickDisable(local2);
      local3.disableClick();
      local1.addItem(local2);
      if(this.selectedItem.hasModel(ShopItemDetailsView)) {
        local5 = ShopItemDetailsView(this.selectedItem.adapt(ShopItemDetailsView));
        if(local5.isDetailedViewRequired()) {
          local1.addItem(local5.getDetailsView());
        }
      }
      var local4:String = ShopItemAdditionalDescription(this.selectedItem.adapt(ShopItemAdditionalDescription)).getAdditionalDescription();
      if(Boolean(local4)) {
        local1.addItem(new ShopItemAdditionalDescriptionLabel(local4));
      }
      this.view.addCategory(local1);
    }

    public function addPaymentCategoriesWithDiscountView() : void {
      this.view.addCategory(this.createPaymentCategoriesView(localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_PAYMENT_CATEGORY_WITH_DISCOUNT_HEADER),localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_PAYMENT_CATEGORY_WITH_DISCOUNT_DESCRIPTION),PAYMENT_CATEGORY_WITH_DISCOUNT_ID));
    }

    public function addPaymentCategoriesView() : void {
      this.view.addCategory(this.createPaymentCategoriesView(localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_PAYMENT_CATEGORY_HEADER),localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_PAYMENT_CATEGORY_DESCRIPTION),PAYMENT_CATEGORY_ID));
    }

    public function addPaymentCategoriesViewForOdnoklassniki(param1:Boolean) : void {
      this.view.addCategory(this.createPaymentCategoriesView(localeService.getText(TanksLocale.TEXT_SHOP_PAYMENT_CATEGORY_HEADER_FOR_ODNOKLASSNIKY),localeService.getText(TanksLocale.TEXT_SHOP_PAYMENT_CATEGORY_DESCRIPTION_FOR_ODNOKLASSNIKY),param1 ? PAYMENT_CATEGORY_WITH_DISCOUNT_ID : PAYMENT_CATEGORY_ID));
    }

    private function createPaymentCategoriesView(param1:String, param2:String, param3:Long) : ItemsCategoryView {
      var local4:ItemsCategoryView = new ItemsCategoryView(param1,param2,param3);
      local4.items.columnCount = COLUMN_COUNT;
      local4.items.spacing = COLUMN_SPACING;
      return local4;
    }

    public function addPayMode(param1:IGameObject) : void {
      var local2:Boolean = Boolean(this.selectedItem.hasModel(SpecialKitPackage));
      var local3:PayModeButton = new PayModeButton(param1,local2);
      this.view.addItem(local3.hasDiscount() ? PAYMENT_CATEGORY_WITH_DISCOUNT_ID : PAYMENT_CATEGORY_ID,local3);
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
      this.view = null;
    }
  }
}
