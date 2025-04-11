package alternativa.tanks.engine3d {
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;

  public class MutableTextureMaterialRegistry extends TextureMaterialRegistryBase {
    private var textureRegistry:MutableTextureRegistry;

    public function MutableTextureMaterialRegistry(param1:TextureMaterialFactory, param2:MutableTextureRegistry) {
      super(param1);
      this.textureRegistry = param2;
      param2.addTextureChangeHandler(this.onTextureChange);
    }

    private function onTextureChange() : void {
      forEachMaterial(this._updateTexture);
    }

    private function _updateTexture(param1:TextureMaterial) : void {
      var local2:MaterialEntry = getEntry(param1);
      param1.texture = this.textureRegistry.getTexture(local2.texture);
    }

    override protected function getTexture(param1:BitmapData, param2:Boolean) : BitmapData {
      return this.textureRegistry.getTexture(param1,param2);
    }
  }
}
