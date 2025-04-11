package alternativa.tanks.service.item {
  import flash.events.Event;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemEvents extends Event {
    public static var OnItemAdded:String = "ItemEvents:OnItemAdded";

    private var item:IGameObject;

    public function ItemEvents(param1:String, param2:IGameObject) {
      super(param1);
      this.item = param2;
    }

    public function getItem() : IGameObject {
      return this.item;
    }
  }
}
