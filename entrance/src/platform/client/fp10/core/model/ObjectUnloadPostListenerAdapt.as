package platform.client.fp10.core.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ObjectUnloadPostListenerAdapt implements ObjectUnloadPostListener {
    private var object:IGameObject;
    private var impl:ObjectUnloadPostListener;

    public function ObjectUnloadPostListenerAdapt(param1:IGameObject, param2:ObjectUnloadPostListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function objectUnloadedPost() : void {
      try {
        Model.object = this.object;
        this.impl.objectUnloadedPost();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
