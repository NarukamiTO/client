package platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SocialNetworkParametersEvents implements SocialNetworkParameters {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function SocialNetworkParametersEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function hasOwnPaymentSystem() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:SocialNetworkParameters = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SocialNetworkParameters(this.impl[i]);
          result = Boolean(m.hasOwnPaymentSystem());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasSocialFunction() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:SocialNetworkParameters = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SocialNetworkParameters(this.impl[i]);
          result = Boolean(m.hasSocialFunction());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
