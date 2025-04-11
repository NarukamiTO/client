package alternativa.tanks.model.item.container.resource {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;

  public class ContainerResourceAdapt implements ContainerResource {
    private var object:IGameObject;
    private var impl:ContainerResource;

    public function ContainerResourceAdapt(param1:IGameObject, param2:ContainerResource) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResources() : ContainerResourceCC {
      var result:ContainerResourceCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getResources();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
