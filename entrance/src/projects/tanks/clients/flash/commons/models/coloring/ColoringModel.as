package projects.tanks.clients.flash.commons.models.coloring {
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.commons.models.coloring.ColoringModelBase;
  import projects.tanks.client.commons.models.coloring.IColoringModelBase;

  [ModelInfo]
  public class ColoringModel extends ColoringModelBase implements IColoringModelBase, IColoring {
    [Inject]
    public static var resourceRegistry:ResourceRegistry;

    public function ColoringModel() {
      super();
    }

    public function isAnimated() : Boolean {
      return getInitParam().animatedColoring != null;
    }

    public function getColoring() : TextureResource {
      if(getInitParam().coloring != null) {
        return getInitParam().coloring;
      }
      return null;
    }

    public function getAnimatedColoring() : MultiframeTextureResource {
      return getInitParam().animatedColoring;
    }
  }
}
