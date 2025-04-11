package alternativa.tanks.servermodels.changeuid {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IChangeUidAdapt implements IChangeUid {
    private var object:IGameObject;
    private var impl:IChangeUid;

    public function IChangeUidAdapt(param1:IGameObject, param2:IChangeUid) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkChangeUidHash(param1:String, param2:String) : void {
      var changeUidHash:String = param1;
      var email:String = param2;
      try {
        Model.object = this.object;
        this.impl.checkChangeUidHash(changeUidHash,email);
      }
      finally {
        Model.popObject();
      }
    }

    public function changeUidAndPassword(param1:String, param2:String) : void {
      var newUid:String = param1;
      var newPassword:String = param2;
      try {
        Model.object = this.object;
        this.impl.changeUidAndPassword(newUid,newPassword);
      }
      finally {
        Model.popObject();
      }
    }

    public function changeUid(param1:String) : void {
      var newUid:String = param1;
      try {
        Model.object = this.object;
        this.impl.changeUid(newUid);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
