package alternativa.tanks.model.payment.modes.asyncurl {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AsyncUrlPayModeEvents implements AsyncUrlPayMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function AsyncUrlPayModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function requestAsyncUrl() : void {
      var i:int = 0;
      var m:AsyncUrlPayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = AsyncUrlPayMode(this.impl[i]);
          m.requestAsyncUrl();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
