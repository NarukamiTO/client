package platform.client.core.general.socialnetwork.types {
  import flash.utils.Dictionary;

  public class LoginParameters {
    private var _parameters:Dictionary;

    public function LoginParameters(param1:Dictionary = null) {
      super();
      this._parameters = param1;
    }

    public function get parameters() : Dictionary {
      return this._parameters;
    }

    public function set parameters(param1:Dictionary) : void {
      this._parameters = param1;
    }

    public function toString() : String {
      var local1:String = "LoginParameters [";
      local1 += "parameters = " + this.parameters + " ";
      return local1 + "]";
    }
  }
}
