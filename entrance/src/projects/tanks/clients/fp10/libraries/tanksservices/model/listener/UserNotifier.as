package projects.tanks.clients.fp10.libraries.tanksservices.model.listener {
  import alternativa.types.Long;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  [ModelInterface]
  public interface UserNotifier {
    function getDataConsumer(param1:Long) : UserInfoConsumer;
    function hasDataConsumer(param1:Long) : Boolean;
    function subcribe(param1:Long, param2:UserInfoConsumer) : void;
    function refresh(param1:Long, param2:UserInfoConsumer) : void;
    function unsubcribe(param1:Vector.<Long>) : void;
    function getCurrentUserId() : Long;
  }
}
