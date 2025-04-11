package projects.tanks.client.panel.model.shop.kitview {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class KitViewResourceCC {
    private var _buttonKit:ImageResource;
    private var _buttonKitOver:ImageResource;

    public function KitViewResourceCC(param1:ImageResource = null, param2:ImageResource = null) {
      super();
      this._buttonKit = param1;
      this._buttonKitOver = param2;
    }

    public function get buttonKit() : ImageResource {
      return this._buttonKit;
    }

    public function set buttonKit(param1:ImageResource) : void {
      this._buttonKit = param1;
    }

    public function get buttonKitOver() : ImageResource {
      return this._buttonKitOver;
    }

    public function set buttonKitOver(param1:ImageResource) : void {
      this._buttonKitOver = param1;
    }

    public function toString() : String {
      var local1:String = "KitViewResourceCC [";
      local1 += "buttonKit = " + this.buttonKit + " ";
      local1 += "buttonKitOver = " + this.buttonKitOver + " ";
      return local1 + "]";
    }
  }
}
