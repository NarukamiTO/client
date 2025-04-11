package projects.tanks.clients.fp10.libraries.tanksservices.service.probattle {
  import flash.events.IEventDispatcher;

  public interface IUserProBattleService extends IEventDispatcher {
    function hasAbonement() : Boolean;
    function setAbonementRemainingTimeSec(param1:int) : void;
  }
}
