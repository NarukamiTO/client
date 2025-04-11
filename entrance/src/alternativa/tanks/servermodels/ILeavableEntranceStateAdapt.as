package alternativa.tanks.servermodels {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILeavableEntranceStateAdapt implements ILeavableEntranceState {
    private var object:IGameObject;
    private var impl:ILeavableEntranceState;

    public function ILeavableEntranceStateAdapt(param1:IGameObject, param2:ILeavableEntranceState) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function leave() : void {
      try {
        Model.object = this.object;
        this.impl.leave();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
