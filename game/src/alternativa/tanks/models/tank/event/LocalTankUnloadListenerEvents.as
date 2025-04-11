package alternativa.tanks.models.tank.event {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LocalTankUnloadListenerEvents implements LocalTankUnloadListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function LocalTankUnloadListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function localTankUnloaded(param1:Boolean) : void {
      var i:int = 0;
      var m:LocalTankUnloadListener = null;
      var resetTank:Boolean = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LocalTankUnloadListener(this.impl[i]);
          m.localTankUnloaded(resetTank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
