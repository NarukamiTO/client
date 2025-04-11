package alternativa.tanks.gui.shop.components.window {
  import alternativa.tanks.gui.shop.indicators.ShopIndicators;
  import alternativa.types.Long;
  import controls.base.DefaultButtonBase;
  import flash.display.Bitmap;

  public class ShopWindowJumpButton extends DefaultButtonBase {
    private var _categoryId:Long;
    private var _activeDiscounts:Boolean;

    public function ShopWindowJumpButton(param1:Long, param2:String) {
      super();
      this._categoryId = param1;
      label = param2;
    }

    public function get categoryId() : Long {
      return this._categoryId;
    }

    public function get activeDiscounts() : Boolean {
      return this._activeDiscounts;
    }

    public function activateDiscountsIcon() : void {
      var local1:Bitmap = new Bitmap(ShopIndicators.discounts);
      local1.y = -5;
      local1.x = width - int(local1.width / 2) - 2;
      addChild(local1);
      this._activeDiscounts = true;
    }
  }
}
