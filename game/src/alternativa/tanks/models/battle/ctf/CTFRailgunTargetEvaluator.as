package alternativa.tanks.models.battle.ctf {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.CTFTargetEvaluator;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.weapon.FlagTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class CTFRailgunTargetEvaluator implements RailgunTargetEvaluator, CTFTargetEvaluator {
    private var localTeamType:BattleTeam;
    private var flagTargetEvaluator:FlagTargetEvaluator = new FlagTargetEvaluator();

    public function CTFRailgunTargetEvaluator() {
      super();
    }

    public function getHitEfficiency(param1:Body) : Number {
      var local2:Tank = param1.tank;
      if(local2.health <= 0) {
        return 0;
      }
      if(local2.isSameTeam(this.localTeamType)) {
        return 0;
      }
      if(this.flagTargetEvaluator.isCarrier(param1)) {
        return 10;
      }
      return 1;
    }

    public function setLocalTeamType(param1:BattleTeam) : void {
      this.localTeamType = param1;
    }

    public function setFlagCarrier(param1:CommonFlag, param2:Body) : void {
      this.flagTargetEvaluator.setFlagCarrier(param1,param2);
    }

    public function isFriendly(param1:Body) : Boolean {
      var local2:Tank = param1.tank;
      return local2.isSameTeam(this.localTeamType);
    }
  }
}
