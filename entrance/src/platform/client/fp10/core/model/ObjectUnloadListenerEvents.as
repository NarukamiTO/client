package platform.client.fp10.core.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ObjectUnloadListenerEvents implements ObjectUnloadListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ObjectUnloadListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function objectUnloaded() : void {
      var i:int = 0;
      var m:ObjectUnloadListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ObjectUnloadListener(this.impl[i]);
          m.objectUnloaded();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
