package projects.tanks.client.entrance.model.entrance.externalentrance {
  public class SocialNetworkEntranceParams {
    private var _authorizationUrl:String;
    private var _enabled:Boolean;
    private var _snId:String;

    public function SocialNetworkEntranceParams(param1:String = null, param2:Boolean = false, param3:String = null) {
      super();
      this._authorizationUrl = param1;
      this._enabled = param2;
      this._snId = param3;
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

    public function get snId() : String {
      return this._snId;
    }

    public function set snId(param1:String) : void {
      this._snId = param1;
    }

    public function toString() : String {
      var local1:String = "SocialNetworkEntranceParams [";
      local1 += "authorizationUrl = " + this.authorizationUrl + " ";
      local1 += "enabled = " + this.enabled + " ";
      local1 += "snId = " + this.snId + " ";
      return local1 + "]";
    }
  }
}
