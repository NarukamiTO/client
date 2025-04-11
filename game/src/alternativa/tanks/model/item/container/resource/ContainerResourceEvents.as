package alternativa.tanks.model.item.container.resource {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;

  public class ContainerResourceEvents implements ContainerResource {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ContainerResourceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResources() : ContainerResourceCC {
      var result:ContainerResourceCC = null;
      var i:int = 0;
      var m:ContainerResource = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ContainerResource(this.impl[i]);
          result = m.getResources();
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
