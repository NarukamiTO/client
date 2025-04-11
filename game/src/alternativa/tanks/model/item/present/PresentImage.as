package alternativa.tanks.model.item.present {
  import platform.client.fp10.core.resource.types.ImageResource;

  [ModelInterface]
  public interface PresentImage {
    function getImage() : ImageResource;
  }
}
