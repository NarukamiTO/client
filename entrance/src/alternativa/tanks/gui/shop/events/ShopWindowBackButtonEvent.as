package alternativa.tanks.gui.shop.events {
  import flash.events.Event;

  public class ShopWindowBackButtonEvent extends Event {
    public static const CLICK:String = "ShopWindowBackButtonClickEvent";

    public function ShopWindowBackButtonEvent(param1:String) {
      super(param1,true);
    }
  }
}
