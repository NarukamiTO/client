package alternativa.utils {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.materials.AnimatedPaintMaterial;
  import alternativa.tanks.materials.PaintMaterial;
  import alternativa.types.Long;
  import flash.display.BitmapData;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public interface TextureMaterialRegistry {
    function getAnimatedPaint(param1:MultiframeTextureResource, param2:BitmapData, param3:BitmapData, param4:Long) : AnimatedPaintMaterial;
    function getPaint(param1:TextureResource, param2:BitmapData, param3:BitmapData, param4:Long) : PaintMaterial;
    function getMaterial(param1:BitmapData, param2:Boolean = true) : TextureMaterial;
    function addMaterial(param1:TextureMaterial) : void;
    function releaseMaterial(param1:TextureMaterial) : void;
    function setMipMapping(param1:Boolean) : void;
    function clear() : void;
  }
}
