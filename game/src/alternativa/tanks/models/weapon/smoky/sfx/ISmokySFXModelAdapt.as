package alternativa.tanks.models.weapon.smoky.sfx {
  import alternativa.tanks.models.weapon.smoky.ISmokyEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ISmokySFXModelAdapt implements ISmokySFXModel {
    private var object:IGameObject;
    private var impl:ISmokySFXModel;

    public function ISmokySFXModelAdapt(param1:IGameObject, param2:ISmokySFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : ISmokyEffects {
      var result:ISmokyEffects = null;
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
