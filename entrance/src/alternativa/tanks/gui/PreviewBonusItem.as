package alternativa.tanks.gui {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import platform.client.fp10.core.resource.types.ImageResource;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class PreviewBonusItem extends Sprite implements IImageResource {
    private var _imageResource:ImageResource;
    private var _preview:Bitmap;
    private var _componentWidth:Number;
    private var _componentHeight:Number;

    public function PreviewBonusItem(param1:ImageResource, param2:Number, param3:Number) {
      super();
      this._imageResource = param1;
      this._componentWidth = param2;
      this._componentHeight = param3;
      this.init();
    }

    private function init() : void {
      graphics.clear();
      graphics.beginFill(16711680,0);
      graphics.drawRect(0,0,this._componentWidth,this._componentHeight);
      graphics.endFill();
      if(this._imageResource.isLazy && !this._imageResource.isLoaded) {
        this._imageResource.loadLazyResource(new ImageResourceLoadingWrapper(this));
      } else {
        this.setPreview(this._imageResource.data);
      }
    }

    public function setPreviewResource(param1:ImageResource) : void {
      if(this._imageResource.id == param1.id) {
        this.setPreview(this._imageResource.data);
      }
    }

    private function setPreview(param1:BitmapData) : void {
      if(this._preview != null && this.contains(this._preview)) {
        removeChild(this._preview);
      }
      this._preview = new Bitmap(param1);
      addChild(this._preview);
      this._preview.x = this._componentWidth - this._preview.width >> 1;
      this._preview.y = this._componentHeight - this._preview.height >> 1;
    }
  }
}
