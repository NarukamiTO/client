package alternativa.tanks.models.battle.jgr {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.battle.battlefield.BattleModel;
  import alternativa.tanks.models.battle.battlefield.BattleType;
  import alternativa.tanks.models.battle.dm.DMCommonTargetEvaluator;
  import alternativa.tanks.models.battle.dm.DMHealingGunTargetEvaluator;
  import alternativa.tanks.models.battle.dm.DMRailgunTargetEvaluator;
  import alternativa.tanks.models.weapon.ricochet.DMRicochetTargetEvaluator;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import projects.tanks.client.battleservice.model.battle.jgr.BattleJGRModelBase;
  import projects.tanks.client.battleservice.model.battle.jgr.IBattleJGRModelBase;

  [ModelInfo]
  public class BattleJGRModel extends BattleJGRModelBase implements IBattleJGRModelBase, BattleModel, ObjectLoadPostListener {
    [Inject]
    public static var battleService:BattleService;

    public function BattleJGRModel() {
      super();
    }

    public function getBattleType() : BattleType {
      return BattleType.JGR;
    }

    public function objectLoadedPost() : void {
      battleService.setCommonTargetEvaluator(new DMCommonTargetEvaluator());
      battleService.setHealingGunTargetEvaluator(new DMHealingGunTargetEvaluator());
      battleService.setRailgunTargetEvaluator(new DMRailgunTargetEvaluator());
      battleService.setRicochetTargetEvaluator(new DMRicochetTargetEvaluator());
    }
  }
}
