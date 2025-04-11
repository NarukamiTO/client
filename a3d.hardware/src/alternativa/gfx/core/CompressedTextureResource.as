package alternativa.gfx.core {
  import alternativa.gfx.alternativagfx;
  import flash.display3D.Context3D;
  import flash.display3D.Context3DTextureFormat;
  import flash.utils.ByteArray;
  import flash.utils.Endian;

  use namespace alternativagfx;

  public class CompressedTextureResource extends TextureResource {
    private var _byteArray:ByteArray;
    private var _width:int;
    private var _height:int;

    public function CompressedTextureResource(param1:ByteArray) {
      super();
      this._byteArray = param1;
      this._byteArray.endian = Endian.LITTLE_ENDIAN;
      this._byteArray.position = 7;
      this._width = 1 << this._byteArray.readByte();
      this._height = 1 << this._byteArray.readByte();
      this._byteArray.position = 0;
    }

    public function get byteArray() : ByteArray {
      return this._byteArray;
    }

    public function get width() : int {
      return this._width;
    }

    public function get height() : int {
      return this._height;
    }

    override public function dispose() : void {
      super.dispose();
      this._byteArray = null;
      this._width = 0;
      this._height = 0;
    }

    override public function get available() : Boolean {
      return this._byteArray != null;
    }

    override alternativagfx function create(param1:Context3D) : void {
      super.alternativagfx::create(param1);
      texture = param1.createTexture(this._width,this._height,Context3DTextureFormat.COMPRESSED,false);
    }

    override alternativagfx function upload() : void {
      super.alternativagfx::upload();
      texture.uploadCompressedTextureFromByteArray(this._byteArray,0);
    }
  }
}
