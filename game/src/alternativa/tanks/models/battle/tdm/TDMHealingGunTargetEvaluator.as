package alternativa.tanks.models.battle.tdm {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.TeamDMTargetEvaluator;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.shared.HealingGunTargetEvaluator;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TDMHealingGunTargetEvaluator implements HealingGunTargetEvaluator, TeamDMTargetEvaluator {
    private static const ACCURACY:Number = 0.0001;

    private var localTeamType:BattleTeam;

    public function TDMHealingGunTargetEvaluator() {
      super();
    }

    public function setLocalTeamType(param1:BattleTeam) : void {
      this.localTeamType = param1;
    }

    public function getTargetPriority(param1:Body) : Number {
      var local3:int = 0;
      var local2:Tank = param1.tank;
      if(local2.isSameTeam(this.localTeamType)) {
        local3 = 0;
        if(local2.getTemperature() > ACCURACY) {
          local3 = 5;
        } else if(local2.getTemperature() < -ACCURACY) {
          local3 = 4;
        }
        return local2.health > local2.getMaxHealth() - ACCURACY ? 1 : 3 + local3;
      }
      return 2;
    }
  }
}
