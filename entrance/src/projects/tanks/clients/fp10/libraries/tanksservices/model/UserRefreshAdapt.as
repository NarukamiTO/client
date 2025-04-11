package projects.tanks.clients.fp10.libraries.tanksservices.model {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  public class UserRefreshAdapt implements UserRefresh {
    private var object:IGameObject;
    private var impl:UserRefresh;

    public function UserRefreshAdapt(param1:IGameObject, param2:UserRefresh) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      var userId:Long = param1;
      var consumer:UserInfoConsumer = param2;
      try {
        Model.object = this.object;
        this.impl.refresh(userId,consumer);
      }
      finally {
        Model.popObject();
      }
    }

    public function remove(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.remove(userId);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
