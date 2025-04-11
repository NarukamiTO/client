package projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UidCheckServiceEvents implements UidCheckService {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UidCheckServiceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMaxLength() : int {
      var result:int = 0;
      var i:int = 0;
      var m:UidCheckService = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UidCheckService(this.impl[i]);
          result = int(m.getMaxLength());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function exist(param1:String, param2:Function) : void {
      var i:int = 0;
      var m:UidCheckService = null;
      var uid:String = param1;
      var callback:Function = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UidCheckService(this.impl[i]);
          m.exist(uid,callback);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function validate(param1:String, param2:Function) : void {
      var i:int = 0;
      var m:UidCheckService = null;
      var uid:String = param1;
      var callback:Function = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UidCheckService(this.impl[i]);
          m.validate(uid,callback);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
