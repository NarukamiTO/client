package projects.tanks.client.battlefield.models.battle.cp.resources {
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class DominationResources {
    private var _bigLetters:ImageResource;
    private var _blueCircle:ImageResource;
    private var _bluePedestalTexture:TextureResource;
    private var _blueRay:TextureResource;
    private var _blueRayTip:TextureResource;
    private var _neutralCircle:ImageResource;
    private var _neutralPedestalTexture:TextureResource;
    private var _pedestal:Tanks3DSResource;
    private var _redCircle:ImageResource;
    private var _redPedestalTexture:TextureResource;
    private var _redRay:TextureResource;
    private var _redRayTip:TextureResource;

    public function DominationResources(param1:ImageResource = null, param2:ImageResource = null, param3:TextureResource = null, param4:TextureResource = null, param5:TextureResource = null, param6:ImageResource = null, param7:TextureResource = null, param8:Tanks3DSResource = null, param9:ImageResource = null, param10:TextureResource = null, param11:TextureResource = null, param12:TextureResource = null) {
      super();
      this._bigLetters = param1;
      this._blueCircle = param2;
      this._bluePedestalTexture = param3;
      this._blueRay = param4;
      this._blueRayTip = param5;
      this._neutralCircle = param6;
      this._neutralPedestalTexture = param7;
      this._pedestal = param8;
      this._redCircle = param9;
      this._redPedestalTexture = param10;
      this._redRay = param11;
      this._redRayTip = param12;
    }

    public function get bigLetters() : ImageResource {
      return this._bigLetters;
    }

    public function set bigLetters(param1:ImageResource) : void {
      this._bigLetters = param1;
    }

    public function get blueCircle() : ImageResource {
      return this._blueCircle;
    }

    public function set blueCircle(param1:ImageResource) : void {
      this._blueCircle = param1;
    }

    public function get bluePedestalTexture() : TextureResource {
      return this._bluePedestalTexture;
    }

    public function set bluePedestalTexture(param1:TextureResource) : void {
      this._bluePedestalTexture = param1;
    }

    public function get blueRay() : TextureResource {
      return this._blueRay;
    }

    public function set blueRay(param1:TextureResource) : void {
      this._blueRay = param1;
    }

    public function get blueRayTip() : TextureResource {
      return this._blueRayTip;
    }

    public function set blueRayTip(param1:TextureResource) : void {
      this._blueRayTip = param1;
    }

    public function get neutralCircle() : ImageResource {
      return this._neutralCircle;
    }

    public function set neutralCircle(param1:ImageResource) : void {
      this._neutralCircle = param1;
    }

    public function get neutralPedestalTexture() : TextureResource {
      return this._neutralPedestalTexture;
    }

    public function set neutralPedestalTexture(param1:TextureResource) : void {
      this._neutralPedestalTexture = param1;
    }

    public function get pedestal() : Tanks3DSResource {
      return this._pedestal;
    }

    public function set pedestal(param1:Tanks3DSResource) : void {
      this._pedestal = param1;
    }

    public function get redCircle() : ImageResource {
      return this._redCircle;
    }

    public function set redCircle(param1:ImageResource) : void {
      this._redCircle = param1;
    }

    public function get redPedestalTexture() : TextureResource {
      return this._redPedestalTexture;
    }

    public function set redPedestalTexture(param1:TextureResource) : void {
      this._redPedestalTexture = param1;
    }

    public function get redRay() : TextureResource {
      return this._redRay;
    }

    public function set redRay(param1:TextureResource) : void {
      this._redRay = param1;
    }

    public function get redRayTip() : TextureResource {
      return this._redRayTip;
    }

    public function set redRayTip(param1:TextureResource) : void {
      this._redRayTip = param1;
    }

    public function toString() : String {
      var local1:String = "DominationResources [";
      local1 += "bigLetters = " + this.bigLetters + " ";
      local1 += "blueCircle = " + this.blueCircle + " ";
      local1 += "bluePedestalTexture = " + this.bluePedestalTexture + " ";
      local1 += "blueRay = " + this.blueRay + " ";
      local1 += "blueRayTip = " + this.blueRayTip + " ";
      local1 += "neutralCircle = " + this.neutralCircle + " ";
      local1 += "neutralPedestalTexture = " + this.neutralPedestalTexture + " ";
      local1 += "pedestal = " + this.pedestal + " ";
      local1 += "redCircle = " + this.redCircle + " ";
      local1 += "redPedestalTexture = " + this.redPedestalTexture + " ";
      local1 += "redRay = " + this.redRay + " ";
      local1 += "redRayTip = " + this.redRayTip + " ";
      return local1 + "]";
    }
  }
}
