package projects.tanks.clients.flash.commons.models.detach {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DetachEvents implements Detach {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DetachEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function detach() : void {
      var i:int = 0;
      var m:Detach = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Detach(this.impl[i]);
          m.detach();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
