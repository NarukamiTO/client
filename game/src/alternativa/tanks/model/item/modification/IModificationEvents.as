package alternativa.tanks.model.item.modification {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IModificationEvents implements IModification {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IModificationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBaseItemId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:IModification = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IModification(this.impl[i]);
          result = m.getBaseItemId();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getModificationIndex() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IModification = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IModification(this.impl[i]);
          result = int(m.getModificationIndex());
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
