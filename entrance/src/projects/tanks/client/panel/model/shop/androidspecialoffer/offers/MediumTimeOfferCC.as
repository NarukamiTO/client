package projects.tanks.client.panel.model.shop.androidspecialoffer.offers {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class MediumTimeOfferCC {
    private var _paintPreview:ImageResource;

    public function MediumTimeOfferCC(param1:ImageResource = null) {
      super();
      this._paintPreview = param1;
    }

    public function get paintPreview() : ImageResource {
      return this._paintPreview;
    }

    public function set paintPreview(param1:ImageResource) : void {
      this._paintPreview = param1;
    }

    public function toString() : String {
      var local1:String = "MediumTimeOfferCC [";
      local1 += "paintPreview = " + this.paintPreview + " ";
      return local1 + "]";
    }
  }
}
