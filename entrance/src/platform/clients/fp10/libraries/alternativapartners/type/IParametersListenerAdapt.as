package platform.clients.fp10.libraries.alternativapartners.type {
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IParametersListenerAdapt implements IParametersListener {
    private var object:IGameObject;
    private var impl:IParametersListener;

    public function IParametersListenerAdapt(param1:IGameObject, param2:IParametersListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onSetParameters(param1:LoginParameters) : void {
      var parameters:LoginParameters = param1;
      try {
        Model.object = this.object;
        this.impl.onSetParameters(parameters);
      }
      finally {
        Model.popObject();
      }
    }

    public function onFailSetParameters() : void {
      try {
        Model.object = this.object;
        this.impl.onFailSetParameters();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
