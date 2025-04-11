package projects.tanks.client.garage.models.garagepreview {
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class GaragePreviewModelCC {
    private var _cameraAltitude:Number;
    private var _cameraDistance:Number;
    private var _cameraFov:Number;
    private var _cameraPitch:Number;
    private var _garageBox:Tanks3DSResource;
    private var _hasBatteries:Boolean;
    private var _skyboxFrontSide:TextureResource;

    public function GaragePreviewModelCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Tanks3DSResource = null, param6:Boolean = false, param7:TextureResource = null) {
      super();
      this._cameraAltitude = param1;
      this._cameraDistance = param2;
      this._cameraFov = param3;
      this._cameraPitch = param4;
      this._garageBox = param5;
      this._hasBatteries = param6;
      this._skyboxFrontSide = param7;
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

    public function get hasBatteries() : Boolean {
      return this._hasBatteries;
    }

    public function set hasBatteries(param1:Boolean) : void {
      this._hasBatteries = param1;
    }

    public function get skyboxFrontSide() : TextureResource {
      return this._skyboxFrontSide;
    }

    public function set skyboxFrontSide(param1:TextureResource) : void {
      this._skyboxFrontSide = param1;
    }

    public function toString() : String {
      var local1:String = "GaragePreviewModelCC [";
      local1 += "cameraAltitude = " + this.cameraAltitude + " ";
      local1 += "cameraDistance = " + this.cameraDistance + " ";
      local1 += "cameraFov = " + this.cameraFov + " ";
      local1 += "cameraPitch = " + this.cameraPitch + " ";
      local1 += "garageBox = " + this.garageBox + " ";
      local1 += "hasBatteries = " + this.hasBatteries + " ";
      local1 += "skyboxFrontSide = " + this.skyboxFrontSide + " ";
      return local1 + "]";
    }
  }
}
