package alternativa.tanks.model.item.countable {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ICountableItemAdapt implements ICountableItem {
    private var object:IGameObject;
    private var impl:ICountableItem;

    public function ICountableItemAdapt(param1:IGameObject, param2:ICountableItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getCount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function setCount(param1:int) : void {
      var value:int = param1;
      try {
        Model.object = this.object;
        this.impl.setCount(value);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
