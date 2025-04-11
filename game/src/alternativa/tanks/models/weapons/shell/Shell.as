package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.IRayCollisionFilter;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.PhysicsController;
  import alternativa.tanks.battle.PhysicsInterpolator;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapons.shell.states.DummyShellStates;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.errors.IllegalOperationError;

  public class Shell extends PooledObject implements PhysicsController, Renderer, PhysicsInterpolator, IRayCollisionFilter {
    [Inject]
    public static var battleService:BattleService;

    protected static const thousandth:EncryptedInt = new EncryptedIntImpl(1000);
    protected static const _rotationMatrix:Matrix3 = new Matrix3();
    protected static const _rayHit:RayHit = new RayHit();
    protected static const _hitPoint:Vector3 = new Vector3();

    private static const _radialVector:Vector3 = new Vector3();
    private static const _barrelDirection:Vector3 = new Vector3();

    private const RADIAL_ANGLE_STEP:Number = 2 * Math.PI / this.getNumRadialRays();

    private var shotId:int;

    protected var isRemoteShot:Boolean;
    protected var isFirstTick:Boolean;
    protected var shooterBody:Body;
    protected var totalDistance:Number = 0;
    protected var flightDirection:Vector3 = new Vector3();
    protected var currPosition:Vector3 = new Vector3();
    protected var prevPosition:Vector3 = new Vector3();
    protected var barrelOrigin:Vector3 = new Vector3();
    protected var interpolatedPosition:Vector3 = new Vector3();
    protected var radialPoints:Vector.<Vector3>;
    protected var shellStates:ShellStates;

    public function Shell(param1:Pool) {
      super(param1);
      this.radialPoints = new Vector.<Vector3>(this.getNumRadialRays(),true);
      var local2:int = 0;
      while(local2 < this.getNumRadialRays()) {
        this.radialPoints[local2] = new Vector3();
        local2++;
      }
    }

    private static function getRadialVector(param1:Vector3, param2:Vector3) : void {
      var local3:int = 0;
      var local4:Number = 10000000000;
      var local5:Number = param1.x < 0 ? -param1.x : param1.x;
      if(local5 < local4) {
        local4 = local5;
        local3 = 0;
      }
      local5 = param1.y < 0 ? -param1.y : param1.y;
      if(local5 < local4) {
        local4 = local5;
        local3 = 1;
      }
      local5 = param1.z < 0 ? -param1.z : param1.z;
      if(local5 < local4) {
        local3 = 2;
      }
      if(local3 == 0) {
        param2.reset(0,param1.z,-param1.y);
      } else if(local3 == 1) {
        param2.reset(-param1.z,0,param1.x);
      } else if(local3 == 2) {
        param2.reset(param1.y,-param1.x,0);
      }
    }

    protected function createShellStates() : ShellStates {
      if(this.isRemoteShot) {
        return DummyShellStates.INSTANCE;
      }
      return ShellStates(battleService.getObjectPool().getObject(ShellStates));
    }

    public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void {
      this.totalDistance = 0;
      this.isFirstTick = true;
      this.shotId = param5;
      this.isRemoteShot = param4;
      this.barrelOrigin.copy(param1.barrelOrigin);
      this.currPosition.copy(param1.muzzlePosition);
      this.prevPosition.copy(param1.muzzlePosition);
      this.flightDirection.copy(param2);
      this.shooterBody = param3;
      battleService.getBattleRunner().addPhysicsController(this);
      battleService.getBattleRunner().addPhysicsInterpolator(this);
      battleService.getBattleScene3D().addRenderer(this,0);
      this.shellStates = this.createShellStates();
      this.shellStates.start(this.currPosition,param2);
    }

    public function runBeforePhysicsUpdate(param1:Number) : void {
      if(this.isFirstTick) {
        this.isFirstTick = false;
        this.processFirstTick(param1);
      } else {
        this.update(param1);
      }
    }

    private function processFirstTick(param1:Number) : void {
      if(!this.checkIfBarrelIntersectsWithObstacle()) {
        this.initRadialPoints(this.currPosition,this.flightDirection);
        this.update(param1);
      }
    }

    protected function checkIfBarrelIntersectsWithObstacle() : Boolean {
      var local3:Body = null;
      var local5:Vector3 = null;
      var local1:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      _barrelDirection.diff(this.currPosition,this.barrelOrigin);
      var local2:Number = _barrelDirection.length();
      _barrelDirection.normalize();
      if(local1.raycast(this.barrelOrigin,_barrelDirection,CollisionGroup.WEAPON,local2,this,_rayHit)) {
        local3 = _rayHit.shape.body;
        if(local3.tank == null) {
          _rayHit.position.subtract(_barrelDirection);
        }
        this.processHit(local3,_rayHit.position,_barrelDirection,local2);
        return true;
      }
      this.initRadialPoints(this.barrelOrigin,_barrelDirection);
      var local4:int = 0;
      while(local4 < this.getNumRadialRays()) {
        local5 = this.radialPoints[local4];
        if(local1.raycast(local5,_barrelDirection,CollisionGroup.WEAPON,local2,this,_rayHit)) {
          local3 = _rayHit.shape.body;
          if(BattleUtils.isTankBody(local3)) {
            _hitPoint.copy(this.barrelOrigin).addScaled(_rayHit.t,_barrelDirection);
            this.processHit(local3,_hitPoint,_barrelDirection,local2);
            return true;
          }
        }
        local4++;
      }
      return false;
    }

    protected function destroy() : void {
      battleService.getBattleRunner().removePhysicsController(this);
      battleService.getBattleRunner().removePhysicsInterpolator(this);
      battleService.getBattleScene3D().removeRenderer(this,0);
      this.shellStates.destroy();
      recycle();
    }

    protected function initRadialPoints(param1:Vector3, param2:Vector3) : void {
      getRadialVector(param2,_radialVector);
      _radialVector.normalize().scale(this.getRadius());
      _rotationMatrix.fromAxisAngle(param2,this.RADIAL_ANGLE_STEP);
      Vector3(this.radialPoints[0]).sum(param1,_radialVector);
      var local3:int = 1;
      while(local3 < this.getNumRadialRays()) {
        _radialVector.transform3(_rotationMatrix);
        Vector3(this.radialPoints[local3]).sum(param1,_radialVector);
        local3++;
      }
    }

    public function interpolatePhysicsState(param1:Number, param2:int) : void {
      this.interpolatedPosition.interpolate(param1,this.prevPosition,this.currPosition);
    }

    public function considerBody(param1:Body) : Boolean {
      return this.shooterBody != param1;
    }

    public function getShotId() : int {
      return this.shotId;
    }

    protected function getNumRadialRays() : int {
      return 8;
    }

    protected function update(param1:Number) : void {
      throw new IllegalOperationError();
    }

    protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void {
      throw new IllegalOperationError();
    }

    protected function getTimeMsToHit(param1:Number) : int {
      return Math.round(_rayHit.t / param1 * BattleRunner.PHYSICS_STEP_IN_MS);
    }

    protected function processHit(param1:Body, param2:Vector3, param3:Vector3, param4:Number) : void {
      this.processHitImpl(param1,param2,param3,this.totalDistance + _rayHit.t,this.getTimeMsToHit(param4));
    }

    protected function getRadius() : Number {
      throw new IllegalOperationError();
    }

    public function render(param1:int, param2:int) : void {
      throw new IllegalOperationError();
    }

    protected function objectPool() : ObjectPool {
      return battleService.getObjectPool();
    }

    protected function battleScene() : BattleScene3D {
      return battleService.getBattleScene3D();
    }
  }
}
