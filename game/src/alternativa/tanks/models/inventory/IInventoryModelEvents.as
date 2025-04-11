package alternativa.tanks.models.inventory {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IInventoryModelEvents implements IInventoryModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IInventoryModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function lockItem(param1:int, param2:int, param3:Boolean) : void {
      var i:int = 0;
      var m:IInventoryModel = null;
      var itemType:int = param1;
      var lockMask:int = param2;
      var lock:Boolean = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IInventoryModel(this.impl[i]);
          m.lockItem(itemType,lockMask,lock);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function lockItems(param1:int, param2:Boolean) : void {
      var i:int = 0;
      var m:IInventoryModel = null;
      var lockMask:int = param1;
      var lock:Boolean = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IInventoryModel(this.impl[i]);
          m.lockItems(lockMask,lock);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function lockItemsByMask(param1:Vector.<int>, param2:int, param3:Boolean) : void {
      var i:int = 0;
      var m:IInventoryModel = null;
      var affectedSlots:Vector.<int> = param1;
      var lockMask:int = param2;
      var lock:Boolean = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IInventoryModel(this.impl[i]);
          m.lockItemsByMask(affectedSlots,lockMask,lock);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
