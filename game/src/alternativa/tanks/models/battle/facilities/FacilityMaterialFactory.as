package alternativa.tanks.models.battle.facilities {
  import alternativa.tanks.materials.AnimatedPaintMaterial;
  import alternativa.tanks.materials.PaintMaterial;
  import flash.display.BitmapData;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;

  public class FacilityMaterialFactory {
    public function FacilityMaterialFactory() {
      super();
    }

    internal static function createMaterial(param1:BitmapData, param2:BitmapData, param3:IColoring) : PaintMaterial {
      if(param3.isAnimated()) {
        return getAnimatedMaterial(param3.getAnimatedColoring(),param1,param2);
      }
      return new PaintMaterial(param3.getColoring().data.clone(),param1,param2);
    }

    private static function getAnimatedMaterial(param1:MultiframeTextureResource, param2:BitmapData, param3:BitmapData) : AnimatedPaintMaterial {
      var local4:int = int(param1.numFrames);
      var local5:Number = Number(param1.fps);
      var local6:Number = param1.data.width / param1.frameWidth;
      var local7:Number = param1.data.height / param1.frameHeight;
      return new AnimatedPaintMaterial(param1.data,param2,param3,local6,local7,local5,local4);
    }
  }
}
