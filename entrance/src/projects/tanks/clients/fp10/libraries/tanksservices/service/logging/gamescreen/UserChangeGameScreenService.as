package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen {
  import flash.events.IEventDispatcher;

  public interface UserChangeGameScreenService extends IEventDispatcher {
    function switchGarage() : void;
    function switchBattleSelect() : void;
    function switchMatchmaking() : void;
    function questWindowOpened() : void;
    function exitFromBattleToMatchmaking() : void;
    function exitFromBattleToGarage() : void;
    function exitFromBattleToClan() : void;
    function exitFromGame() : void;
    function enterBattle() : void;
    function paymentWindowOpened() : void;
    function paymentWindowClosed() : void;
    function questWindowClosed() : void;
    function friendWindowClosed() : void;
    function settingsWindowClosed() : void;
    function showUserStatistics() : void;
    function switchClan() : void;
    function returnToBattle() : void;
  }
}
