package projects.tanks.client.panel.model.shop.androidspecialoffer.banner {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class AndroidBannerModelCC {
    private var _buttonIcon:ImageResource;
    private var _cooldownTimeInHour:int;
    private var _order:int;
    private var _type:AndroidBannerType;

    public function AndroidBannerModelCC(param1:ImageResource = null, param2:int = 0, param3:int = 0, param4:AndroidBannerType = null) {
      super();
      this._buttonIcon = param1;
      this._cooldownTimeInHour = param2;
      this._order = param3;
      this._type = param4;
    }

    public function get buttonIcon() : ImageResource {
      return this._buttonIcon;
    }

    public function set buttonIcon(param1:ImageResource) : void {
      this._buttonIcon = param1;
    }

    public function get cooldownTimeInHour() : int {
      return this._cooldownTimeInHour;
    }

    public function set cooldownTimeInHour(param1:int) : void {
      this._cooldownTimeInHour = param1;
    }

    public function get order() : int {
      return this._order;
    }

    public function set order(param1:int) : void {
      this._order = param1;
    }

    public function get type() : AndroidBannerType {
      return this._type;
    }

    public function set type(param1:AndroidBannerType) : void {
      this._type = param1;
    }

    public function toString() : String {
      var local1:String = "AndroidBannerModelCC [";
      local1 += "buttonIcon = " + this.buttonIcon + " ";
      local1 += "cooldownTimeInHour = " + this.cooldownTimeInHour + " ";
      local1 += "order = " + this.order + " ";
      local1 += "type = " + this.type + " ";
      return local1 + "]";
    }
  }
}
