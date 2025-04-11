package alternativa.tanks.models.weapons.targeting.priority.targeting {
  import alternativa.tanks.battle.objects.tank.Tank;

  public interface TargetPriorityCalculator {
    function getTargetPriority(param1:Tank, param2:Number, param3:Number) : Number;
  }
}
