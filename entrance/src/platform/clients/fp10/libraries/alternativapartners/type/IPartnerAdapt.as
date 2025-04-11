package platform.clients.fp10.libraries.alternativapartners.type {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IPartnerAdapt implements IPartner {
    private var object:IGameObject;
    private var impl:IPartner;

    public function IPartnerAdapt(param1:IGameObject, param2:IPartner) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var listener:IParametersListener = param1;
      try {
        Model.object = this.object;
        this.impl.getLoginParameters(listener);
      }
      finally {
        Model.popObject();
      }
    }

    public function hasPaymentAction() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasPaymentAction());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function paymentAction() : void {
      try {
        Model.object = this.object;
        this.impl.paymentAction();
      }
      finally {
        Model.popObject();
      }
    }

    public function getFailRedirectUrl() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getFailRedirectUrl();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isExternalLoginAllowed() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isExternalLoginAllowed());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasRatings() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasRatings());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
