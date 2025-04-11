package projects.tanks.client.battleselect.model.battle.entrance {
  public interface IBattleEntranceModelBase {
    function enterToBattleFailed() : void;
    function equipmentNotMatchConstraints() : void;
    function fightFailedServerIsHalting() : void;
  }
}
