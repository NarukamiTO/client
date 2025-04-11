package alternativa.tanks.models.weapon.shared {
  import alternativa.physics.Body;

  public interface RailgunTargetEvaluator {
    function getHitEfficiency(param1:Body) : Number;
    function isFriendly(param1:Body) : Boolean;
  }
}
