package alternativa.tanks.models.tank {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DestroyTankPartAdapt implements DestroyTankPart {
    private var object:IGameObject;
    private var impl:DestroyTankPart;

    public function DestroyTankPartAdapt(param1:IGameObject, param2:DestroyTankPart) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function destroyTankPart() : void {
      try {
        Model.object = this.object;
        this.impl.destroyTankPart();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
