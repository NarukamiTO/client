package projects.tanks.clients.flash.commons.models.detach {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DetachAdapt implements Detach {
    private var object:IGameObject;
    private var impl:Detach;

    public function DetachAdapt(param1:IGameObject, param2:Detach) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function detach() : void {
      try {
        Model.object = this.object;
        this.impl.detach();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
