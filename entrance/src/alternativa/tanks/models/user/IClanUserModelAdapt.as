package alternativa.tanks.models.user {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IClanUserModelAdapt implements IClanUserModel {
    private var object:IGameObject;
    private var impl:IClanUserModel;

    public function IClanUserModelAdapt(param1:IGameObject, param2:IClanUserModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function loadingInServiceSpace() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.loadingInServiceSpace());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function addInClan(param1:IGameObject) : void {
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.addInClan(clan);
      }
      finally {
        Model.popObject();
      }
    }

    public function rejectAll() : void {
      try {
        Model.object = this.object;
        this.impl.rejectAll();
      }
      finally {
        Model.popObject();
      }
    }

    public function revoke(param1:IGameObject) : void {
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.revoke(clan);
      }
      finally {
        Model.popObject();
      }
    }

    public function reject(param1:IGameObject) : void {
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.reject(clan);
      }
      finally {
        Model.popObject();
      }
    }

    public function acceptRequest(param1:IGameObject) : void {
      var clan:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.acceptRequest(clan);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
