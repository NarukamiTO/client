package alternativa.tanks.models.weapon.shared {
  import alternativa.physics.Body;

  public interface CommonTargetEvaluator {
    function getTargetPriority(param1:Body, param2:Number, param3:Number, param4:Number, param5:Number) : Number;
  }
}
