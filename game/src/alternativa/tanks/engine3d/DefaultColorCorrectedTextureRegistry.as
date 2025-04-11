package alternativa.tanks.engine3d {
  import alternativa.tanks.services.colortransform.ColorTransformUtils;
  import alternativa.utils.clearDictionary;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import flash.utils.Dictionary;
  import org1.osflash.signals.Signal;

  public class DefaultColorCorrectedTextureRegistry implements ColorCorrectedTextureRegistry {
    private static const IDENTITY_COLOR_TRANSFORM:ColorTransform = new ColorTransform();

    private const onTextureChange:Signal = new Signal();
    private const textures:Dictionary = new Dictionary();

    private var colorTransform:ColorTransform;

    public function DefaultColorCorrectedTextureRegistry() {
      super();
    }

    public function clear() : void {
      var local1:int = 0;
      var local2:* = undefined;
      var local3:BitmapData = null;
      if(this.colorTransform == null) {
        clearDictionary(this.textures);
      } else {
        local1 = 0;
        for(local2 in this.textures) {
          local3 = this.textures[local2];
          local3.dispose();
          delete this.textures[local2];
          local1++;
        }
      }
    }

    public function getTexture(param1:BitmapData, param2:Boolean = true) : BitmapData {
      if(param1 == null) {
        throw new ArgumentError("Texture is null");
      }
      var local3:BitmapData = this.textures[param1];
      if(local3 == null) {
        local3 = this.transformTexture(param1,param2);
        this.textures[param1] = local3;
      }
      return local3;
    }

    private function transformTexture(param1:BitmapData, param2:Boolean = true) : BitmapData {
      if(this.colorTransform == null) {
        return param1;
      }
      if(param2) {
        return ColorTransformUtils.transformBitmap(param1,this.colorTransform);
      }
      return param1.clone();
    }

    public function addTextureChangeHandler(param1:Function) : void {
      this.onTextureChange.add(param1);
    }

    public function setColorTransform(param1:ColorTransform) : void {
      var local2:ColorTransform = this.getEffectiveColorTransform(param1);
      if(!ColorTransformUtils.equal(this.colorTransform,local2)) {
        this.colorTransform = local2;
        this.updateTextures();
        this.onTextureChange.dispatch();
      }
    }

    private function getEffectiveColorTransform(param1:ColorTransform) : ColorTransform {
      var local2:ColorTransform = ColorTransformUtils.clone(param1);
      if(ColorTransformUtils.equal(local2,IDENTITY_COLOR_TRANSFORM)) {
        return null;
      }
      return local2;
    }

    private function updateTextures() : void {
      var local2:* = undefined;
      var local3:BitmapData = null;
      var local1:int = 0;
      for(local2 in this.textures) {
        local3 = this.textures[local2];
        if(local3 != local2) {
          local3.dispose();
          local1++;
        }
        this.textures[local2] = this.transformTexture(local2);
      }
    }
  }
}
