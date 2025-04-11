package projects.tanks.client.garage.models.item.kit {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class GarageKitCC {
    private var _discountInPercent:int;
    private var _image:ImageResource;
    private var _kitItems:Vector.<KitItem>;

    public function GarageKitCC(param1:int = 0, param2:ImageResource = null, param3:Vector.<KitItem> = null) {
      super();
      this._discountInPercent = param1;
      this._image = param2;
      this._kitItems = param3;
    }

    public function get discountInPercent() : int {
      return this._discountInPercent;
    }

    public function set discountInPercent(param1:int) : void {
      this._discountInPercent = param1;
    }

    public function get image() : ImageResource {
      return this._image;
    }

    public function set image(param1:ImageResource) : void {
      this._image = param1;
    }

    public function get kitItems() : Vector.<KitItem> {
      return this._kitItems;
    }

    public function set kitItems(param1:Vector.<KitItem>) : void {
      this._kitItems = param1;
    }

    public function toString() : String {
      var local1:String = "GarageKitCC [";
      local1 += "discountInPercent = " + this.discountInPercent + " ";
      local1 += "image = " + this.image + " ";
      local1 += "kitItems = " + this.kitItems + " ";
      return local1 + "]";
    }
  }
}
