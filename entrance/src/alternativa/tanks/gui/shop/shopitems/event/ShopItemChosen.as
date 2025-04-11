package alternativa.tanks.gui.shop.shopitems.event {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class ShopItemChosen extends Event {
    public static const EVENT_TYPE:String = "ShopItemChosenEVENT";

    public var item:IGameObject;

    public function ShopItemChosen(param1:IGameObject) {
      super(EVENT_TYPE,true);
      this.item = param1;
    }
  }
}
