package alternativa.tanks.models.weapons.targeting.direction.sector.splitter {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapons.targeting.direction.*;
  import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;

  public class SectorsSplitter {
    private const DIRECTIONS_PER_SECTOR:int = 16;

    private var targetPriority:TargetingPriorityCalculator;
    private var matrix:Matrix3 = new Matrix3();
    private var direction:Vector3 = new Vector3();
    private var directions:Vector.<TargetingDirection> = new Vector.<TargetingDirection>();
    private var currentOverlapSectors:SortedTargetingSectors = new SortedTargetingSectors();

    public function SectorsSplitter(param1:TargetingPriorityCalculator) {
      super();
      this.targetPriority = param1;
    }

    public function splitSectorsOnDirections(param1:AllGlobalGunParams, param2:Vector.<TargetingSector>) : Vector.<TargetingDirection> {
      var local4:TargetingSector = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local3:Number = Number.NEGATIVE_INFINITY;
      this.directions.length = 0;
      this.currentOverlapSectors.clear();
      for each(local4 in param2) {
        local5 = local4.getLeft();
        while(!this.currentOverlapSectors.isEmpty() && local3 < local5) {
          local6 = Math.min(this.currentOverlapSectors.getRight(),local5);
          this.addDirections(param1,local3,local6);
          this.currentOverlapSectors.removeSectorsWhichRightCoordIsLessOrEqualThan(local6);
          local3 = local6;
        }
        local3 = local5;
        this.currentOverlapSectors.add(local4);
      }
      while(!this.currentOverlapSectors.isEmpty()) {
        local6 = this.currentOverlapSectors.getRight();
        this.addDirections(param1,local3,local6);
        this.currentOverlapSectors.removeSectorsWhichRightCoordIsLessOrEqualThan(local6);
        local3 = local6;
      }
      return this.directions;
    }

    private function addDirections(param1:AllGlobalGunParams, param2:Number, param3:Number) : void {
      var local9:Vector3 = null;
      var local4:Number = param3 - param2;
      var local5:Number = local4 / this.DIRECTIONS_PER_SECTOR;
      var local6:Number = param2 + local5 * 0.5;
      var local7:Vector.<TargetingSector> = this.currentOverlapSectors.getOrderedByDistance();
      this.matrix.fromAxisAngle(param1.elevationAxis,local6);
      this.matrix.transformVector(param1.direction,this.direction);
      this.matrix.fromAxisAngle(param1.elevationAxis,local5);
      var local8:int = 0;
      while(local8 < this.DIRECTIONS_PER_SECTOR) {
        this.directions.push(new TargetingDirection(this.direction,local6,this.targetPriority.getPriorityForSectors(local6,local7)));
        local9 = BattleUtils.tmpVector;
        local9.copy(this.direction);
        this.matrix.transformVector(local9,this.direction);
        local6 += local5;
        local8++;
      }
      if(param2 <= 0 && 0 <= param3) {
        this.directions.push(new TargetingDirection(param1.direction,0,this.targetPriority.getPriorityForSectors(0,local7)));
      }
    }
  }
}
