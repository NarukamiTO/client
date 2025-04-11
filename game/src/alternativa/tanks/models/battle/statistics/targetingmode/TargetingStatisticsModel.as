package alternativa.tanks.models.battle.statistics.targetingmode {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.statistics.targetingmode.ITargetingStatisticsModelBase;
  import projects.tanks.client.battlefield.models.statistics.targetingmode.TargetingStatisticsModelBase;

  [ModelInfo]
  public class TargetingStatisticsModel extends TargetingStatisticsModelBase implements ITargetingStatisticsModelBase, ObjectLoadListener, ObjectUnloadListener, BattleEventListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var gameObject:IGameObject;
    private var spawned:Boolean;

    public function TargetingStatisticsModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      battleEventDispatcher.addBattleEventListener(TankAddedToBattleEvent,this);
      this.gameObject = object;
      this.spawned = false;
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      battleEventDispatcher.removeBattleEventListener(TankAddedToBattleEvent,this);
      this.gameObject = null;
    }

    public function handleBattleEvent(param1:Object) : void {
      var local2:TankAddedToBattleEvent = param1 as TankAddedToBattleEvent;
      if(local2 != null && local2.isLocal) {
        this.spawned = true;
      }
    }
  }
}
