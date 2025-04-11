package alternativa.tanks.models.weapon.railgun {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IRailgunSFXModelAdapt implements IRailgunSFXModel {
    private var object:IGameObject;
    private var impl:IRailgunSFXModel;

    public function IRailgunSFXModelAdapt(param1:IGameObject, param2:IRailgunSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : IRailgunEffects {
      var result:IRailgunEffects = null;
      try {
        Model.object = this.object;
        result = this.impl.getEffects();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
