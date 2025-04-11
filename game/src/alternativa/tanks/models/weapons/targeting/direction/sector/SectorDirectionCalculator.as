package alternativa.tanks.models.weapons.targeting.direction.sector {
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapons.targeting.direction.TargetingDirection;
  import alternativa.tanks.models.weapons.targeting.direction.TargetingDirectionCalculator;
  import alternativa.tanks.models.weapons.targeting.direction.sector.splitter.SectorsSplitter;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import platform.client.fp10.core.type.IGameObject;

  public class SectorDirectionCalculator implements TargetingDirectionCalculator {
    private var targetingSectorsCalculator:TargetingSectorsCalculator;
    private var sectorsSplitter:SectorsSplitter;

    public function SectorDirectionCalculator(param1:IGameObject, param2:WeaponObject, param3:Number, param4:TargetingPriorityCalculator) {
      super();
      this.targetingSectorsCalculator = new TargetingSectorsCalculator(param1,param2,param3);
      this.sectorsSplitter = new SectorsSplitter(param4);
    }

    public function getDirections(param1:AllGlobalGunParams) : Vector.<TargetingDirection> {
      var local2:Vector.<TargetingSector> = this.targetingSectorsCalculator.getSectors(param1);
      return this.sectorsSplitter.splitSectorsOnDirections(param1,local2);
    }
  }
}
