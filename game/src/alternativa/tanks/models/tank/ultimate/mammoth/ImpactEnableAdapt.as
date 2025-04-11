package alternativa.tanks.models.tank.ultimate.mammoth {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ImpactEnableAdapt implements ImpactEnable {
    private var object:IGameObject;
    private var impl:ImpactEnable;

    public function ImpactEnableAdapt(param1:IGameObject, param2:ImpactEnable) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isImpactEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isImpactEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
