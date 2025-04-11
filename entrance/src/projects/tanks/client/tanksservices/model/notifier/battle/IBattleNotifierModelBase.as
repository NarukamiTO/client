package projects.tanks.client.tanksservices.model.notifier.battle {
  import alternativa.types.Long;

  public interface IBattleNotifierModelBase {
    function leaveBattle(param1:Long) : void;
    function leaveGroup(param1:Long) : void;
    function setBattle(param1:Vector.<BattleNotifierData>) : void;
  }
}
