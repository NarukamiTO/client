package projects.tanks.clients.fp10.libraries.tanksservices.model.uidcheck {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UidCheckServiceAdapt implements UidCheckService {
    private var object:IGameObject;
    private var impl:UidCheckService;

    public function UidCheckServiceAdapt(param1:IGameObject, param2:UidCheckService) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMaxLength() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMaxLength());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function exist(param1:String, param2:Function) : void {
      var uid:String = param1;
      var callback:Function = param2;
      try {
        Model.object = this.object;
        this.impl.exist(uid,callback);
      }
      finally {
        Model.popObject();
      }
    }

    public function validate(param1:String, param2:Function) : void {
      var uid:String = param1;
      var callback:Function = param2;
      try {
        Model.object = this.object;
        this.impl.validate(uid,callback);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
