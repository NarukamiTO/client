package alternativa.tanks.engine3d {
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;

  public interface TextureMaterialFactory {
    function createTextureMaterial(param1:BitmapData, param2:Boolean) : TextureMaterial;
  }
}
