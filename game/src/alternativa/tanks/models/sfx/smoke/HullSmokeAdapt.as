package alternativa.tanks.models.sfx.smoke {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class HullSmokeAdapt implements HullSmoke {
    private var object:IGameObject;
    private var impl:HullSmoke;

    public function HullSmokeAdapt(param1:IGameObject, param2:HullSmoke) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function controlChanged(param1:IGameObject, param2:int) : void {
      var user:IGameObject = param1;
      var controlState:int = param2;
      try {
        Model.object = this.object;
        this.impl.controlChanged(user,controlState);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
