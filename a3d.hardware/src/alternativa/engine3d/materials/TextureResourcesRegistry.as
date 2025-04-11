package alternativa.engine3d.materials {
  import alternativa.gfx.core.BitmapTextureResource;
  import flash.display.BitmapData;
  import flash.utils.Dictionary;

  public class TextureResourcesRegistry {
    public static var texture2Resource:Dictionary = new Dictionary();

    public function TextureResourcesRegistry() {
      super();
    }

    public static function getTextureResource(param1:BitmapData, param2:Boolean, param3:Boolean, param4:Boolean) : BitmapTextureResource {
      var local5:BitmapTextureResource = null;
      if(param1 in texture2Resource) {
        local5 = texture2Resource[param1];
        local5.increaseReferencesCount();
        return local5;
      }
      var local6:BitmapTextureResource = new BitmapTextureResource(param1,param2,param3,param4);
      texture2Resource[param1] = local6;
      return local6;
    }

    public static function releaseTextureResources() : void {
      var local1:* = undefined;
      var local2:BitmapTextureResource = null;
      for(local1 in texture2Resource) {
        local2 = texture2Resource[local1];
        local2.forceDispose();
      }
    }

    public static function release(param1:BitmapData) : void {
      if(param1 in texture2Resource) {
        delete texture2Resource[param1];
      }
    }
  }
}
