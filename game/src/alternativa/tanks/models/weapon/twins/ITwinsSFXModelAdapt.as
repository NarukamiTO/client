package alternativa.tanks.models.weapon.twins {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITwinsSFXModelAdapt implements ITwinsSFXModel {
    private var object:IGameObject;
    private var impl:ITwinsSFXModel;

    public function ITwinsSFXModelAdapt(param1:IGameObject, param2:ITwinsSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPlasmaWeaponEffects() : TwinsEffects {
      var result:TwinsEffects = null;
      try {
        Model.object = this.object;
        result = this.impl.getPlasmaWeaponEffects();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSFXData() : TwinsSFXData {
      var result:TwinsSFXData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSFXData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
