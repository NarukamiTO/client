package projects.tanks.clients.fp10.libraries.tanksservices.service.premium {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;

  public interface BattleUserPremiumService extends IEventDispatcher {
    function hasUserPremium(param1:Long) : Boolean;
    function setUsersPremium(param1:Vector.<UserInfo>) : *;
    function resetUserPremium(param1:Long) : *;
    function removeUsersPremium() : void;
  }
}
