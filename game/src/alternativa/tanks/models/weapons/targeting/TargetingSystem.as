package alternativa.tanks.models.weapons.targeting {
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapons.targeting.debug.TargetingVisualDebug;
  import alternativa.tanks.models.weapons.targeting.direction.TargetingDirection;
  import alternativa.tanks.models.weapons.targeting.direction.TargetingDirectionCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.TargetingDirectionProcessor;

  public class TargetingSystem {
    private static const visualDebug:TargetingVisualDebug = new TargetingVisualDebug();

    private var directionCalculator:TargetingDirectionCalculator;
    private var priorityCalculator:TargetingPriorityCalculator;
    private var directionProcessor:TargetingDirectionProcessor;
    private var result:TargetingResult = new TargetingResult();

    public function TargetingSystem(param1:TargetingDirectionCalculator, param2:TargetingDirectionProcessor, param3:TargetingPriorityCalculator) {
      super();
      this.directionCalculator = param1;
      this.directionProcessor = param2;
      this.priorityCalculator = param3;
    }

    public function getProcessor() : TargetingDirectionProcessor {
      return this.directionProcessor;
    }

    public function target(param1:AllGlobalGunParams) : TargetingResult {
      var local4:TargetingDirection = null;
      var local5:Vector.<RayHit> = null;
      var local6:Number = NaN;
      var local2:Vector.<TargetingDirection> = this.directionCalculator.getDirections(param1);
      local2.push(new TargetingDirection(param1.direction,0,0));
      local2.sort(TargetingDirection.comparator);
      var local3:Number = Number.NEGATIVE_INFINITY;
      visualDebug.reset();
      for each(local4 in local2) {
        if(local4.getMaxPriority() < local3) {
          break;
        }
        local5 = this.directionProcessor.process(param1,local4.getDirection());
        local6 = this.priorityCalculator.getPriorityForRayHits(local4.getAngle(),local5);
        if(local6 > 0) {
          local6 += local4.getBonusPriority();
        }
        if(local6 > local3 || local6 == local3 && local4.getAngle() == 0) {
          local3 = local6;
          this.result.setData(local4.getDirection(),local5);
        }
      }
      return this.result;
    }
  }
}
