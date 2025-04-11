package alternativa.tanks.models.tank.spawn {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.TankControlLockBits;
  import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
  import alternativa.tanks.models.battle.battlefield.BattleUnloadEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.LocalTankParams;
  import alternativa.tanks.models.tank.MovementTimeoutAndDistanceAnticheatTask;
  import alternativa.tanks.models.tank.SpawnCameraConfigurator;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.LocalTankFirstTimeSpawner;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.LocalReadyToSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.ReadyToSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn.RemoteReadyToSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.LocalSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.RemoteSpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.SpawnHandler;
  import alternativa.tanks.models.tank.spawn.spawnhandlers.spawn.SpectatorSpawnHandler;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.user.spawn.ITankSpawnerModelBase;
  import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInfo]
  public class TankSpawnerModel extends TankSpawnerModelBase implements ITankSpawner, ITankSpawnerModelBase, ObjectUnloadListener, ObjectLoadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const ZERO_VECTOR_3D:Vector3d = new Vector3d(0,0,0);

    private var battleEventSupport:BattleEventSupport;
    private var logger:Logger;
    private var damageLogger:Logger;
    private var readyToPlaceTask:ReadyToPlaceTask;
    private var spawnCameraConfigurator:SpawnCameraConfigurator;

    public function TankSpawnerModel() {
      super();
      this.logger = logService.getLogger("tank");
      this.damageLogger = logService.getLogger("damage");
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(BattleUnloadEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
    }

    private function onBattleFinish(param1:*) : void {
      this.removeReadyToPlaceTask();
    }

    public function prepareToSpawn(param1:Vector3d, param2:Vector3d) : void {
      this.spawnCameraConfigurator.setupCamera(param1,param2);
      this.removeReadyToPlaceTask();
      this.readyToPlaceTask = new ReadyToPlaceTask(battleService.getRespawnDurationMs(),object);
      battleService.getBattleRunner().addLogicUnit(this.readyToPlaceTask);
    }

    public function spawn(param1:BattleTeam, param2:Vector3d, param3:Vector3d, param4:int, param5:int) : void {
      var local8:Boolean = false;
      var local9:int = 0;
      var local10:int = 0;
      var local11:MovementTimeoutAndDistanceAnticheatTask = null;
      var local12:SpawnHandler = null;
      var local6:ITankModel = ITankModel(object.adapt(ITankModel));
      var local7:Tank = local6.getTank();
      if(local6.isLocal()) {
        LocalTankParams.teamType = param1;
        server.confirmSpawn(param5);
      }
      if(local7 != null) {
        local6.removeTankFromBattle();
        local7.getWeaponMount().reset();
        local7.spawn(param1,param5);
        local7.setSemiActivatedState();
        local6.doSetHealth(param4);
        local6.unlockMovementControl(TankControlLockBits.DEAD | TankControlLockBits.DISABLED);
        local8 = Boolean(local6.getUserInfo().isLocal);
        local9 = local8 ? int(local6.getChassisController().getControlState()) : 0;
        local10 = local8 ? TrackedChassis.TURN_SPEED_COUNT : 0;
        local6.setChassisState(param2,param3,ZERO_VECTOR_3D,ZERO_VECTOR_3D,local9,local10);
        local7.resetInterpolatedState();
        local11 = local6.getMovementAnticheatTask();
        if(Boolean(local11)) {
          local11.updateLatestServerTankPosition(param2,param3);
        }
        local12 = SpawnHandler(getData(SpawnHandler));
        local12.spawn(local7,battleService.getBattle());
        local6.addTankToBattle();
      }
    }

    public function getIncarnationId() : int {
      return getInitParam().incarnationId;
    }

    public function objectLoaded() : void {
      var local2:Boolean = false;
      var local1:ITankModel = ITankModel(object.adapt(ITankModel));
      if(local1.isLocal()) {
        local2 = Boolean(battleService.isLocalTankFirstLoad());
        this.spawnCameraConfigurator = new SpawnCameraConfigurator(local2);
        if(local2) {
          putData(LocalTankFirstTimeSpawner,new LocalTankFirstTimeSpawner(object,server));
        }
        battleService.setLocalTankLoaded();
        putData(ReadyToSpawnHandler,new LocalReadyToSpawnHandler(object,server));
        putData(SpawnHandler,new LocalSpawnHandler());
        if(Boolean(this.readyToPlaceTask)) {
          this.readyToPlaceTask.setTankObject(object);
        }
      } else {
        putData(ReadyToSpawnHandler,new RemoteReadyToSpawnHandler(object));
        putData(SpawnHandler,new RemoteSpawnHandler());
      }
    }

    public function setLocal() : void {
      putData(SpawnHandler,new SpectatorSpawnHandler());
    }

    public function setRemote() : void {
      putData(SpawnHandler,new RemoteSpawnHandler());
    }

    public function readyToSpawn() : void {
      var local1:ReadyToSpawnHandler = ReadyToSpawnHandler(getData(ReadyToSpawnHandler));
      local1.handleReadyToSpawn();
    }

    public function setReadyToPlace() : void {
      this.removeReadyToPlaceTask();
      server.setReadyToPlace();
    }

    private function removeReadyToPlaceTask() : void {
      if(Boolean(this.readyToPlaceTask)) {
        battleService.getBattleRunner().removeLogicUnit(this.readyToPlaceTask);
        this.readyToPlaceTask = null;
      }
    }

    public function objectUnloaded() : void {
      var local1:ITankModel = ITankModel(object.adapt(ITankModel));
      if(local1.isLocal()) {
        this.spawnCameraConfigurator = null;
        if(Boolean(this.readyToPlaceTask)) {
          this.readyToPlaceTask.setTankObject(null);
        }
      }
    }
  }
}
