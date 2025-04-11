package alternativa.tanks.models.weapon.ricochet {
  import alternativa.physics.Body;

  public interface RicochetTargetEvaluator {
    function getTargetPriority(param1:Body, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Number;
  }
}
