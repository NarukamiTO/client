package projects.tanks.clients.fp10.libraries.tanksservices.model {
  import alternativa.types.Long;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  [ModelInterface]
  public interface UserRefresh {
    function refresh(param1:Long, param2:UserInfoConsumer) : void;
    function remove(param1:Long) : void;
  }
}
