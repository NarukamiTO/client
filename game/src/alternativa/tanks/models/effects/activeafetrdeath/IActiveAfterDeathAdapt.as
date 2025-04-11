package alternativa.tanks.models.effects.activeafetrdeath {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IActiveAfterDeathAdapt implements IActiveAfterDeath {
    private var object:IGameObject;
    private var impl:IActiveAfterDeath;

    public function IActiveAfterDeathAdapt(param1:IGameObject, param2:IActiveAfterDeath) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
