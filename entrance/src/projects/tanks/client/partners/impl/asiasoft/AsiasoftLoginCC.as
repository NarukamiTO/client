package projects.tanks.client.partners.impl.asiasoft {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class AsiasoftLoginCC {
    private var _facebookIcon:ImageResource;
    private var _googleIcon:ImageResource;
    private var _initialUrl:String;
    private var _playIdIcon:ImageResource;

    public function AsiasoftLoginCC(param1:ImageResource = null, param2:ImageResource = null, param3:String = null, param4:ImageResource = null) {
      super();
      this._facebookIcon = param1;
      this._googleIcon = param2;
      this._initialUrl = param3;
      this._playIdIcon = param4;
    }

    public function get facebookIcon() : ImageResource {
      return this._facebookIcon;
    }

    public function set facebookIcon(param1:ImageResource) : void {
      this._facebookIcon = param1;
    }

    public function get googleIcon() : ImageResource {
      return this._googleIcon;
    }

    public function set googleIcon(param1:ImageResource) : void {
      this._googleIcon = param1;
    }

    public function get initialUrl() : String {
      return this._initialUrl;
    }

    public function set initialUrl(param1:String) : void {
      this._initialUrl = param1;
    }

    public function get playIdIcon() : ImageResource {
      return this._playIdIcon;
    }

    public function set playIdIcon(param1:ImageResource) : void {
      this._playIdIcon = param1;
    }

    public function toString() : String {
      var local1:String = "AsiasoftLoginCC [";
      local1 += "facebookIcon = " + this.facebookIcon + " ";
      local1 += "googleIcon = " + this.googleIcon + " ";
      local1 += "initialUrl = " + this.initialUrl + " ";
      local1 += "playIdIcon = " + this.playIdIcon + " ";
      return local1 + "]";
    }
  }
}
