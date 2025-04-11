package alternativa.tanks.models.weapon.thunder {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IThunderSFXModelEvents implements IThunderSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IThunderSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : IThunderEffects {
      var result:IThunderEffects = null;
      var i:int = 0;
      var m:IThunderSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IThunderSFXModel(this.impl[i]);
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
