package alternativa.tanks.model.info {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShowInfoEvents implements ShowInfo {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShowInfoEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showInfo() : void {
      var i:int = 0;
      var m:ShowInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShowInfo(this.impl[i]);
          m.showInfo();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
