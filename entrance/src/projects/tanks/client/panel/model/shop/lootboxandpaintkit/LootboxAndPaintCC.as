package projects.tanks.client.panel.model.shop.lootboxandpaintkit {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class LootboxAndPaintCC {
    private var _button:ImageResource;
    private var _buttonOver:ImageResource;
    private var _crystalCount:int;
    private var _lootBoxPreview:ImageResource;
    private var _lootboxCount:int;
    private var _paintPreview:ImageResource;

    public function LootboxAndPaintCC(param1:ImageResource = null, param2:ImageResource = null, param3:int = 0, param4:ImageResource = null, param5:int = 0, param6:ImageResource = null) {
      super();
      this._button = param1;
      this._buttonOver = param2;
      this._crystalCount = param3;
      this._lootBoxPreview = param4;
      this._lootboxCount = param5;
      this._paintPreview = param6;
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

    public function get crystalCount() : int {
      return this._crystalCount;
    }

    public function set crystalCount(param1:int) : void {
      this._crystalCount = param1;
    }

    public function get lootBoxPreview() : ImageResource {
      return this._lootBoxPreview;
    }

    public function set lootBoxPreview(param1:ImageResource) : void {
      this._lootBoxPreview = param1;
    }

    public function get lootboxCount() : int {
      return this._lootboxCount;
    }

    public function set lootboxCount(param1:int) : void {
      this._lootboxCount = param1;
    }

    public function get paintPreview() : ImageResource {
      return this._paintPreview;
    }

    public function set paintPreview(param1:ImageResource) : void {
      this._paintPreview = param1;
    }

    public function toString() : String {
      var local1:String = "LootboxAndPaintCC [";
      local1 += "button = " + this.button + " ";
      local1 += "buttonOver = " + this.buttonOver + " ";
      local1 += "crystalCount = " + this.crystalCount + " ";
      local1 += "lootBoxPreview = " + this.lootBoxPreview + " ";
      local1 += "lootboxCount = " + this.lootboxCount + " ";
      local1 += "paintPreview = " + this.paintPreview + " ";
      return local1 + "]";
    }
  }
}
