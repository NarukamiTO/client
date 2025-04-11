package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier {
  import alternativa.types.Long;

  [ModelInterface]
  public interface Notifier {
    function subscribe(param1:Long, param2:UserInfoConsumer) : void;
    function unSubscribe(param1:Long) : void;
  }
}
