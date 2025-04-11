package projects.tanks.clients.flash.resources.object3ds {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class IObject3DSAdapt implements IObject3DS {
    private var object:IGameObject;
    private var impl:IObject3DS;

    public function IObject3DSAdapt(param1:IGameObject, param2:IObject3DS) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResource3DS() : Tanks3DSResource {
      var result:Tanks3DSResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getResource3DS();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
