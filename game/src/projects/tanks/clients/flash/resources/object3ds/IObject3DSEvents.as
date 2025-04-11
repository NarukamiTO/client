package projects.tanks.clients.flash.resources.object3ds {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class IObject3DSEvents implements IObject3DS {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IObject3DSEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResource3DS() : Tanks3DSResource {
      var result:Tanks3DSResource = null;
      var i:int = 0;
      var m:IObject3DS = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IObject3DS(this.impl[i]);
          result = m.getResource3DS();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
