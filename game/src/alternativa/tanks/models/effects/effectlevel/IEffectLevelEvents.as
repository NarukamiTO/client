package alternativa.tanks.models.effects.effectlevel {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEffectLevelEvents implements IEffectLevel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IEffectLevelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffectLevel() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IEffectLevel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEffectLevel(this.impl[i]);
          result = int(m.getEffectLevel());
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
