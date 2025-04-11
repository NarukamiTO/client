package alternativa.tanks.model.item3d {
  import platform.client.fp10.core.registry.ResourceRegistry;
  import projects.tanks.client.garage.models.item.object3ds.IObject3DSModelBase;
  import projects.tanks.client.garage.models.item.object3ds.Object3DSModelBase;
  import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class Object3DSModel extends Object3DSModelBase implements IObject3DSModelBase, IObject3DS {
    [Inject]
    public static var resourceRegistry:ResourceRegistry;

    public function Object3DSModel() {
      super();
    }

    public function getResource3DS() : Tanks3DSResource {
      return Tanks3DSResource(resourceRegistry.getResource(getInitParam().resourceId));
    }
  }
}
