package alternativa.tanks.models.teamlight {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IModeLightAdapt implements IModeLight {
    private var object:IGameObject;
    private var impl:IModeLight;

    public function IModeLightAdapt(param1:IGameObject, param2:IModeLight) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getControlPointsMode() : ModeLight {
      var result:ModeLight = null;
      try {
        Model.object = this.object;
        result = this.impl.getControlPointsMode();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCaptureFlagMode() : ModeLight {
      var result:ModeLight = null;
      try {
        Model.object = this.object;
        result = this.impl.getCaptureFlagMode();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
