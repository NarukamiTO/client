package alternativa.utils.textureutils {
  import flash.utils.ByteArray;

  public class TextureByteData {
    public var diffuseData:ByteArray;
    public var opacityData:ByteArray;

    public function TextureByteData(diffuseData:ByteArray = null, opacityData:ByteArray = null) {
      super();
      this.diffuseData = diffuseData;
      this.opacityData = opacityData;
    }
  }
}
