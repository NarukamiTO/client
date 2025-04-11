package alternativa.tanks.models.tank.event {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LocalTankLoadListenerAdapt implements LocalTankLoadListener {
    private var object:IGameObject;
    private var impl:LocalTankLoadListener;

    public function LocalTankLoadListenerAdapt(param1:IGameObject, param2:LocalTankLoadListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function localTankLoaded(param1:Boolean) : void {
      var resetTank:Boolean = param1;
      try {
        Model.object = this.object;
        this.impl.localTankLoaded(resetTank);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
