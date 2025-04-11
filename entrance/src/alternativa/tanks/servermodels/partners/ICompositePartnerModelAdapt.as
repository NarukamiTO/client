package alternativa.tanks.servermodels.partners {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ICompositePartnerModelAdapt implements ICompositePartnerModel {
    private var object:IGameObject;
    private var impl:ICompositePartnerModel;

    public function ICompositePartnerModelAdapt(param1:IGameObject, param2:ICompositePartnerModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loadPartnerObject(param1:String) : void {
      var partnerId:String = param1;
      try {
        Model.object = this.object;
        this.impl.loadPartnerObject(partnerId);
      }
      finally {
        Model.popObject();
      }
    }

    public function finishRegistration(param1:String, param2:String) : void {
      var uid:String = param1;
      var domain:String = param2;
      try {
        Model.object = this.object;
        this.impl.finishRegistration(uid,domain);
      }
      finally {
        Model.popObject();
      }
    }

    public function bindAccount(param1:String, param2:String) : void {
      var login:String = param1;
      var password:String = param2;
      try {
        Model.object = this.object;
        this.impl.bindAccount(login,password);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
