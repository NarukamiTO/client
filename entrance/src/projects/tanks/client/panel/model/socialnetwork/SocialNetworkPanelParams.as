package projects.tanks.client.panel.model.socialnetwork {
  public class SocialNetworkPanelParams {
    private var _authorizationUrl:String;
    private var _enabled:Boolean;
    private var _linkExists:Boolean;
    private var _snId:String;

    public function SocialNetworkPanelParams(param1:String = null, param2:Boolean = false, param3:Boolean = false, param4:String = null) {
      super();
      this._authorizationUrl = param1;
      this._enabled = param2;
      this._linkExists = param3;
      this._snId = param4;
    }

    public function get authorizationUrl() : String {
      return this._authorizationUrl;
    }

    public function set authorizationUrl(param1:String) : void {
      this._authorizationUrl = param1;
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function get linkExists() : Boolean {
      return this._linkExists;
    }

    public function set linkExists(param1:Boolean) : void {
      this._linkExists = param1;
    }

    public function get snId() : String {
      return this._snId;
    }

    public function set snId(param1:String) : void {
      this._snId = param1;
    }

    public function toString() : String {
      var local1:String = "SocialNetworkPanelParams [";
      local1 += "authorizationUrl = " + this.authorizationUrl + " ";
      local1 += "enabled = " + this.enabled + " ";
      local1 += "linkExists = " + this.linkExists + " ";
      local1 += "snId = " + this.snId + " ";
      return local1 + "]";
    }
  }
}
