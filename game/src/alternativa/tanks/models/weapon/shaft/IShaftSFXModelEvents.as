package alternativa.tanks.models.weapon.shaft {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IShaftSFXModelEvents implements IShaftSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IShaftSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : ShaftEffects {
      var result:ShaftEffects = null;
      var i:int = 0;
      var m:IShaftSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IShaftSFXModel(this.impl[i]);
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
