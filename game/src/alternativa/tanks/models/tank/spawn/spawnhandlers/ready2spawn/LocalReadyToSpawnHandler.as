package alternativa.tanks.models.tank.spawn.spawnhandlers.ready2spawn {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.PauseActivationEvent;
  import alternativa.tanks.battle.events.PauseDeactivationEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerModelServer;

  public class LocalReadyToSpawnHandler implements ReadyToSpawnHandler, AutoClosable {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var localUser:IGameObject;
    private var server:TankSpawnerModelServer;
    private var battleEventSupport:BattleEventSupport;
    private var isPauseActive:Boolean;
    private var isSpawnCommandScheduled:Boolean;

    public function LocalReadyToSpawnHandler(param1:IGameObject, param2:TankSpawnerModelServer) {
      super();
      this.localUser = param1;
      this.server = param2;
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(PauseActivationEvent,this.onPauseActivated);
      this.battleEventSupport.addEventHandler(PauseDeactivationEvent,this.onPauseDeactivated);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.activateHandlers();
    }

    private function onPauseActivated(param1:Object) : void {
      this.isPauseActive = true;
    }

    private function onPauseDeactivated(param1:Object) : void {
      this.isPauseActive = false;
      if(this.isSpawnCommandScheduled) {
        this.sendReadyToSpawnCommand();
      }
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      if(param1.tank.getUser() == this.localUser) {
        this.isSpawnCommandScheduled = false;
      }
    }

    public function handleReadyToSpawn() : void {
      var local1:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
      local1.removeTankFromBattle();
      var local2:BossRelationRole = IBossState(this.localUser.adapt(IBossState)).role();
      if(this.isPauseActive && local2 == BossRelationRole.VICTIM) {
        this.isSpawnCommandScheduled = true;
      } else {
        this.sendReadyToSpawnCommand();
      }
    }

    private function sendReadyToSpawnCommand() : void {
      this.isSpawnCommandScheduled = false;
      Model.object = this.localUser;
      this.server.readyToSpawnCommand();
      Model.popObject();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.localUser = null;
      this.server = null;
      this.battleEventSupport.deactivateHandlers();
      this.battleEventSupport = null;
    }
  }
}
