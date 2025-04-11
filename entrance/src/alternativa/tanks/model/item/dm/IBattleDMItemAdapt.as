package alternativa.tanks.model.item.dm {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBattleDMItemAdapt implements IBattleDMItem {
    private var object:IGameObject;
    private var impl:IBattleDMItem;

    public function IBattleDMItemAdapt(param1:IGameObject, param2:IBattleDMItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getUsersCount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getUsersCount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
