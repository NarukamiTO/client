package projects.tanks.client.battlefield.models.battle.battlefield.billboard.billboardimage {
  import platform.client.fp10.core.resource.types.TextureResource;

  public class BillboardImageCC {
    private var _image:TextureResource;

    public function BillboardImageCC(param1:TextureResource = null) {
      super();
      this._image = param1;
    }

    public function get image() : TextureResource {
      return this._image;
    }

    public function set image(param1:TextureResource) : void {
      this._image = param1;
    }

    public function toString() : String {
      var local1:String = "BillboardImageCC [";
      local1 += "image = " + this.image + " ";
      return local1 + "]";
    }
  }
}
