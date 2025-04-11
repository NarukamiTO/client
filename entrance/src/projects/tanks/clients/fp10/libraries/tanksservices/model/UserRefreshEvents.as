package projects.tanks.clients.fp10.libraries.tanksservices.model {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  public class UserRefreshEvents implements UserRefresh {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UserRefreshEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      var i:int = 0;
      var m:UserRefresh = null;
      var userId:Long = param1;
      var consumer:UserInfoConsumer = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserRefresh(this.impl[i]);
          m.refresh(userId,consumer);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function remove(param1:Long) : void {
      var i:int = 0;
      var m:UserRefresh = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserRefresh(this.impl[i]);
          m.remove(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
