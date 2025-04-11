package alternativa.tanks.model.info {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShowInfoAdapt implements ShowInfo {
    private var object:IGameObject;
    private var impl:ShowInfo;

    public function ShowInfoAdapt(param1:IGameObject, param2:ShowInfo) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showInfo() : void {
      try {
        Model.object = this.object;
        this.impl.showInfo();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
