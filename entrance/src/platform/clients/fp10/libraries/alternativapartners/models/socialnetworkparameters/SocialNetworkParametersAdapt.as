package platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SocialNetworkParametersAdapt implements SocialNetworkParameters {
    private var object:IGameObject;
    private var impl:SocialNetworkParameters;

    public function SocialNetworkParametersAdapt(param1:IGameObject, param2:SocialNetworkParameters) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function hasOwnPaymentSystem() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasOwnPaymentSystem());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasSocialFunction() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasSocialFunction());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
