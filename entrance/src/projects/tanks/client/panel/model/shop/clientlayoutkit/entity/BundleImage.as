package projects.tanks.client.panel.model.shop.clientlayoutkit.entity {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class BundleImage {
    private var _height:int;
    private var _image:ImageResource;
    private var _positionPercentX:int;
    private var _positionPercentY:int;

    public function BundleImage(param1:int = 0, param2:ImageResource = null, param3:int = 0, param4:int = 0) {
      super();
      this._height = param1;
      this._image = param2;
      this._positionPercentX = param3;
      this._positionPercentY = param4;
    }

    public function get height() : int {
      return this._height;
    }

    public function set height(param1:int) : void {
      this._height = param1;
    }

    public function get image() : ImageResource {
      return this._image;
    }

    public function set image(param1:ImageResource) : void {
      this._image = param1;
    }

    public function get positionPercentX() : int {
      return this._positionPercentX;
    }

    public function set positionPercentX(param1:int) : void {
      this._positionPercentX = param1;
    }

    public function get positionPercentY() : int {
      return this._positionPercentY;
    }

    public function set positionPercentY(param1:int) : void {
      this._positionPercentY = param1;
    }

    public function toString() : String {
      var local1:String = "BundleImage [";
      local1 += "height = " + this.height + " ";
      local1 += "image = " + this.image + " ";
      local1 += "positionPercentX = " + this.positionPercentX + " ";
      local1 += "positionPercentY = " + this.positionPercentY + " ";
      return local1 + "]";
    }
  }
}
