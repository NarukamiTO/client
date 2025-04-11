package alternativa.tanks.models.bonus.battlefield {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.bonuses.Bonus;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.battlefield.BattlefieldEvents;
  import alternativa.tanks.models.effects.common.IBonusCommonModel;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;
  import projects.tanks.client.battlefield.models.bonus.battle.battlefield.BattlefieldBonusesModelBase;
  import projects.tanks.client.battlefield.models.bonus.battle.battlefield.IBattlefieldBonusesModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class BattlefieldBonusesModel extends BattlefieldBonusesModelBase implements IBattlefieldBonusesModelBase, BattleEventListener, BattlefieldEvents {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var userInfoService:BattleUserInfoService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var bonuses:Dictionary = new Dictionary();

    public function BattlefieldBonusesModel() {
      super();
      battleEventDispatcher.addBattleEventListener(BattleFinishEvent,this);
    }

    public function handleBattleEvent(param1:Object) : void {
      this.removeAllBonuses();
    }

    private function removeAllBonuses() : void {
      var local1:* = undefined;
      for(local1 in this.bonuses) {
        this.removeBonus(local1);
      }
    }

    private function spawnBonus(param1:IGameObject, param2:Long, param3:Vector3d, param4:int, param5:Boolean) : void {
      var local6:IBonusCommonModel = null;
      var local7:Bonus = null;
      if(param1 != null) {
        local6 = IBonusCommonModel(param1.adapt(IBonusCommonModel));
        local7 = local6.getBonus(param2);
        local7.spawn(new Vector3(param3.x,param3.y,param3.z),param4,getInitParam().bonusFallSpeed,param5,getFunctionWrapper(this.onBonusTankCollision));
        this.bonuses[local7.bonusId] = local7;
      }
    }

    private function onBonusTankCollision(param1:Bonus) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.attemptToTakeBonus(param1.bonusId);
    }

    [Obfuscation(rename="false")]
    public function spawnBonuses(param1:Vector.<BonusSpawnData>) : void {
      var local2:BonusSpawnData = null;
      if(param1 != null) {
        for each(local2 in param1) {
          this.spawnBonus(local2.battleBonusObject,local2.bonusId,local2.spawnPosition,0,false);
        }
      }
    }

    [Obfuscation(rename="false")]
    public function removeBonuses(param1:Vector.<Long>) : void {
      var local2:Long = null;
      if(param1 != null) {
        for each(local2 in param1) {
          this.removeBonus(local2);
        }
      }
    }

    private function removeBonus(param1:Long) : void {
      var local2:Bonus = this.bonuses[param1];
      if(local2 != null) {
        delete this.bonuses[param1];
        local2.remove();
      }
    }

    [Obfuscation(rename="false")]
    public function bonusTaken(param1:Long) : void {
      var local2:Bonus = this.bonuses[param1];
      if(local2 != null) {
        delete this.bonuses[param1];
        local2.pickup();
      }
    }

    [Obfuscation(rename="false")]
    public function attemptToTakeBonusFailedTankNotActive(param1:Long) : void {
      var local2:Bonus = this.bonuses[param1];
      if(local2 != null) {
        local2.enableTrigger();
      }
    }

    public function onBattleLoaded() : void {
      this.createExistingBonuses();
    }

    private function createExistingBonuses() : void {
      var local1:BonusSpawnData = null;
      for each(local1 in getInitParam().bonuses) {
        this.spawnBonus(local1.battleBonusObject,local1.bonusId,local1.spawnPosition,local1.lifeTime,false);
      }
      getInitParam().bonuses = null;
    }

    [Obfuscation(rename="false")]
    public function spawnBonusesOnGround(param1:Vector.<BonusSpawnData>) : void {
      var local2:BonusSpawnData = null;
      for each(local2 in param1) {
        this.spawnBonus(local2.battleBonusObject,local2.bonusId,local2.spawnPosition,0,true);
      }
    }
  }
}
