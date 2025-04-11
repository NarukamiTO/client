package alternativa.tanks.models.weapons.targeting {
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.ShaftTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
  import platform.client.fp10.core.type.IGameObject;

  public class ShaftTargetingSystem extends TargetingSystem {
    public function ShaftTargetingSystem(param1:IGameObject, param2:WeaponObject, param3:Number) {
      var local4:TargetingPriorityCalculator = new TargetingPriorityCalculator(new ShaftTargetPriorityCalculator(param2));
      super(new SectorDirectionCalculator(param1,param2,param3,local4),new SingleTargetDirectionProcessor(param1,param3),local4);
    }
  }
}
