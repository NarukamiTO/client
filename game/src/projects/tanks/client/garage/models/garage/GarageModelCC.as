package projects.tanks.client.garage.models.garage {
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class GarageModelCC {
    private var _cameraAltitude:Number;
    private var _cameraDistance:Number;
    private var _cameraFov:Number;
    private var _cameraPitch:Number;
    private var _garageBox:Tanks3DSResource;
    private var _hideLinks:Boolean;
    private var _mountableCategories:Vector.<ItemCategoryEnum>;
    private var _skyboxBackSide:TextureResource;
    private var _skyboxBottomSide:TextureResource;
    private var _skyboxFrontSide:TextureResource;
    private var _skyboxLeftSide:TextureResource;
    private var _skyboxRightSide:TextureResource;
    private var _skyboxTopSide:TextureResource;

    public function GarageModelCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Tanks3DSResource = null, param6:Boolean = false, param7:Vector.<ItemCategoryEnum> = null, param8:TextureResource = null, param9:TextureResource = null, param10:TextureResource = null, param11:TextureResource = null, param12:TextureResource = null, param13:TextureResource = null) {
      super();
      this._cameraAltitude = param1;
      this._cameraDistance = param2;
      this._cameraFov = param3;
      this._cameraPitch = param4;
      this._garageBox = param5;
      this._hideLinks = param6;
      this._mountableCategories = param7;
      this._skyboxBackSide = param8;
      this._skyboxBottomSide = param9;
      this._skyboxFrontSide = param10;
      this._skyboxLeftSide = param11;
      this._skyboxRightSide = param12;
      this._skyboxTopSide = param13;
    }

    public function get cameraAltitude() : Number {
      return this._cameraAltitude;
    }

    public function set cameraAltitude(param1:Number) : void {
      this._cameraAltitude = param1;
    }

    public function get cameraDistance() : Number {
      return this._cameraDistance;
    }

    public function set cameraDistance(param1:Number) : void {
      this._cameraDistance = param1;
    }

    public function get cameraFov() : Number {
      return this._cameraFov;
    }

    public function set cameraFov(param1:Number) : void {
      this._cameraFov = param1;
    }

    public function get cameraPitch() : Number {
      return this._cameraPitch;
    }

    public function set cameraPitch(param1:Number) : void {
      this._cameraPitch = param1;
    }

    public function get garageBox() : Tanks3DSResource {
      return this._garageBox;
    }

    public function set garageBox(param1:Tanks3DSResource) : void {
      this._garageBox = param1;
    }

    public function get hideLinks() : Boolean {
      return this._hideLinks;
    }

    public function set hideLinks(param1:Boolean) : void {
      this._hideLinks = param1;
    }

    public function get mountableCategories() : Vector.<ItemCategoryEnum> {
      return this._mountableCategories;
    }

    public function set mountableCategories(param1:Vector.<ItemCategoryEnum>) : void {
      this._mountableCategories = param1;
    }

    public function get skyboxBackSide() : TextureResource {
      return this._skyboxBackSide;
    }

    public function set skyboxBackSide(param1:TextureResource) : void {
      this._skyboxBackSide = param1;
    }

    public function get skyboxBottomSide() : TextureResource {
      return this._skyboxBottomSide;
    }

    public function set skyboxBottomSide(param1:TextureResource) : void {
      this._skyboxBottomSide = param1;
    }

    public function get skyboxFrontSide() : TextureResource {
      return this._skyboxFrontSide;
    }

    public function set skyboxFrontSide(param1:TextureResource) : void {
      this._skyboxFrontSide = param1;
    }

    public function get skyboxLeftSide() : TextureResource {
      return this._skyboxLeftSide;
    }

    public function set skyboxLeftSide(param1:TextureResource) : void {
      this._skyboxLeftSide = param1;
    }

    public function get skyboxRightSide() : TextureResource {
      return this._skyboxRightSide;
    }

    public function set skyboxRightSide(param1:TextureResource) : void {
      this._skyboxRightSide = param1;
    }

    public function get skyboxTopSide() : TextureResource {
      return this._skyboxTopSide;
    }

    public function set skyboxTopSide(param1:TextureResource) : void {
      this._skyboxTopSide = param1;
    }

    public function toString() : String {
      var local1:String = "GarageModelCC [";
      local1 += "cameraAltitude = " + this.cameraAltitude + " ";
      local1 += "cameraDistance = " + this.cameraDistance + " ";
      local1 += "cameraFov = " + this.cameraFov + " ";
      local1 += "cameraPitch = " + this.cameraPitch + " ";
      local1 += "garageBox = " + this.garageBox + " ";
      local1 += "hideLinks = " + this.hideLinks + " ";
      local1 += "mountableCategories = " + this.mountableCategories + " ";
      local1 += "skyboxBackSide = " + this.skyboxBackSide + " ";
      local1 += "skyboxBottomSide = " + this.skyboxBottomSide + " ";
      local1 += "skyboxFrontSide = " + this.skyboxFrontSide + " ";
      local1 += "skyboxLeftSide = " + this.skyboxLeftSide + " ";
      local1 += "skyboxRightSide = " + this.skyboxRightSide + " ";
      local1 += "skyboxTopSide = " + this.skyboxTopSide + " ";
      return local1 + "]";
    }
  }
}
