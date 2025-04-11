package alternativa.tanks.models.inventory {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IInventoryModelAdapt implements IInventoryModel {
    private var object:IGameObject;
    private var impl:IInventoryModel;

    public function IInventoryModelAdapt(param1:IGameObject, param2:IInventoryModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function lockItem(param1:int, param2:int, param3:Boolean) : void {
      var itemType:int = param1;
      var lockMask:int = param2;
      var lock:Boolean = param3;
      try {
        Model.object = this.object;
        this.impl.lockItem(itemType,lockMask,lock);
      }
      finally {
        Model.popObject();
      }
    }

    public function lockItems(param1:int, param2:Boolean) : void {
      var lockMask:int = param1;
      var lock:Boolean = param2;
      try {
        Model.object = this.object;
        this.impl.lockItems(lockMask,lock);
      }
      finally {
        Model.popObject();
      }
    }

    public function lockItemsByMask(param1:Vector.<int>, param2:int, param3:Boolean) : void {
      var affectedSlots:Vector.<int> = param1;
      var lockMask:int = param2;
      var lock:Boolean = param3;
      try {
        Model.object = this.object;
        this.impl.lockItemsByMask(affectedSlots,lockMask,lock);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
