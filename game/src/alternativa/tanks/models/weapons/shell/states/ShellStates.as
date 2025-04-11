package alternativa.tanks.models.weapons.shell.states {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.shared.MarginalCollider;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellState;

  public class ShellStates extends PooledObject {
    [Inject]
    public static var battleService:BattleService;

    private var states:Vector.<ShellState> = new Vector.<ShellState>();
    private var lastControlPosition:Vector3 = new Vector3();
    private var lastControlDirection:Vector3 = new Vector3();
    private var prevPosition:Vector3 = new Vector3();
    private var prevDirection:Vector3 = new Vector3();
    private var prevStateTime:int;
    private var startTime:int;
    private var lastControlTime:int;
    private var prevPositionAlreadyAdded:Boolean;

    public function ShellStates(param1:Pool) {
      super(param1);
    }

    public function getLastControlPosition() : Vector3 {
      return this.lastControlPosition;
    }

    public function getLastControlDirection() : Vector3 {
      return this.lastControlDirection;
    }

    public function getLastControlTime() : int {
      return this.lastControlTime;
    }

    public function getTimeSinceLastControlState() : int {
      return battleService.getPhysicsTime() + BattleRunner.PHYSICS_STEP_IN_MS - this.startTime - this.lastControlTime;
    }

    public function start(param1:Vector3, param2:Vector3) : void {
      this.states.length = 0;
      this.lastControlPosition.copy(param1);
      this.lastControlDirection.copy(param2);
      this.startTime = battleService.getPhysicsTime();
      this.lastControlTime = 0;
      this.prevPositionAlreadyAdded = true;
    }

    public function updateState(param1:Vector3, param2:Vector3, param3:int = 666666) : void {
      if(MarginalCollider.segmentWithStaticIntersection(this.lastControlPosition,param1)) {
        this.savePrevPosition();
      }
      this.prevPosition.copy(param1);
      this.prevDirection.copy(param2);
      this.prevStateTime = battleService.getPhysicsTime() + Math.min(param3,BattleRunner.PHYSICS_STEP_IN_MS) - this.startTime;
      this.prevPositionAlreadyAdded = false;
    }

    public function getControlStates() : Vector.<ShellState> {
      this.savePrevPosition();
      return this.states;
    }

    public function savePrevPosition() : void {
      if(!this.prevPositionAlreadyAdded) {
        this.states.push(new ShellState(this.prevStateTime,this.prevDirection.toVector3d(),this.prevPosition.toVector3d()));
        this.lastControlTime = this.prevStateTime;
        this.lastControlPosition.copy(this.prevPosition);
        this.lastControlDirection.copy(this.prevDirection);
        this.prevPositionAlreadyAdded = true;
      }
    }

    public function destroy() : void {
      this.states.length = 0;
      recycle();
    }
  }
}
