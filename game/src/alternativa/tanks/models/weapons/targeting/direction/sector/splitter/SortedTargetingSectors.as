package alternativa.tanks.models.weapons.targeting.direction.sector.splitter {
  import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector;

  public class SortedTargetingSectors {
    private var orderByRight:Vector.<TargetingSector> = new Vector.<TargetingSector>();
    private var orderByDistance:Vector.<TargetingSector> = new Vector.<TargetingSector>();

    public function SortedTargetingSectors() {
      super();
    }

    public function clear() : void {
      this.orderByRight.length = 0;
      this.orderByDistance.length = 0;
    }

    public function getOrderedByDistance() : Vector.<TargetingSector> {
      return this.orderByDistance;
    }

    public function getRight() : Number {
      var local1:TargetingSector = this.orderByRight[0];
      return local1.getRight();
    }

    public function isEmpty() : Boolean {
      return this.orderByRight.length == 0;
    }

    public function add(param1:TargetingSector) : void {
      var local2:Number = NaN;
      var local3:TargetingSector = null;
      var local4:TargetingSector = null;
      local2 = 0;
      while(local2 < this.orderByRight.length) {
        local3 = this.orderByRight[local2];
        if(param1.getRight() < local3.getRight()) {
          break;
        }
        local2++;
      }
      this.orderByRight.splice(local2,0,param1);
      local2 = 0;
      while(local2 < this.orderByDistance.length) {
        local4 = this.orderByDistance[local2];
        if(param1.getDistance() < local4.getDistance()) {
          break;
        }
        local2++;
      }
      this.orderByDistance.splice(local2,0,param1);
    }

    public function removeSectorsWhichRightCoordIsLessOrEqualThan(param1:Number) : void {
      var local2:TargetingSector = null;
      while(this.orderByRight.length > 0) {
        local2 = TargetingSector(this.orderByRight[0]);
        if(local2.getRight() > param1) {
          break;
        }
        this.removeSector(this.orderByRight[0]);
      }
    }

    private function removeSector(param1:TargetingSector) : void {
      this.removeElement(this.orderByRight,param1);
      this.removeElement(this.orderByDistance,param1);
    }

    private function removeElement(param1:Vector.<TargetingSector>, param2:TargetingSector) : void {
      param1.splice(param1.indexOf(param2),1);
    }
  }
}
