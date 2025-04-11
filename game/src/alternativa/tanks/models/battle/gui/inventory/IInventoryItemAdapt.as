package alternativa.tanks.models.battle.gui.inventory {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IInventoryItemAdapt implements IInventoryItem {
    private var object:IGameObject;
    private var impl:IInventoryItem;

    public function IInventoryItemAdapt(param1:IGameObject, param2:IInventoryItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSlotIndex() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getSlotIndex());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
