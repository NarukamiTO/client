package projects.tanks.client.panel.model.bonus.showing.image {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class BonusImageCC {
    private var _image:ImageResource;

    public function BonusImageCC(param1:ImageResource = null) {
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
      var local1:String = "BonusImageCC [";
      local1 += "image = " + this.image + " ";
      return local1 + "]";
    }
  }
}
