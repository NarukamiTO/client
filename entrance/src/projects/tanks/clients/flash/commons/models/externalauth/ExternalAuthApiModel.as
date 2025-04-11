package projects.tanks.clients.flash.commons.models.externalauth {
  import flash.external.ExternalInterface;
  import flash.utils.Dictionary;
  import projects.tanks.client.commons.models.externalauth.ExternalAuthApiModelBase;
  import projects.tanks.client.commons.models.externalauth.ExternalAuthParameters;
  import projects.tanks.client.commons.models.externalauth.IExternalAuthApiModelBase;

  [ModelInfo]
  public class ExternalAuthApiModel extends ExternalAuthApiModelBase implements IExternalAuthApiModelBase, ExternalAuthApi {
    private static const CALLBACK_NAME:String = "authorizeLoginParams";
    private static const LOGIN_METHOD_NAME:String = "loginViaExternal";

    public function ExternalAuthApiModel() {
      super();
    }

    private function authorize(param1:String, param2:Object) : void {
      var local4:String = null;
      var local5:String = null;
      var local3:Dictionary = new Dictionary();
      for(local4 in param2) {
        local5 = param2[local4];
        local3[local4] = local5;
      }
      server.authorize(param1,new ExternalAuthParameters(local3));
      ExternalInterface.addCallback(CALLBACK_NAME,null);
    }

    public function initLogin(param1:String) : void {
      if(ExternalInterface.available) {
        ExternalInterface.addCallback(CALLBACK_NAME,getFunctionWrapper(this.authorize));
        ExternalInterface.call(LOGIN_METHOD_NAME,param1);
      }
    }
  }
}
