package alternativa.tanks.models.weapon.shared.shot {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IShotModelEvents implements IShotModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IShotModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getReloadMS() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IShotModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShotModel(this.impl[i]);
          result = int(m.getReloadMS());
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
