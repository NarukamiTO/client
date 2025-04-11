package alternativa.tanks.models.weapon.shared.shot {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IShotModelAdapt implements IShotModel {
    private var object:IGameObject;
    private var impl:IShotModel;

    public function IShotModelAdapt(param1:IGameObject, param2:IShotModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getReloadMS() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getReloadMS());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
