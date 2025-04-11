package alternativa.tanks.models.tank.event {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LocalTankUnloadListenerAdapt implements LocalTankUnloadListener {
    private var object:IGameObject;
    private var impl:LocalTankUnloadListener;

    public function LocalTankUnloadListenerAdapt(param1:IGameObject, param2:LocalTankUnloadListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function localTankUnloaded(param1:Boolean) : void {
      var resetTank:Boolean = param1;
      try {
        Model.object = this.object;
        this.impl.localTankUnloaded(resetTank);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
