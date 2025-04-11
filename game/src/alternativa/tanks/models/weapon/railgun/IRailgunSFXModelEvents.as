package alternativa.tanks.models.weapon.railgun {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IRailgunSFXModelEvents implements IRailgunSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IRailgunSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : IRailgunEffects {
      var result:IRailgunEffects = null;
      var i:int = 0;
      var m:IRailgunSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IRailgunSFXModel(this.impl[i]);
          result = m.getEffects();
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
