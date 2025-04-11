package alternativa.utils.textureutils {
  import alternativa.utils.BitmapUtils;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Loader;
  import flash.events.Event;
  import flash.utils.ByteArray;

  public class TextureConstructor {
    private var _texture:BitmapData;
    private var listener:ITextureConstructorListener;
    private var loader:Loader;
    private var textureData:TextureByteData;
    private var cancelled:Boolean;

    public function TextureConstructor() {
      super();
    }

    public function get texture() : BitmapData {
      return this._texture;
    }

    public function cancel() : void {
      this.cancelled = true;
    }

    public function createTexture(textureData:TextureByteData, listener:ITextureConstructorListener) : void {
      if(this.loader != null) {
        throw new Error("Construction in progress");
      }
      if(textureData == null) {
        throw new ArgumentError("Parameter textureData is null");
      }
      if(textureData.diffuseData == null) {
        throw new ArgumentError("Diffuse data is null");
      }
      this.cancelled = false;
      this.textureData = textureData;
      this.listener = listener;
      this.loadBytes(textureData.diffuseData,this.onDiffuseTextureLoadingComplete);
    }

    private function loadBytes(data:ByteArray, callback:Function) : void {
      data.position = 0;
      this.loader = new Loader();
      this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,callback);
      this.loader.loadBytes(data);
    }

    private function onDiffuseTextureLoadingComplete(e:Event) : void {
      if(this.cancelled) {
        Bitmap(this.loader.content).bitmapData.dispose();
        this.loader.unload();
        this.loader = null;
      } else {
        this._texture = Bitmap(this.loader.content).bitmapData;
        this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onDiffuseTextureLoadingComplete);
        this.loader.unload();
        if(this.textureData.opacityData != null) {
          this.loadBytes(this.textureData.opacityData,this.onAlphaTextureLoadingComplete);
        } else {
          this.complete();
        }
      }
    }

    private function onAlphaTextureLoadingComplete(e:Event) : void {
      var alpha:BitmapData = null;
      if(this.cancelled) {
        Bitmap(this.loader.content).bitmapData.dispose();
        this.loader.unload();
        this.loader = null;
      } else {
        alpha = Bitmap(this.loader.content).bitmapData;
        this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onAlphaTextureLoadingComplete);
        this.loader.unload();
        this._texture = BitmapUtils.mergeBitmapAlpha(this._texture,alpha,true);
        this.complete();
      }
    }

    private function complete() : void {
      this.loader = null;
      this.textureData = null;
      var listener:ITextureConstructorListener = this.listener;
      this.listener = null;
      listener.onTextureReady(this);
    }
  }
}
