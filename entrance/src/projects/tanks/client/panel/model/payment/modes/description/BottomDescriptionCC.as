package projects.tanks.client.panel.model.payment.modes.description {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class BottomDescriptionCC {
    private var _description:String;
    private var _images:Vector.<ImageResource>;

    public function BottomDescriptionCC(param1:String = null, param2:Vector.<ImageResource> = null) {
      super();
      this._description = param1;
      this._images = param2;
    }

    public function get description() : String {
      return this._description;
    }

    public function set description(param1:String) : void {
      this._description = param1;
    }

    public function get images() : Vector.<ImageResource> {
      return this._images;
    }

    public function set images(param1:Vector.<ImageResource>) : void {
      this._images = param1;
    }

    public function toString() : String {
      var local1:String = "BottomDescriptionCC [";
      local1 += "description = " + this.description + " ";
      local1 += "images = " + this.images + " ";
      return local1 + "]";
    }
  }
}
