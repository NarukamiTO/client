package projects.tanks.client.battlefield.models.bonus.battle.battlefield {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;

  public interface IBattlefieldBonusesModelBase {
    function attemptToTakeBonusFailedTankNotActive(param1:Long) : void;
    function bonusTaken(param1:Long) : void;
    function removeBonuses(param1:Vector.<Long>) : void;
    function spawnBonuses(param1:Vector.<BonusSpawnData>) : void;
    function spawnBonusesOnGround(param1:Vector.<BonusSpawnData>) : void;
  }
}
