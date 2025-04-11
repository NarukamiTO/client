package alternativa.tanks.model.payment.modes.asyncurl {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AsyncUrlPayModeAdapt implements AsyncUrlPayMode {
    private var object:IGameObject;
    private var impl:AsyncUrlPayMode;

    public function AsyncUrlPayModeAdapt(param1:IGameObject, param2:AsyncUrlPayMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function requestAsyncUrl() : void {
      try {
        Model.object = this.object;
        this.impl.requestAsyncUrl();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
