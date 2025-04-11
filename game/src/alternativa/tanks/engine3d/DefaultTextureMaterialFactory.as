package alternativa.tanks.engine3d {
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;

  public class DefaultTextureMaterialFactory implements TextureMaterialFactory {
    public function DefaultTextureMaterialFactory() {
      super();
    }

    public function createTextureMaterial(param1:BitmapData, param2:Boolean) : TextureMaterial {
      return new TextureMaterial(param1,false,true,param2 ? int(MipMapping.PER_PIXEL) : 0);
    }
  }
}
