package projects.tanks.clients.flash.commons.models.coloring {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  [ModelInterface]
  public interface IColoring {
    function getColoring() : TextureResource;
    function getAnimatedColoring() : MultiframeTextureResource;
    function isAnimated() : Boolean;
  }
}
