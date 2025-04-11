package alternativa.tanks.models.battle.ctf {
  import alternativa.physics.Body;
  import alternativa.tanks.battle.CTFTargetEvaluator;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.battlefield.CommonTargetEvaluatorConst;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.weapon.FlagTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class CTFCommonTargetEvaluator implements CommonTargetEvaluator, CTFTargetEvaluator {
    private static const FLAG_CARRIER_PRIORITY_BONUS:Number = 5;

    private var localTeamType:BattleTeam;
    private var flagTargetEvaluator:FlagTargetEvaluator = new FlagTargetEvaluator();

    public function CTFCommonTargetEvaluator() {
      super();
    }

    public function setLocalTeamType(param1:BattleTeam) : void {
      this.localTeamType = param1;
    }

    public function setFlagCarrier(param1:CommonFlag, param2:Body) : void {
      this.flagTargetEvaluator.setFlagCarrier(param1,param2);
    }

    public function getTargetPriority(param1:Body, param2:Number, param3:Number, param4:Number, param5:Number) : Number {
      var local7:Number = NaN;
      var local6:Tank = param1.tank;
      if(local6.health > 0 && !local6.isSameTeam(this.localTeamType)) {
        local7 = this.flagTargetEvaluator.isCarrier(param1) ? FLAG_CARRIER_PRIORITY_BONUS : 0;
        return CommonTargetEvaluatorConst.MAX_PRIORITY - (CommonTargetEvaluatorConst.DISTANCE_WEIGHT * param2 / param4 + (1 - CommonTargetEvaluatorConst.DISTANCE_WEIGHT) * Math.abs(param3) / param5) + local7;
      }
      return 0;
    }
  }
}
