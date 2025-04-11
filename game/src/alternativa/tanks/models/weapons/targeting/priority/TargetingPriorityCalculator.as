package alternativa.tanks.models.weapons.targeting.priority {
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.models.weapons.targeting.direction.sector.TargetingSector;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.TargetPriorityCalculator;

  public class TargetingPriorityCalculator {
    private var priorityEvalutor:TargetPriorityCalculator;
    private var weakingCoef:Number;

    public function TargetingPriorityCalculator(param1:TargetPriorityCalculator, param2:Number = 0) {
      super();
      this.priorityEvalutor = param1;
      this.weakingCoef = param2;
    }

    public function getPriorityForSectors(param1:Number, param2:Vector.<TargetingSector>) : Number {
      var local5:TargetingSector = null;
      var local3:Number = 0;
      var local4:int = param2.length - 1;
      while(local4 >= 0) {
        local5 = param2[local4];
        local3 = Math.max(this.getPriorityForSector(local5,param1) + this.weakingCoef * local3,local3);
        local4--;
      }
      return local3;
    }

    private function getPriorityForSector(param1:TargetingSector, param2:Number) : Number {
      return this.priorityEvalutor.getTargetPriority(param1.getTank(),param1.getDistance(),param2);
    }

    public function getPriorityForRayHits(param1:Number, param2:Vector.<RayHit>) : Number {
      var local5:RayHit = null;
      var local3:Number = 1;
      var local4:Number = 0;
      for each(local5 in param2) {
        local4 += this.getPriorityForRayHit(param1,local5) * local3;
        local3 *= this.weakingCoef;
      }
      return local4;
    }

    private function getPriorityForRayHit(param1:Number, param2:RayHit) : Number {
      var local3:Body = param2.shape.body;
      if(param2.staticHit) {
        return 0;
      }
      return this.priorityEvalutor.getTargetPriority(local3.tank,param2.t,param1);
    }
  }
}
