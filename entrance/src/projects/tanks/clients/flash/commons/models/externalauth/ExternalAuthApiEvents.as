package projects.tanks.clients.flash.commons.models.externalauth {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ExternalAuthApiEvents implements ExternalAuthApi {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ExternalAuthApiEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initLogin(param1:String) : void {
      var i:int = 0;
      var m:ExternalAuthApi = null;
      var provider:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ExternalAuthApi(this.impl[i]);
          m.initLogin(provider);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
