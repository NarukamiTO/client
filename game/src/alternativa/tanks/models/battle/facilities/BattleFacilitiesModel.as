package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.BattleFacilitiesModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.IBattleFacilitiesModelBase;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  [ModelInfo]
  public class BattleFacilitiesModel extends BattleFacilitiesModelBase implements IBattleFacilitiesModelBase, BattleFacilities, ObjectLoadPostListener, BattleFacilitiesChecker, TankEntityCreationListener, ObjectUnloadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var battleEventSupport:BattleEventSupport;
    private var diff:Vector3 = new Vector3();
    private var virtualPrevPos:Vector3 = new Vector3();
    private var localTankZone:CheckZone = null;
    private var tankMoves:Dictionary = new Dictionary();

    public function BattleFacilitiesModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.activateHandlers();
    }

    public function register(param1:IGameObject) : void {
      Dictionary(getData(Dictionary))[param1] = param1;
    }

    public function unregister(param1:IGameObject) : void {
      delete Dictionary(getData(Dictionary))[param1];
    }

    public function addCheckZone(param1:IGameObject, param2:Vector3, param3:Number, param4:Boolean) : void {
      CheckZones(getData(CheckZones)).add(param1,param2,param3,param4);
    }

    public function addDynamicCheckZone(param1:IGameObject, param2:Tank, param3:Number, param4:Boolean) : void {
      var local5:CheckZones = CheckZones(getData(CheckZones));
      var local6:CheckZone = local5.addDynamic(param1,param2,param3,param4);
      if(Boolean(localTankInfoService.isLocalTankLoaded()) && localTankInfoService.getLocalTank() == param2) {
        this.localTankZone = local6;
        this.tankMoves = new Dictionary();
      }
    }

    public function removeCheckZone(param1:IGameObject) : void {
      if(!localTankInfoService.isLocalTankLoaded()) {
        this.localTankZone = null;
        this.tankMoves = new Dictionary();
      }
      var local2:CheckZone = CheckZones(getData(CheckZones)).remove(param1);
      if(local2 != null && Boolean(localTankInfoService.isLocalTankLoaded()) && local2.tank == localTankInfoService.getLocalTank()) {
        this.localTankZone = null;
        this.tankMoves = new Dictionary();
      }
    }

    public function objectLoadedPost() : void {
      putData(CheckZones,new CheckZones(battleService.getBattleRunner().getCollisionDetector()));
      putData(Dictionary,new Dictionary());
    }

    public function checkFacilityZonesDemandsStateCorrection(param1:Vector3, param2:Vector3) : Boolean {
      var local4:Vector3 = null;
      var local3:Boolean = CheckZones(getData(CheckZones)).checkZoneChanged(param1,param2);
      if(!local3 && this.localTankZone != null) {
        for each(local4 in this.tankMoves) {
          this.diff.copy(param2).subtract(param1);
          this.virtualPrevPos.copy(local4).add(this.diff);
          if(CheckZones.checkZoneBordersCrossed(this.localTankZone,this.virtualPrevPos,local4)) {
            return true;
          }
        }
      }
      return local3;
    }

    public function onMoveCommand(param1:Tank, param2:Vector3, param3:Vector3) : void {
      if(this.localTankZone != null && param1 != localTankInfoService.getLocalTank()) {
        this.tankMoves[param1] = param3.clone();
      }
    }

    public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var local4:IGameObject = null;
      for each(local4 in Dictionary(getData(Dictionary))) {
        TankEntityCreationListener(local4.event(TankEntityCreationListener)).onTankEntityCreated(param1,param2,param3);
      }
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tankMoves[param1.tank];
    }

    public function objectUnloaded() : void {
      var local1:IGameObject = null;
      for each(local1 in Dictionary(getData(Dictionary))) {
        BattleUnloadListener(local1.event(BattleUnloadListener)).battleUnload();
      }
    }
  }
}
