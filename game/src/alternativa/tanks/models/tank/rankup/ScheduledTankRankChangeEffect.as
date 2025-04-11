package alternativa.tanks.models.tank.rankup {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;

  public class ScheduledTankRankChangeEffect implements BattleEventListener, AutoClosable {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var user:IGameObject;
    private var rankIndex:int;

    public function ScheduledTankRankChangeEffect(param1:IGameObject, param2:int) {
      super();
      this.user = param1;
      this.rankIndex = param2;
      battleEventDispatcher.addBattleEventListener(TankAddedToBattleEvent,this);
    }

    public function handleBattleEvent(param1:Object) : void {
      var local4:ITankRankUpEffectModel = null;
      var local2:TankAddedToBattleEvent = TankAddedToBattleEvent(param1);
      var local3:ITankModel = ITankModel(this.user.adapt(ITankModel));
      if(local2.tank == local3.getTank()) {
        local4 = ITankRankUpEffectModel(this.user.adapt(ITankRankUpEffectModel));
        local4.showRankUpEffect(this.rankIndex);
        this.close();
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.user = null;
      battleEventDispatcher.removeBattleEventListener(TankAddedToBattleEvent,this);
    }
  }
}
