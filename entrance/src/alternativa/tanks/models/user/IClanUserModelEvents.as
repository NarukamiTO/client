package alternativa.tanks.models.user {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanUserModelEvents implements IClanUserModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanUserModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loadingInServiceSpace() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IClanUserModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserModel(this.impl[i]);
          result = Boolean(m.loadingInServiceSpace());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function addInClan(param1:IGameObject) : void {
      var i:int = 0;
      var m:IClanUserModel = null;
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserModel(this.impl[i]);
          m.addInClan(clan);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function rejectAll() : void {
      var i:int = 0;
      var m:IClanUserModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserModel(this.impl[i]);
          m.rejectAll();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function revoke(param1:IGameObject) : void {
      var i:int = 0;
      var m:IClanUserModel = null;
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserModel(this.impl[i]);
          m.revoke(clan);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function reject(param1:IGameObject) : void {
      var i:int = 0;
      var m:IClanUserModel = null;
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserModel(this.impl[i]);
          m.reject(clan);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function acceptRequest(param1:IGameObject) : void {
      var i:int = 0;
      var m:IClanUserModel = null;
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanUserModel(this.impl[i]);
          m.acceptRequest(clan);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
