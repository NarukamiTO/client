package alternativa.tanks.models.tank.spawn.spawnhandlers {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.MapBuildingCompleteEvent;
  import alternativa.tanks.models.tank.pause.ITankPause;
  import alternativa.tanks.services.battlereadiness.BattleReadinessService;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerModelServer;

  public class LocalTankFirstTimeSpawner implements AutoClosable, BattleEventListener {
    [Inject]
    public static var battleReadinessService:BattleReadinessService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var user:IGameObject;
    private var server:TankSpawnerModelServer;

    public function LocalTankFirstTimeSpawner(param1:IGameObject, param2:TankSpawnerModelServer) {
      super();
      this.user = param1;
      this.server = param2;
      var local3:ITankPause = ITankPause(param1.adapt(ITankPause));
      local3.resetIdleKickTime();
      if(battleReadinessService.isMapReady()) {
        this.spawn();
      } else {
        battleEventDispatcher.addBattleEventListener(MapBuildingCompleteEvent,this);
      }
    }

    public function handleBattleEvent(param1:Object) : void {
      this.spawn();
    }

    private function spawn() : void {
      Model.object = this.user;
      this.server.readyToSpawnCommand();
      Model.popObject();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.user = null;
      this.server = null;
      battleEventDispatcher.removeBattleEventListener(MapBuildingCompleteEvent,this);
    }
  }
}
