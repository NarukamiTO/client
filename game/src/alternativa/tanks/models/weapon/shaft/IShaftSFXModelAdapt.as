package alternativa.tanks.models.weapon.shaft {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IShaftSFXModelAdapt implements IShaftSFXModel {
    private var object:IGameObject;
    private var impl:IShaftSFXModel;

    public function IShaftSFXModelAdapt(param1:IGameObject, param2:IShaftSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : ShaftEffects {
      var result:ShaftEffects = null;
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
