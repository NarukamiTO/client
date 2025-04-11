package alternativa.tanks.models.battle.dm {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.weapon.ricochet.DMRicochetTargetEvaluator;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleservice.model.battle.dm.BattleDMModelBase;
  import projects.tanks.client.battleservice.model.battle.dm.IBattleDMModelBase;

  [ModelInfo]
  public class BattleDMModel extends BattleDMModelBase implements IBattleDMModelBase, ObjectLoadPostListener, ObjectUnloadListener, BattleModel {
    [Inject]
    public static var battleService:BattleService;

    public function BattleDMModel() {
      super();
    }

    public function getBattleType() : BattleType {
      return BattleType.DM;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      battleService.setCommonTargetEvaluator(new DMCommonTargetEvaluator());
      battleService.setHealingGunTargetEvaluator(new DMHealingGunTargetEvaluator());
      battleService.setRailgunTargetEvaluator(new DMRailgunTargetEvaluator());
      battleService.setRicochetTargetEvaluator(new DMRicochetTargetEvaluator());
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      battleService.setCommonTargetEvaluator(null);
      battleService.setHealingGunTargetEvaluator(null);
      battleService.setRailgunTargetEvaluator(null);
      battleService.setRicochetTargetEvaluator(null);
    }
  }
}
