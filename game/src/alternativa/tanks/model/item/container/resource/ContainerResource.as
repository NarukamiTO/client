package alternativa.tanks.model.item.container.resource {
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;

  [ModelInterface]
  public interface ContainerResource {
    function getResources() : ContainerResourceCC;
  }
}
