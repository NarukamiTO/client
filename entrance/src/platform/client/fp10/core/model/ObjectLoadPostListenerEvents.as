package platform.client.fp10.core.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ObjectLoadPostListenerEvents implements ObjectLoadPostListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ObjectLoadPostListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function objectLoadedPost() : void {
      var i:int = 0;
      var m:ObjectLoadPostListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ObjectLoadPostListener(this.impl[i]);
          m.objectLoadedPost();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
