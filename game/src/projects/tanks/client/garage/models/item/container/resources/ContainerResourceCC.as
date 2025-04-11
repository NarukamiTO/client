package projects.tanks.client.garage.models.item.container.resources {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ContainerResourceCC {
    private var _fiveBoxImage:ImageResource;
    private var _fiveBoxLightImage:ImageResource;
    private var _fiveBoxOpenedImage:ImageResource;
    private var _oneBoxImage:ImageResource;
    private var _oneBoxLightImage:ImageResource;
    private var _oneBoxOpenedImage:ImageResource;
    private var _threeBoxImage:ImageResource;
    private var _threeBoxLightImage:ImageResource;
    private var _threeBoxOpenedImage:ImageResource;

    public function ContainerResourceCC(param1:ImageResource = null, param2:ImageResource = null, param3:ImageResource = null, param4:ImageResource = null, param5:ImageResource = null, param6:ImageResource = null, param7:ImageResource = null, param8:ImageResource = null, param9:ImageResource = null) {
      super();
      this._fiveBoxImage = param1;
      this._fiveBoxLightImage = param2;
      this._fiveBoxOpenedImage = param3;
      this._oneBoxImage = param4;
      this._oneBoxLightImage = param5;
      this._oneBoxOpenedImage = param6;
      this._threeBoxImage = param7;
      this._threeBoxLightImage = param8;
      this._threeBoxOpenedImage = param9;
    }

    public function get fiveBoxImage() : ImageResource {
      return this._fiveBoxImage;
    }

    public function set fiveBoxImage(param1:ImageResource) : void {
      this._fiveBoxImage = param1;
    }

    public function get fiveBoxLightImage() : ImageResource {
      return this._fiveBoxLightImage;
    }

    public function set fiveBoxLightImage(param1:ImageResource) : void {
      this._fiveBoxLightImage = param1;
    }

    public function get fiveBoxOpenedImage() : ImageResource {
      return this._fiveBoxOpenedImage;
    }

    public function set fiveBoxOpenedImage(param1:ImageResource) : void {
      this._fiveBoxOpenedImage = param1;
    }

    public function get oneBoxImage() : ImageResource {
      return this._oneBoxImage;
    }

    public function set oneBoxImage(param1:ImageResource) : void {
      this._oneBoxImage = param1;
    }

    public function get oneBoxLightImage() : ImageResource {
      return this._oneBoxLightImage;
    }

    public function set oneBoxLightImage(param1:ImageResource) : void {
      this._oneBoxLightImage = param1;
    }

    public function get oneBoxOpenedImage() : ImageResource {
      return this._oneBoxOpenedImage;
    }

    public function set oneBoxOpenedImage(param1:ImageResource) : void {
      this._oneBoxOpenedImage = param1;
    }

    public function get threeBoxImage() : ImageResource {
      return this._threeBoxImage;
    }

    public function set threeBoxImage(param1:ImageResource) : void {
      this._threeBoxImage = param1;
    }

    public function get threeBoxLightImage() : ImageResource {
      return this._threeBoxLightImage;
    }

    public function set threeBoxLightImage(param1:ImageResource) : void {
      this._threeBoxLightImage = param1;
    }

    public function get threeBoxOpenedImage() : ImageResource {
      return this._threeBoxOpenedImage;
    }

    public function set threeBoxOpenedImage(param1:ImageResource) : void {
      this._threeBoxOpenedImage = param1;
    }

    public function toString() : String {
      var local1:String = "ContainerResourceCC [";
      local1 += "fiveBoxImage = " + this.fiveBoxImage + " ";
      local1 += "fiveBoxLightImage = " + this.fiveBoxLightImage + " ";
      local1 += "fiveBoxOpenedImage = " + this.fiveBoxOpenedImage + " ";
      local1 += "oneBoxImage = " + this.oneBoxImage + " ";
      local1 += "oneBoxLightImage = " + this.oneBoxLightImage + " ";
      local1 += "oneBoxOpenedImage = " + this.oneBoxOpenedImage + " ";
      local1 += "threeBoxImage = " + this.threeBoxImage + " ";
      local1 += "threeBoxLightImage = " + this.threeBoxLightImage + " ";
      local1 += "threeBoxOpenedImage = " + this.threeBoxOpenedImage + " ";
      return local1 + "]";
    }
  }
}
