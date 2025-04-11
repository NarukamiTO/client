package alternativa.tanks.servermodels.changeuid {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IChangeUidEvents implements IChangeUid {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IChangeUidEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkChangeUidHash(param1:String, param2:String) : void {
      var i:int = 0;
      var m:IChangeUid = null;
      var changeUidHash:String = param1;
      var email:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IChangeUid(this.impl[i]);
          m.checkChangeUidHash(changeUidHash,email);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function changeUidAndPassword(param1:String, param2:String) : void {
      var i:int = 0;
      var m:IChangeUid = null;
      var newUid:String = param1;
      var newPassword:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IChangeUid(this.impl[i]);
          m.changeUidAndPassword(newUid,newPassword);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function changeUid(param1:String) : void {
      var i:int = 0;
      var m:IChangeUid = null;
      var newUid:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IChangeUid(this.impl[i]);
          m.changeUid(newUid);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
