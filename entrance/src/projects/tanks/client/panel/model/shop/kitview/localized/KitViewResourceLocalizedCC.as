package projects.tanks.client.panel.model.shop.kitview.localized {
  import platform.client.fp10.core.resource.types.LocalizedImageResource;

  public class KitViewResourceLocalizedCC {
    private var _buttonKit:LocalizedImageResource;
    private var _buttonKitOver:LocalizedImageResource;

    public function KitViewResourceLocalizedCC(param1:LocalizedImageResource = null, param2:LocalizedImageResource = null) {
      super();
      this._buttonKit = param1;
      this._buttonKitOver = param2;
    }

    public function get buttonKit() : LocalizedImageResource {
      return this._buttonKit;
    }

    public function set buttonKit(param1:LocalizedImageResource) : void {
      this._buttonKit = param1;
    }

    public function get buttonKitOver() : LocalizedImageResource {
      return this._buttonKitOver;
    }

    public function set buttonKitOver(param1:LocalizedImageResource) : void {
      this._buttonKitOver = param1;
    }

    public function toString() : String {
      var local1:String = "KitViewResourceLocalizedCC [";
      local1 += "buttonKit = " + this.buttonKit + " ";
      local1 += "buttonKitOver = " + this.buttonKitOver + " ";
      return local1 + "]";
    }
  }
}
