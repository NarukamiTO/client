package alternativa.tanks.models.effects.effectlevel {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEffectLevelAdapt implements IEffectLevel {
    private var object:IGameObject;
    private var impl:IEffectLevel;

    public function IEffectLevelAdapt(param1:IGameObject, param2:IEffectLevel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffectLevel() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getEffectLevel());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
