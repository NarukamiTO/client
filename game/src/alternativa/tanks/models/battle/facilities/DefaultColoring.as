package alternativa.tanks.models.battle.facilities {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;

  internal class DefaultColoring implements IColoring {
    private var textureResource:TextureResource;

    public function DefaultColoring(param1:TextureResource) {
      super();
      this.textureResource = param1;
    }

    public function getColoring() : TextureResource {
      return this.textureResource;
    }

    public function getAnimatedColoring() : MultiframeTextureResource {
      return null;
    }

    public function isAnimated() : Boolean {
      return false;
    }
  }
}
