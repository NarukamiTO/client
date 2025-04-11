package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class NotifierEvents implements Notifier {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function NotifierEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function subscribe(param1:Long, param2:UserInfoConsumer) : void {
      var i:int = 0;
      var m:Notifier = null;
      var userId:Long = param1;
      var consumer:UserInfoConsumer = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Notifier(this.impl[i]);
          m.subscribe(userId,consumer);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function unSubscribe(param1:Long) : void {
      var i:int = 0;
      var m:Notifier = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Notifier(this.impl[i]);
          m.unSubscribe(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
