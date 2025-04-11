package projects.tanks.client.garage.models.item.device {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ItemDevicesCC {
    private var _devicesAvailable:Boolean;
    private var _preview:ImageResource;
    private var _sale:Boolean;

    public function ItemDevicesCC(param1:Boolean = false, param2:ImageResource = null, param3:Boolean = false) {
      super();
      this._devicesAvailable = param1;
      this._preview = param2;
      this._sale = param3;
    }

    public function get devicesAvailable() : Boolean {
      return this._devicesAvailable;
    }

    public function set devicesAvailable(param1:Boolean) : void {
      this._devicesAvailable = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function get sale() : Boolean {
      return this._sale;
    }

    public function set sale(param1:Boolean) : void {
      this._sale = param1;
    }

    public function toString() : String {
      var local1:String = "ItemDevicesCC [";
      local1 += "devicesAvailable = " + this.devicesAvailable + " ";
      local1 += "preview = " + this.preview + " ";
      local1 += "sale = " + this.sale + " ";
      return local1 + "]";
    }
  }
}
