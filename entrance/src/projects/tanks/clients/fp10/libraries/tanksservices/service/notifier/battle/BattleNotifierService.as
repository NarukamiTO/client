package projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;

  public class BattleNotifierService extends EventDispatcher implements IBattleNotifierService {
    public function BattleNotifierService() {
      super();
    }

    public function setBattle(param1:Vector.<BattleLinkData>) : void {
      dispatchEvent(new SetBattleNotifierServiceEvent(SetBattleNotifierServiceEvent.SET_BATTLE,param1));
    }

    public function leaveBattle(param1:Long) : void {
      dispatchEvent(new LeaveBattleNotifierServiceEvent(LeaveBattleNotifierServiceEvent.LEAVE,param1));
    }
  }
}
