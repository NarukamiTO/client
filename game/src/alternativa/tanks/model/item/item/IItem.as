package alternativa.tanks.model.item.item {
  import platform.client.fp10.core.resource.types.ImageResource;

  [ModelInterface]
  public interface IItem {
    function getPosition() : int;
    function getPreviewResource() : ImageResource;
    function getMaxRank() : int;
    function getMinRank() : int;
  }
}
