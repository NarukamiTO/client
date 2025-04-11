package projects.tanks.client.panel.model.shop.specialkit.view.singleitem {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class SingleItemKitViewCC {
    private var _brandIcon:ImageResource;
    private var _button:ImageResource;
    private var _buttonOver:ImageResource;
    private var _preview:ImageResource;

    public function SingleItemKitViewCC(param1:ImageResource = null, param2:ImageResource = null, param3:ImageResource = null, param4:ImageResource = null) {
      super();
      this._brandIcon = param1;
      this._button = param2;
      this._buttonOver = param3;
      this._preview = param4;
    }

    public function get brandIcon() : ImageResource {
      return this._brandIcon;
    }

    public function set brandIcon(param1:ImageResource) : void {
      this._brandIcon = param1;
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

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function toString() : String {
      var local1:String = "SingleItemKitViewCC [";
      local1 += "brandIcon = " + this.brandIcon + " ";
      local1 += "button = " + this.button + " ";
      local1 += "buttonOver = " + this.buttonOver + " ";
      local1 += "preview = " + this.preview + " ";
      return local1 + "]";
    }
  }
}
