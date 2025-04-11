package alternativa.tanks.models.battle.tdm {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.TeamDMTargetEvaluator;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TDMRailgunTargetEvaluator implements RailgunTargetEvaluator, TeamDMTargetEvaluator {
    private var localTeamType:BattleTeam;

    public function TDMRailgunTargetEvaluator() {
      super();
    }

    public function setLocalTeamType(param1:BattleTeam) : void {
      this.localTeamType = param1;
    }

    public function getHitEfficiency(param1:Body) : Number {
      var local2:Tank = param1.tank;
      if(local2.health <= 0) {
        return 0;
      }
      if(local2.isSameTeam(this.localTeamType)) {
        return 0;
      }
      return 1;
    }

    public function isFriendly(param1:Body) : Boolean {
      var local2:Tank = param1.tank;
      return local2.isSameTeam(this.localTeamType);
    }
  }
}
