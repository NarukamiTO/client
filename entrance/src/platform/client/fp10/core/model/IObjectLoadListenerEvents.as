package platform.client.fp10.core.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IObjectLoadListenerEvents implements IObjectLoadListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IObjectLoadListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function objectLoaded() : void {
      var i:int = 0;
      var m:IObjectLoadListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IObjectLoadListener(this.impl[i]);
          m.objectLoaded();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function objectLoadedPost() : void {
      var i:int = 0;
      var m:IObjectLoadListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IObjectLoadListener(this.impl[i]);
          m.objectLoadedPost();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function objectUnloaded() : void {
      var i:int = 0;
      var m:IObjectLoadListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IObjectLoadListener(this.impl[i]);
          m.objectUnloaded();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function objectUnloadedPost() : void {
      var i:int = 0;
      var m:IObjectLoadListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IObjectLoadListener(this.impl[i]);
          m.objectUnloadedPost();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
