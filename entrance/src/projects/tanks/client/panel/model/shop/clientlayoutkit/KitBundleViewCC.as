package projects.tanks.client.panel.model.shop.clientlayoutkit {
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.entity.BundleImage;

  public class KitBundleViewCC {
    private var _button:ImageResource;
    private var _buttonOver:ImageResource;
    private var _imageBlocks:Vector.<BundleImage>;
    private var _priceLabelColor:int;
    private var _priceLabelFontPercentSize:int;
    private var _priceLabelPositionPercentX:int;
    private var _priceLabelPositionPercentY:int;
    private var _textBlocks:Vector.<CCBundleText>;

    public function KitBundleViewCC(param1:ImageResource = null, param2:ImageResource = null, param3:Vector.<BundleImage> = null, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0, param8:Vector.<CCBundleText> = null) {
      super();
      this._button = param1;
      this._buttonOver = param2;
      this._imageBlocks = param3;
      this._priceLabelColor = param4;
      this._priceLabelFontPercentSize = param5;
      this._priceLabelPositionPercentX = param6;
      this._priceLabelPositionPercentY = param7;
      this._textBlocks = param8;
    }

    public function get button() : ImageResource {
      return this._button;
    }

    public function set button(param1:ImageResource) : void {
      this._button = param1;
    }

    public function get buttonOver() : ImageResource {
      return this._buttonOver;
    }

    public function set buttonOver(param1:ImageResource) : void {
      this._buttonOver = param1;
    }

    public function get imageBlocks() : Vector.<BundleImage> {
      return this._imageBlocks;
    }

    public function set imageBlocks(param1:Vector.<BundleImage>) : void {
      this._imageBlocks = param1;
    }

    public function get priceLabelColor() : int {
      return this._priceLabelColor;
    }

    public function set priceLabelColor(param1:int) : void {
      this._priceLabelColor = param1;
    }

    public function get priceLabelFontPercentSize() : int {
      return this._priceLabelFontPercentSize;
    }

    public function set priceLabelFontPercentSize(param1:int) : void {
      this._priceLabelFontPercentSize = param1;
    }

    public function get priceLabelPositionPercentX() : int {
      return this._priceLabelPositionPercentX;
    }

    public function set priceLabelPositionPercentX(param1:int) : void {
      this._priceLabelPositionPercentX = param1;
    }

    public function get priceLabelPositionPercentY() : int {
      return this._priceLabelPositionPercentY;
    }

    public function set priceLabelPositionPercentY(param1:int) : void {
      this._priceLabelPositionPercentY = param1;
    }

    public function get textBlocks() : Vector.<CCBundleText> {
      return this._textBlocks;
    }

    public function set textBlocks(param1:Vector.<CCBundleText>) : void {
      this._textBlocks = param1;
    }

    public function toString() : String {
      var local1:String = "KitBundleViewCC [";
      local1 += "button = " + this.button + " ";
      local1 += "buttonOver = " + this.buttonOver + " ";
      local1 += "imageBlocks = " + this.imageBlocks + " ";
      local1 += "priceLabelColor = " + this.priceLabelColor + " ";
      local1 += "priceLabelFontPercentSize = " + this.priceLabelFontPercentSize + " ";
      local1 += "priceLabelPositionPercentX = " + this.priceLabelPositionPercentX + " ";
      local1 += "priceLabelPositionPercentY = " + this.priceLabelPositionPercentY + " ";
      local1 += "textBlocks = " + this.textBlocks + " ";
      return local1 + "]";
    }
  }
}
