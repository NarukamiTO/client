package alternativa.tanks.engine3d {
  import alternativa.utils.textureutils.TextureConstructor;

  public class IndexedTextureConstructor extends TextureConstructor {
    public var index:int;

    public function IndexedTextureConstructor() {
      super();
    }

    public function disposeTexture() : void {
      if(texture != null) {
        texture.dispose();
      }
    }
  }
}
