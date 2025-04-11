package alternativa.tanks.model.item.grouped {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IGroupedItemEvents implements IGroupedItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IGroupedItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isGrouped() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IGroupedItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IGroupedItem(this.impl[i]);
          result = Boolean(m.isGrouped());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGroup() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IGroupedItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IGroupedItem(this.impl[i]);
          result = int(m.getGroup());
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
