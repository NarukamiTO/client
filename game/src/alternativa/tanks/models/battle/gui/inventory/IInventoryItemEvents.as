package alternativa.tanks.models.battle.gui.inventory {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IInventoryItemEvents implements IInventoryItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IInventoryItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSlotIndex() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IInventoryItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IInventoryItem(this.impl[i]);
          result = int(m.getSlotIndex());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
