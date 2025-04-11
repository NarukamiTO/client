package alternativa.tanks.model.item.container.resource {
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceModelBase;
  import projects.tanks.client.garage.models.item.container.resources.IContainerResourceModelBase;

  [ModelInfo]
  public class ContainerResourceModel extends ContainerResourceModelBase implements IContainerResourceModelBase, ContainerResource {
    public function ContainerResourceModel() {
      super();
    }

    public function getResources() : ContainerResourceCC {
      return getInitParam();
    }
  }
}
