package projects.tanks.client.battleselect.model.battleselect.create {
  public interface IBattleCreateModelBase {
    function createFailedBattleCreateDisabled() : void;
    function createFailedServerIsHalting() : void;
    function createFailedTooManyBattlesFromYou() : void;
    function createFailedYouAreBanned() : void;
    function setFilteredBattleName(param1:String) : void;
  }
}
