package alternativa.tanks.gui.shop.shopitems {
  import alternativa.tanks.gui.shop.components.itemcategoriesview.ItemCategoriesView;
  import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryView;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.types.Long;

  public class GoodsChooseView extends PaymentView {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private var view:ItemCategoriesView;
    private var _width:int;
    private var _height:int;

    public function GoodsChooseView() {
      super();
      this.view = new ItemCategoriesView();
      addChild(this.view);
    }

    public function addShopCategory(param1:Long, param2:String, param3:String) : void {
      var local4:ItemsCategoryView = new ItemsCategoryView(param2,param3,param1);
      this.view.addCategory(local4);
    }

    public function addItem(param1:ShopButton, param2:Long) : void {
      this.view.addItem(param2,param1);
    }

    override public function render(param1:int, param2:int) : void {
      this._width = param1;
      this._height = param2;
      this.view.render(param1,param2);
    }

    override public function postRender() : void {
      this.view.scrollPosition = paymentWindowService.getScrollPosition();
    }

    override public function destroy() : void {
      paymentWindowService.saveScrollPosition(this.view.scrollPosition);
      super.destroy();
      this.view.destroy();
      this.view = null;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }

    public function jumpToCategory(param1:Long) : void {
      this.view.jumpToCategory(param1);
    }
  }
}
