package alternativa.tanks.models.battle.tdm {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.TeamDMTargetEvaluator;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.battlefield.CommonTargetEvaluatorConst;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TDMCommonTargetEvaluator implements CommonTargetEvaluator, TeamDMTargetEvaluator {
    private var localTeamType:BattleTeam;

    public function TDMCommonTargetEvaluator() {
      super();
    }

    public function setLocalTeamType(param1:BattleTeam) : void {
      this.localTeamType = param1;
    }

    public function getTargetPriority(param1:Body, param2:Number, param3:Number, param4:Number, param5:Number) : Number {
      var local6:Tank = param1.tank;
      if(local6.health > 0 && !local6.isSameTeam(this.localTeamType)) {
        return CommonTargetEvaluatorConst.MAX_PRIORITY - (CommonTargetEvaluatorConst.DISTANCE_WEIGHT * param2 / param4 + (1 - CommonTargetEvaluatorConst.DISTANCE_WEIGHT) * Math.abs(param3) / param5);
      }
      return 0;
    }
  }
}
