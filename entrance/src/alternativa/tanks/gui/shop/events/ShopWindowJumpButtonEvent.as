package alternativa.tanks.gui.shop.events {
  import alternativa.types.Long;
  import flash.events.Event;

  public class ShopWindowJumpButtonEvent extends Event {
    public static const CLICK:String = "ShopWindowJumpButtonClickEvent";

    private var _categoryId:Long;

    public function ShopWindowJumpButtonEvent(param1:String, param2:Long) {
      super(param1,true);
      this._categoryId = param2;
    }

    public function get categoryId() : Long {
      return this._categoryId;
    }
  }
}
