package projects.tanks.clients.flash.commons.models.layout {
  import projects.tanks.client.commons.models.layout.LayoutState;

  [ModelInterface]
  public interface ILobbyLayout {
    function showGarage() : void;
    function showBattleSelect() : void;
    function showMatchmaking() : void;
    function showBattleLobby() : void;
    function showClan() : void;
    function exitFromBattle() : void;
    function exitFromBattleToState(param1:LayoutState) : void;
    function returnToBattle() : void;
  }
}
