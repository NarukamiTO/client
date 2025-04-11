package alternativa.tanks.battle {
  import alternativa.physics.Body;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;

  public interface CTFTargetEvaluator extends TeamDMTargetEvaluator {
    function setFlagCarrier(param1:CommonFlag, param2:Body) : void;
  }
}
