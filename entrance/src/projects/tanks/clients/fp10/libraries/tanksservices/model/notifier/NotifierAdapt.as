package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class NotifierAdapt implements Notifier {
    private var object:IGameObject;
    private var impl:Notifier;

    public function NotifierAdapt(param1:IGameObject, param2:Notifier) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function subscribe(param1:Long, param2:UserInfoConsumer) : void {
      var userId:Long = param1;
      var consumer:UserInfoConsumer = param2;
      try {
        Model.object = this.object;
        this.impl.subscribe(userId,consumer);
      }
      finally {
        Model.popObject();
      }
    }

    public function unSubscribe(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.unSubscribe(userId);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
