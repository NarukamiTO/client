package alternativa.tanks.servermodels.partners {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ICompositePartnerModelEvents implements ICompositePartnerModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ICompositePartnerModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loadPartnerObject(param1:String) : void {
      var i:int = 0;
      var m:ICompositePartnerModel = null;
      var partnerId:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICompositePartnerModel(this.impl[i]);
          m.loadPartnerObject(partnerId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function finishRegistration(param1:String, param2:String) : void {
      var i:int = 0;
      var m:ICompositePartnerModel = null;
      var uid:String = param1;
      var domain:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICompositePartnerModel(this.impl[i]);
          m.finishRegistration(uid,domain);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function bindAccount(param1:String, param2:String) : void {
      var i:int = 0;
      var m:ICompositePartnerModel = null;
      var login:String = param1;
      var password:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ICompositePartnerModel(this.impl[i]);
          m.bindAccount(login,password);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
