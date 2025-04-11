package projects.tanks.client.garage.models.item.present {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class PresentItemCC {
    private var _image:ImageResource;

    public function PresentItemCC(param1:ImageResource = null) {
      super();
      this._image = param1;
    }

    public function get image() : ImageResource {
      return this._image;
    }

    public function set image(param1:ImageResource) : void {
      this._image = param1;
    }

    public function toString() : String {
      var local1:String = "PresentItemCC [";
      local1 += "image = " + this.image + " ";
      return local1 + "]";
    }
  }
}
