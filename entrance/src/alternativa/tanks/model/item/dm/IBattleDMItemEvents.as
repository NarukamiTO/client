package alternativa.tanks.model.item.dm {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBattleDMItemEvents implements IBattleDMItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBattleDMItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getUsersCount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IBattleDMItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleDMItem(this.impl[i]);
          result = int(m.getUsersCount());
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
