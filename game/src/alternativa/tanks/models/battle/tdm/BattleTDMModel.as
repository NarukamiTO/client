package alternativa.tanks.models.battle.tdm {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.TeamDMTargetEvaluator;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.weapon.ricochet.TeamDMRicochetTargetEvaluator;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleservice.model.battle.tdm.BattleTDMModelBase;
  import projects.tanks.client.battleservice.model.battle.tdm.IBattleTDMModelBase;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInfo]
  public class BattleTDMModel extends BattleTDMModelBase implements IBattleTDMModelBase, ObjectLoadPostListener, ObjectUnloadListener, BattleEventListener, BattleModel {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var targetEvaluators:Vector.<TeamDMTargetEvaluator>;

    public function BattleTDMModel() {
      super();
    }

    public function getBattleType() : BattleType {
      return BattleType.TDM;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      this.targetEvaluators = new Vector.<TeamDMTargetEvaluator>();
      var local1:TDMCommonTargetEvaluator = new TDMCommonTargetEvaluator();
      battleService.setCommonTargetEvaluator(local1);
      this.targetEvaluators.push(local1);
      var local2:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
      battleService.setHealingGunTargetEvaluator(local2);
      this.targetEvaluators.push(local2);
      var local3:TDMRailgunTargetEvaluator = new TDMRailgunTargetEvaluator();
      battleService.setRailgunTargetEvaluator(local3);
      this.targetEvaluators.push(local3);
      var local4:TeamDMRicochetTargetEvaluator = new TeamDMRicochetTargetEvaluator();
      battleService.setRicochetTargetEvaluator(local4);
      this.targetEvaluators.push(local4);
      battleEventDispatcher.addBattleEventListener(LocalTankActivationEvent,this);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.targetEvaluators = null;
      battleService.setCommonTargetEvaluator(null);
      battleService.setHealingGunTargetEvaluator(null);
      battleService.setRailgunTargetEvaluator(null);
      battleService.setRicochetTargetEvaluator(null);
      battleEventDispatcher.removeBattleEventListener(LocalTankActivationEvent,this);
    }

    public function handleBattleEvent(param1:Object) : void {
      var local3:TeamDMTargetEvaluator = null;
      var local2:BattleTeam = LocalTankActivationEvent(param1).tank.teamType;
      for each(local3 in this.targetEvaluators) {
        local3.setLocalTeamType(local2);
      }
    }
  }
}
