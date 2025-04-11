package projects.tanks.clients.flash.commons.models.externalauth {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ExternalAuthApiAdapt implements ExternalAuthApi {
    private var object:IGameObject;
    private var impl:ExternalAuthApi;

    public function ExternalAuthApiAdapt(param1:IGameObject, param2:ExternalAuthApi) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initLogin(param1:String) : void {
      var provider:String = param1;
      try {
        Model.object = this.object;
        this.impl.initLogin(provider);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
