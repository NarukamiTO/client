package alternativa.tanks.models.weapons.targeting {
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.PenetratingTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.DirectionProcessorForPenetratingWeapons;
  import platform.client.fp10.core.type.IGameObject;

  public class PenetratingTargetingSystem extends TargetingSystem {
    private var MAX_DISTANCE:Number = 10000000000;

    public function PenetratingTargetingSystem(param1:IGameObject, param2:WeaponObject, param3:Number) {
      var local4:TargetingPriorityCalculator = new TargetingPriorityCalculator(new PenetratingTargetPriorityCalculator(param2),param3);
      super(new SectorDirectionCalculator(param1,param2,this.MAX_DISTANCE,local4),new DirectionProcessorForPenetratingWeapons(param1,this.MAX_DISTANCE),local4);
    }
  }
}
