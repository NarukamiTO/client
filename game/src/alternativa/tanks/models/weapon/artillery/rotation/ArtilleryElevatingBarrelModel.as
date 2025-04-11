package alternativa.tanks.models.weapon.artillery.rotation {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.controllers.BarrelElevator;
  import alternativa.tanks.models.tank.AddToBattleListener;
  import alternativa.tanks.models.tank.DestroyTankPart;
  import alternativa.tanks.models.tank.InitTankPart;
  import alternativa.tanks.models.tank.RemoveFromBattleListener;
  import alternativa.tanks.models.tank.WeaponMountProvider;
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAngles;
  import alternativa.tanks.models.weapon.artillery.IArtilleryModel;
  import alternativa.tanks.models.weapon.artillery.VerticalAngleView;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.common.asWeaponCommon;
  import alternativa.tanks.models.weapon.turret.TurretStateSender;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.ArtilleryElevatingBarrelCC;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.ArtilleryElevatingBarrelModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.BarrelElevationCommand;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation.IArtilleryElevatingBarrelModelBase;

  [ModelInfo]
  public class ArtilleryElevatingBarrelModel extends ArtilleryElevatingBarrelModelBase implements IArtilleryElevatingBarrelModelBase, ObjectLoadListener, InitTankPart, DestroyTankPart, TurretStateSender, WeaponMountProvider, AddToBattleListener, RemoveFromBattleListener {
    [Inject]
    public static var battleService:BattleService;

    public function ArtilleryElevatingBarrelModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:ArtilleryElevatingBarrelCC = getInitParam();
      var local2:BarrelElevationCommand = new BarrelElevationCommand(local1.control,local1.elevation);
      this.saveState(local2);
    }

    public function createWeaponMount(param1:IGameObject) : WeaponMount {
      var local2:Number = Number(this.asArtilleryModel().getDefaultElevation());
      var local3:WeaponCommonData = asWeaponCommon(object).getCommonData();
      var local4:VerticalAngles = VerticalAngles(object.adapt(VerticalAngles));
      var local5:BarrelElevator = new BarrelElevator(local2,-local4.getAngleDown(),local4.getAngleUp(),local3.getMaxTurretRotationSpeed(),local3.getTurretRotationAcceleration());
      putData(BarrelElevator,local5);
      local5.setBarrelElevation(this.getState().elevation);
      local5.setUserControl(this.getState().control);
      return local5;
    }

    private function asArtilleryModel() : IArtilleryModel {
      return IArtilleryModel(object.adapt(IArtilleryModel));
    }

    public function initTankPart(param1:Tank) : void {
      var local2:BarrelElevationController = null;
      var local3:BarrelStateUpdater = null;
      putData(Tank,param1);
      if(BattleUtils.isLocalTank(param1.user)) {
        local2 = new BarrelElevationController(param1,this.getBarrelElevator());
        putData(BarrelElevationController,local2);
        local2.enable();
        local3 = new BarrelStateUpdater(this.getBarrelElevator(),getFunctionWrapper(this.updateStateOnServer));
        putData(BarrelStateUpdater,local3);
        putData(VerticalAngleView,new VerticalAngleView(param1.user,this.asArtilleryModel().getWeapon()));
      }
    }

    private function getBarrelElevator() : BarrelElevator {
      return BarrelElevator(getData(BarrelElevator));
    }

    private function getBarrelStateUpdater() : BarrelStateUpdater {
      return BarrelStateUpdater(getData(BarrelStateUpdater));
    }

    public function destroyTankPart() : void {
      var local1:BarrelElevationController = BarrelElevationController(getData(BarrelElevationController));
      if(local1 != null) {
        local1.disable();
      }
      var local2:VerticalAngleView = VerticalAngleView(getData(VerticalAngleView));
      if(local2 != null) {
        local2.close();
      }
    }

    private function updateStateOnServer() : void {
      var local1:BarrelElevator = this.getBarrelElevator();
      var local2:BarrelElevationCommand = this.getState();
      local2.elevation = local1.getBarrelPhysicsElevation();
      local2.control = local1.getRealControl();
      server.update(battleService.getPhysicsTime(),this.getTank().incarnation,local2);
    }

    public function onAddToBattle() : void {
      var local1:BarrelStateUpdater = this.getBarrelStateUpdater();
      if(local1 != null) {
        local1.reset();
        battleService.getBattleRunner().addLogicUnit(local1);
      }
      var local2:BarrelElevationController = BarrelElevationController(getData(BarrelElevationController));
      if(local2 != null) {
        local2.onAddToBattle();
      }
    }

    public function onRemoveFromBattle() : void {
      var local1:BarrelStateUpdater = this.getBarrelStateUpdater();
      if(local1 != null) {
        battleService.getBattleRunner().removeLogicUnit(local1);
      } else {
        this.getBarrelElevator().setUserControl(BarrelElevator.STOP);
      }
    }

    public function sendTurretState() : void {
      this.getBarrelStateUpdater().reset();
      this.updateStateOnServer();
    }

    public function update(param1:BarrelElevationCommand) : void {
      this.saveState(param1);
      var local2:BarrelElevator = this.getBarrelElevator();
      local2.setBarrelElevation(param1.elevation);
      local2.setUserControl(param1.control);
    }

    private function getTank() : Tank {
      return Tank(getData(Tank));
    }

    private function saveState(param1:BarrelElevationCommand) : void {
      putData(BarrelElevationCommand,param1);
    }

    private function getState() : BarrelElevationCommand {
      return BarrelElevationCommand(getData(BarrelElevationCommand));
    }
  }
}
