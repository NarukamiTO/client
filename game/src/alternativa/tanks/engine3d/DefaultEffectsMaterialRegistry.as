package alternativa.tanks.engine3d {
  import flash.display.BitmapData;

  public class DefaultEffectsMaterialRegistry extends TextureMaterialRegistryBase implements EffectsMaterialRegistry {
    public function DefaultEffectsMaterialRegistry() {
      super(new DefaultTextureMaterialFactory());
    }

    override protected function getTexture(param1:BitmapData, param2:Boolean) : BitmapData {
      return param1;
    }
  }
}
