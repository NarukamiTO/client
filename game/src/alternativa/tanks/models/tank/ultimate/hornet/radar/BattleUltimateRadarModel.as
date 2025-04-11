package alternativa.tanks.models.tank.ultimate.hornet.radar {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.display.usertitle.TitleConfigFlags;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.BattleUltimateRadarCC;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.BattleUltimateRadarModelBase;
  import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.IBattleUltimateRadarModelBase;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class BattleUltimateRadarModel extends BattleUltimateRadarModelBase implements IBattleUltimateRadarModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private var battleRadarHudIndicators:BattleRadarHudIndicators;
    private var battleEventSupport:BattleEventSupport;
    private var discoveredTanksIds:Vector.<Long> = new Vector.<Long>();
    private var tanksInBattle:Dictionary = new Dictionary();

    public function BattleUltimateRadarModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      var local2:Tank = param1.tank;
      var local3:Long = local2.getUser().id;
      this.tanksInBattle[local3] = local2;
      if(this.isDiscovered(local3)) {
        this.revealTank(local2);
      }
    }

    private function isDiscovered(param1:Long) : Boolean {
      return this.discoveredTanksIds.indexOf(param1) >= 0;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      var local2:Tank = param1.tank;
      var local3:Long = local2.getUser().id;
      delete this.tanksInBattle[local3];
      if(this.isDiscovered(local3)) {
        this.concealTank(local2);
      }
    }

    public function objectLoadedPost() : void {
      var local1:BattleUltimateRadarCC = null;
      if(this.isModelActive()) {
        local1 = getInitParam();
        this.battleRadarHudIndicators = new BattleRadarHudIndicators(local1);
        battleService.getBattleScene3D().addRenderer(this.battleRadarHudIndicators);
        this.discoveredTanksIds = Vector.<Long>(local1.discoveredTanksIds);
        this.battleEventSupport.activateHandlers();
      }
    }

    private function isModelActive() : Boolean {
      return !battleInfoService.isSpectatorMode();
    }

    public function updateDiscoveredTanksList(param1:Vector.<Long>) : void {
      this.concealTanks(this.discoveredTanksIds);
      this.discoveredTanksIds = Vector.<Long>(param1);
      this.revealTanks(param1);
    }

    private function concealTanks(param1:Vector.<Long>) : void {
      var local2:Long = null;
      var local3:Tank = null;
      for each(local2 in param1) {
        local3 = this.tanksInBattle[local2];
        if(local3 != null) {
          this.concealTank(local3);
        }
      }
    }

    private function revealTanks(param1:Vector.<Long>) : void {
      var local2:Long = null;
      var local3:Tank = null;
      for each(local2 in param1) {
        local3 = this.tanksInBattle[local2];
        if(local3 != null) {
          this.revealTank(local3);
        }
      }
    }

    private function revealTank(param1:Tank) : void {
      if(!this.isBoss(param1.getUser())) {
        this.battleRadarHudIndicators.addTankMarker(param1);
      }
      param1.getTitle().setConfigurationFlags(TitleConfigFlags.FORCE_HEALTH,true);
    }

    private function concealTank(param1:Tank) : void {
      this.battleRadarHudIndicators.removeTankMarker(param1);
      param1.getTitle().setConfigurationFlags(TitleConfigFlags.FORCE_HEALTH,false);
    }

    private function isBoss(param1:IGameObject) : Boolean {
      return IBossState(param1.adapt(IBossState)).role() == BossRelationRole.BOSS;
    }

    public function objectUnloaded() : void {
      if(this.isModelActive()) {
        battleService.getBattleScene3D().removeRenderer(this.battleRadarHudIndicators);
        this.battleRadarHudIndicators = null;
        this.battleEventSupport.deactivateHandlers();
      }
    }
  }
}
