package alternativa.tanks.models.weapon.turret {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
  import alternativa.tanks.battle.objects.tank.controllers.Turret;
  import alternativa.tanks.models.tank.AddToBattleListener;
  import alternativa.tanks.models.tank.InitTankPart;
  import alternativa.tanks.models.tank.RemoveFromBattleListener;
  import alternativa.tanks.models.tank.WeaponMountProvider;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.common.asWeaponCommon;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.turret.IRotatingTurretModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.turret.RotatingTurretModelBase;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  [ModelInfo]
  public class RotatingTurretModel extends RotatingTurretModelBase implements IRotatingTurretModelBase, IRotatingTurretModel, ObjectLoadListener, InitTankPart, TurretStateSender, WeaponMountProvider, AddToBattleListener, RemoveFromBattleListener {
    [Inject]
    public static var battleService:BattleService;

    public function RotatingTurretModel() {
      super();
    }

    public static function copyStateFromTurret(param1:Turret, param2:TurretStateCommand) : void {
      param2.controlType = param1.getTurretRealControlType();
      param2.controlInput = param1.getTurretRealControlInput();
      param2.direction = param1.getTurretPhysicsDirection();
      param2.rotationSpeedNumber = param1.getTurretTurnSpeedNumber();
    }

    public function objectLoaded() : void {
      this.saveState(getInitParam().turretState);
    }

    public function createWeaponMount(param1:IGameObject) : WeaponMount {
      var local2:WeaponCommonData = asWeaponCommon(object).getCommonData();
      var local3:Turret = new Turret(local2.getMaxTurretRotationSpeed(),local2.getTurretRotationAcceleration());
      putData(Turret,local3);
      this.setTurretState(local3,this.getState());
      return local3;
    }

    public function initTankPart(param1:Tank) : void {
      var local2:LocalTurretController = null;
      var local3:TurretStateUpdater = null;
      putData(Tank,param1);
      if(BattleUtils.isLocalTank(param1.user)) {
        local2 = new LocalTurretController(param1,this.getTurret());
        putData(LocalTurretController,local2);
        local3 = new TurretStateUpdater(this.getTurret(),getFunctionWrapper(this.updateStateOnServer));
        putData(TurretStateUpdater,local3);
      }
    }

    private function updateStateOnServer() : void {
      var local1:Turret = this.getTurret();
      var local2:TurretStateCommand = this.getState();
      copyStateFromTurret(local1,local2);
      var local3:int = int(battleService.getBattleRunner().getPhysicsTime());
      var local4:int = this.getTank().incarnation;
      server.update(local3,local4,local2);
    }

    public function getLocalTurretController() : LocalTurretController {
      return LocalTurretController(getData(LocalTurretController));
    }

    public function update(param1:TurretStateCommand) : void {
      this.saveState(param1);
      var local2:TurretStateCommand = param1;
      var local3:Turret = this.getTurret();
      if(local2.controlType == TurretControlType.ROTATION_DIRECTION) {
        local3.setRemoteDirection(local2.direction);
      }
      local3.setTurretControlState(local2.controlType,local2.controlInput,local2.rotationSpeedNumber);
    }

    private function setTurretState(param1:Turret, param2:TurretStateCommand) : void {
      if(param2.controlType == TurretControlType.ROTATION_DIRECTION) {
        param1.setTurretPhysicsDirection(param2.direction);
      }
      param1.setTurretControlState(param2.controlType,param2.controlInput,param2.rotationSpeedNumber);
    }

    public function sendTurretState() : void {
      this.getUpdater().reset();
      this.updateStateOnServer();
    }

    public function onAddToBattle() : void {
      var local2:TurretStateUpdater = null;
      var local1:LocalTurretController = this.getLocalTurretController();
      if(local1 != null) {
        local1.enable();
        local1.onAddToBattle();
        local2 = this.getUpdater();
        local2.reset();
        battleService.getBattleRunner().addLogicUnit(local2);
      }
    }

    public function onRemoveFromBattle() : void {
      var local1:TurretStateUpdater = this.getUpdater();
      if(local1 != null) {
        this.getLocalTurretController().disable();
        battleService.getBattleRunner().removeLogicUnit(local1);
      } else {
        this.getTurret().setTurretControlState(TurretControlType.ROTATION_DIRECTION,0,0);
      }
    }

    public function getTurret() : Turret {
      return Turret(getData(Turret));
    }

    private function getTank() : Tank {
      return Tank(getData(Tank));
    }

    private function saveState(param1:TurretStateCommand) : void {
      putData(TurretStateCommand,param1);
    }

    private function getState() : TurretStateCommand {
      return TurretStateCommand(getData(TurretStateCommand));
    }

    private function getUpdater() : TurretStateUpdater {
      return TurretStateUpdater(getData(TurretStateUpdater));
    }
  }
}
