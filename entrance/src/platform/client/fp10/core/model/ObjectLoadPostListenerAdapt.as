package platform.client.fp10.core.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ObjectLoadPostListenerAdapt implements ObjectLoadPostListener {
    private var object:IGameObject;
    private var impl:ObjectLoadPostListener;

    public function ObjectLoadPostListenerAdapt(param1:IGameObject, param2:ObjectLoadPostListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function objectLoadedPost() : void {
      try {
        Model.object = this.object;
        this.impl.objectLoadedPost();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
