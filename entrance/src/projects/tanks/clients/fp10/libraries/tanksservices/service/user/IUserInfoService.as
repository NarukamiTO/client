package projects.tanks.clients.fp10.libraries.tanksservices.service.user {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  public interface IUserInfoService {
    function init(param1:IGameObject) : void;
    function getOrCreateUpdater(param1:Long) : IUserInfoLabelUpdater;
    function hasConsumer(param1:Long) : Boolean;
    function getConsumer(param1:Long) : UserInfoConsumer;
    function forciblySubscribe(param1:Long) : void;
    function unload() : void;
    function getCurrentUserId() : Long;
    function isOffer() : Boolean;
    function setOffer(param1:Boolean) : void;
    function hasPremium(param1:Long) : Boolean;
  }
}
