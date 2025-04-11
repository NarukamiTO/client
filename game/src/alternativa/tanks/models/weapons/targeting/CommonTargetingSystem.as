package alternativa.tanks.models.weapons.targeting {
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.CommonTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.SingleTargetDirectionProcessor;
  import platform.client.fp10.core.type.IGameObject;

  public class CommonTargetingSystem extends TargetingSystem {
    public function CommonTargetingSystem(param1:IGameObject, param2:WeaponObject, param3:Number) {
      var local4:TargetingPriorityCalculator = new TargetingPriorityCalculator(new CommonTargetPriorityCalculator(param2));
      super(new SectorDirectionCalculator(param1,param2,param3,local4),new SingleTargetDirectionProcessor(param1,param3),local4);
    }
  }
}
