package alternativa.tanks.models.weapon.thunder {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IThunderSFXModelAdapt implements IThunderSFXModel {
    private var object:IGameObject;
    private var impl:IThunderSFXModel;

    public function IThunderSFXModelAdapt(param1:IGameObject, param2:IThunderSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : IThunderEffects {
      var result:IThunderEffects = null;
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
