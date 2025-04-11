package alternativa.tanks.camera.controllers.spectator {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.spawn.ITankSpawner;
  import alternativa.tanks.services.bonusregion.IBonusRegionService;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;

  public class PlayerCamera implements KeyboardHandler, BattleEventListener {
    [Inject]
    public static var tankUsersRegistry:TankUsersRegistry;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var bonusRegionService:IBonusRegionService;

    private var focusedUser:Tank;
    private var spectatorController:SpectatorCameraController;

    public function PlayerCamera(param1:SpectatorCameraController) {
      super();
      this.spectatorController = param1;
      battleEventDispatcher.addBattleEventListener(TankUnloadedEvent,this);
      contextMenuService.addEventListener(ContextMenuServiceEvent.FOCUS_ON_USER,this.onFocusOnUser);
    }

    private function onFocusOnUser(param1:ContextMenuServiceEvent) : void {
      var local2:IGameObject = tankUsersRegistry.getUser(param1.userId);
      this.focusOnTank(this.getTank(local2));
    }

    public function handleBattleEvent(param1:Object) : void {
      var local2:Tank = TankUnloadedEvent(param1).tank;
      if(this.focusedUser == local2) {
        this.unfocus();
      }
    }

    public function handleKeyUp(param1:KeyboardEvent) : void {
    }

    public function handleKeyDown(param1:KeyboardEvent) : void {
      this.onKey(param1);
    }

    private function onKey(param1:KeyboardEvent) : void {
      var local2:Tank = null;
      if(param1.ctrlKey) {
        switch(param1.keyCode) {
          case Keyboard.F:
            local2 = this.findNearestUser();
            break;
          case Keyboard.B:
            local2 = this.findNearestUser(BattleTeam.BLUE);
            break;
          case Keyboard.R:
            local2 = this.findNearestUser(BattleTeam.RED);
            break;
          case Keyboard.U:
            this.unfocus();
        }
        if(Boolean(local2)) {
          this.focusOnTank(local2);
        }
      } else if(Boolean(this.focusedUser)) {
        switch(param1.keyCode) {
          case Keyboard.RIGHT:
            this.nextPlayer();
            break;
          case Keyboard.LEFT:
            this.prevPlayer();
        }
      }
    }

    private function findNearestUser(param1:BattleTeam = null) : Tank {
      var local6:IGameObject = null;
      var local7:Tank = null;
      var local8:Number = NaN;
      var local2:Tank = null;
      var local3:Number = 100000000000000000000;
      var local4:GameCamera = this.battleScene().getCamera();
      var local5:Vector3 = new Vector3(local4.x,local4.y,local4.z);
      for each(local6 in tankUsersRegistry.getUsers()) {
        local7 = this.getTank(local6);
        if((param1 == null || local7.teamType == param1) && local7.state == ClientTankState.ACTIVE) {
          local8 = local7.getBody().state.position.distanceTo(local5);
          if(local8 < local3) {
            local3 = local8;
            local2 = local7;
          }
        }
      }
      return local2;
    }

    private function focusOnTank(param1:Tank) : void {
      if(param1 == null) {
        return;
      }
      if(param1.state != ClientTankState.ACTIVE) {
        return;
      }
      this.setRemoteSpawnMode(this.focusedUser);
      this.focusedUser = param1;
      var local2:ITankSpawner = ITankSpawner(this.focusedUser.user.adapt(ITankSpawner));
      local2.setLocal();
      battleService.activateFollowCamera();
      battleService.setFollowCameraTarget(param1);
      bonusRegionService.changeTank(param1);
    }

    public function unfocus() : void {
      if(Boolean(this.focusedUser)) {
        this.setRemoteSpawnMode(this.focusedUser);
        this.focusedUser = null;
        battleService.getBattleScene3D().setCameraController(this.spectatorController);
        bonusRegionService.resetTank();
      }
    }

    private function setRemoteSpawnMode(param1:Tank) : void {
      var local2:ITankSpawner = null;
      if(param1 != null) {
        local2 = ITankSpawner(param1.user.adapt(ITankSpawner));
        local2.setRemote();
      }
    }

    private function nextPlayer() : void {
      this.focusOnTank(this.nextPlayerInDirection(1));
    }

    private function prevPlayer() : void {
      this.focusOnTank(this.nextPlayerInDirection(-1));
    }

    private function nextPlayerInDirection(param1:int) : Tank {
      var local5:Tank = null;
      var local2:Vector.<IGameObject> = tankUsersRegistry.getUsers();
      var local3:int = int(local2.indexOf(this.focusedUser.user));
      if(local3 == -1) {
        return null;
      }
      var local4:int = local3;
      while(true) {
        local4 += param1;
        if(local4 == -1) {
          local4 = local2.length - 1;
        } else if(local4 == local2.length) {
          local4 = 0;
        }
        local5 = this.getTank(local2[local4]);
        if(local5.teamType == this.focusedUser.teamType && local5.state == ClientTankState.ACTIVE) {
          break;
        }
        if(local3 == local4) {
          return null;
        }
      }
      return local5;
    }

    private function getTank(param1:IGameObject) : Tank {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      return local2.getTank();
    }

    private function battleScene() : BattleScene3D {
      return battleService.getBattleScene3D();
    }

    public function close() : void {
      battleEventDispatcher.removeBattleEventListener(TankUnloadedEvent,this);
      contextMenuService.removeEventListener(ContextMenuServiceEvent.FOCUS_ON_USER,this.onFocusOnUser);
    }
  }
}
