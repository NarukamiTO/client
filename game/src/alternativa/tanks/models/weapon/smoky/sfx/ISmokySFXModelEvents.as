package alternativa.tanks.models.weapon.smoky.sfx {
  import alternativa.tanks.models.weapon.smoky.ISmokyEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ISmokySFXModelEvents implements ISmokySFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ISmokySFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : ISmokyEffects {
      var result:ISmokyEffects = null;
      var i:int = 0;
      var m:ISmokySFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ISmokySFXModel(this.impl[i]);
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
