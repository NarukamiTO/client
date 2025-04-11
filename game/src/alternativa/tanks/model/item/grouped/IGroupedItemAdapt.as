package alternativa.tanks.model.item.grouped {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IGroupedItemAdapt implements IGroupedItem {
    private var object:IGameObject;
    private var impl:IGroupedItem;

    public function IGroupedItemAdapt(param1:IGameObject, param2:IGroupedItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isGrouped() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isGrouped());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGroup() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getGroup());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
