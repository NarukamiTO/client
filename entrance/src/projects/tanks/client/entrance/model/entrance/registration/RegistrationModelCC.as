package projects.tanks.client.entrance.model.entrance.registration {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class RegistrationModelCC {
    private var _bgResource:ImageResource;
    private var _enableRequiredEmail:Boolean;
    private var _maxPasswordLength:int;
    private var _minPasswordLength:int;

    public function RegistrationModelCC(param1:ImageResource = null, param2:Boolean = false, param3:int = 0, param4:int = 0) {
      super();
      this._bgResource = param1;
      this._enableRequiredEmail = param2;
      this._maxPasswordLength = param3;
      this._minPasswordLength = param4;
    }

    public function get bgResource() : ImageResource {
      return this._bgResource;
    }

    public function set bgResource(param1:ImageResource) : void {
      this._bgResource = param1;
    }

    public function get enableRequiredEmail() : Boolean {
      return this._enableRequiredEmail;
    }

    public function set enableRequiredEmail(param1:Boolean) : void {
      this._enableRequiredEmail = param1;
    }

    public function get maxPasswordLength() : int {
      return this._maxPasswordLength;
    }

    public function set maxPasswordLength(param1:int) : void {
      this._maxPasswordLength = param1;
    }

    public function get minPasswordLength() : int {
      return this._minPasswordLength;
    }

    public function set minPasswordLength(param1:int) : void {
      this._minPasswordLength = param1;
    }

    public function toString() : String {
      var local1:String = "RegistrationModelCC [";
      local1 += "bgResource = " + this.bgResource + " ";
      local1 += "enableRequiredEmail = " + this.enableRequiredEmail + " ";
      local1 += "maxPasswordLength = " + this.maxPasswordLength + " ";
      local1 += "minPasswordLength = " + this.minPasswordLength + " ";
      return local1 + "]";
    }
  }
}
