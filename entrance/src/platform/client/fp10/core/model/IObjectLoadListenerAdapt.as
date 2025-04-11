package platform.client.fp10.core.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IObjectLoadListenerAdapt implements IObjectLoadListener {
    private var object:IGameObject;
    private var impl:IObjectLoadListener;

    public function IObjectLoadListenerAdapt(param1:IGameObject, param2:IObjectLoadListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function objectLoaded() : void {
      try {
        Model.object = this.object;
        this.impl.objectLoaded();
      }
      finally {
        Model.popObject();
      }
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

    public function objectUnloaded() : void {
      try {
        Model.object = this.object;
        this.impl.objectUnloaded();
      }
      finally {
        Model.popObject();
      }
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
