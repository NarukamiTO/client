package alternativa.tanks.model.item.modification {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IModificationAdapt implements IModification {
    private var object:IGameObject;
    private var impl:IModification;

    public function IModificationAdapt(param1:IGameObject, param2:IModification) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBaseItemId() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getBaseItemId();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getModificationIndex() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getModificationIndex());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
