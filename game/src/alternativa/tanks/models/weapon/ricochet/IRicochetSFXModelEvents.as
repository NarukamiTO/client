package alternativa.tanks.models.weapon.ricochet {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IRicochetSFXModelEvents implements IRicochetSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IRicochetSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : RicochetSFXData {
      var result:RicochetSFXData = null;
      var i:int = 0;
      var m:IRicochetSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IRicochetSFXModel(this.impl[i]);
          result = m.getSfxData();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getRicochetEffects() : RicochetEffects {
      var result:RicochetEffects = null;
      var i:int = 0;
      var m:IRicochetSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IRicochetSFXModel(this.impl[i]);
          result = m.getRicochetEffects();
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
