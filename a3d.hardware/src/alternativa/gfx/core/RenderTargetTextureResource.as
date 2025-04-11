package alternativa.gfx.core {
  import alternativa.gfx.alternativagfx;
  import flash.display3D.Context3D;
  import flash.display3D.Context3DTextureFormat;

  use namespace alternativagfx;

  public class RenderTargetTextureResource extends TextureResource {
    private var _width:int;
    private var _height:int;
    private var _available:Boolean = true;

    public function RenderTargetTextureResource(param1:int, param2:int) {
      super();
      this._width = param1;
      this._height = param2;
    }

    public function get width() : int {
      return this._width;
    }

    public function get height() : int {
      return this._height;
    }

    override public function dispose() : void {
      super.dispose();
      this._available = false;
    }

    override public function get available() : Boolean {
      return this._available;
    }

    override alternativagfx function create(param1:Context3D) : void {
      super.alternativagfx::create(param1);
      texture = param1.createTexture(this._width,this._height,Context3DTextureFormat.BGRA,true);
    }
  }
}
