package projects.tanks.clients.fp10.libraries.tanksservices.model.listener {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  public class UserNotifierEvents implements UserNotifier {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UserNotifierEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDataConsumer(param1:Long) : UserInfoConsumer {
      var result:UserInfoConsumer = null;
      var i:int = 0;
      var m:UserNotifier = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserNotifier(this.impl[i]);
          result = m.getDataConsumer(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasDataConsumer(param1:Long) : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:UserNotifier = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserNotifier(this.impl[i]);
          result = Boolean(m.hasDataConsumer(userId));
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function subcribe(param1:Long, param2:UserInfoConsumer) : void {
      var i:int = 0;
      var m:UserNotifier = null;
      var userId:Long = param1;
      var consumer:UserInfoConsumer = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserNotifier(this.impl[i]);
          m.subcribe(userId,consumer);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      var i:int = 0;
      var m:UserNotifier = null;
      var userId:Long = param1;
      var consumer:UserInfoConsumer = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserNotifier(this.impl[i]);
          m.refresh(userId,consumer);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function unsubcribe(param1:Vector.<Long>) : void {
      var i:int = 0;
      var m:UserNotifier = null;
      var usersId:Vector.<Long> = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserNotifier(this.impl[i]);
          m.unsubcribe(usersId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getCurrentUserId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:UserNotifier = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserNotifier(this.impl[i]);
          result = m.getCurrentUserId();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
