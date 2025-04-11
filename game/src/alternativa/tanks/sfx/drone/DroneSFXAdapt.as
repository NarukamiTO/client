package alternativa.tanks.sfx.drone {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DroneSFXAdapt implements DroneSFX {
    private var object:IGameObject;
    private var impl:DroneSFX;

    public function DroneSFXAdapt(param1:IGameObject, param2:DroneSFX) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : DroneSFXData {
      var result:DroneSFXData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSfxData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
