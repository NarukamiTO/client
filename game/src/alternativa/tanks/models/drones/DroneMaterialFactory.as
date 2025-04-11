package alternativa.tanks.models.drones {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.materials.PaintMaterial;
  import alternativa.utils.TextureMaterialRegistry;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class DroneMaterialFactory {
    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private static const DETAILS:String = "details.png";
    private static const LIGHTMAP:String = "lightmap.jpg";

    public function DroneMaterialFactory() {
      super();
    }

    public function createMaterial(param1:Tanks3DSResource, param2:IColoring) : PaintMaterial {
      if(param2.isAnimated()) {
        return textureMaterialRegistry.getAnimatedPaint(param2.getAnimatedColoring(),param1.textures[LIGHTMAP],param1.textures[DETAILS],param1.id);
      }
      return textureMaterialRegistry.getPaint(param2.getColoring(),param1.textures[LIGHTMAP],param1.textures[DETAILS],param1.id);
    }

    public function releaseMaterial(param1:TextureMaterial) : void {
      textureMaterialRegistry.releaseMaterial(param1);
    }
  }
}
