package alternativa.tanks.models.weapon.ricochet {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IRicochetSFXModelAdapt implements IRicochetSFXModel {
    private var object:IGameObject;
    private var impl:IRicochetSFXModel;

    public function IRicochetSFXModelAdapt(param1:IGameObject, param2:IRicochetSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : RicochetSFXData {
      var result:RicochetSFXData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSfxData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getRicochetEffects() : RicochetEffects {
      var result:RicochetEffects = null;
      try {
        Model.object = this.object;
        result = this.impl.getRicochetEffects();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
