package alternativa.tanks.models.drones {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.utils.MathUtils;
  import flash.utils.getTimer;

  public class AbstractDroneRenderer implements DroneRenderer {
    private var rotationSpeed:Number;
    private var settings:ISettingsService;

    protected var isLocal:Boolean;
    protected var battleService:BattleService;
    protected var drone:Drone;
    protected var tankSkin:TankSkin;
    protected var turretSkin:Object3D;
    protected var basePosition:Vector3;
    protected var targetAlpha:* = 1;
    protected var alpha:* = 0;
    protected var startTime:* = 0;

    private const MAX_ANGLE:* = 2.356194490192345;

    private var rayHit:* = new RayHit();
    private var direction:* = new Vector3();
    private var normalizedDirection:* = new Vector3();
    private var matrix4:* = new Matrix4();
    private var LOCAL_DRONE_OFFSET:* = new Vector3(100,-100,100);
    private var POSITION_FOR_REMOTE_DRONE:* = new Vector3(0,0,300);

    public function AbstractDroneRenderer(param1:Boolean, param2:TankSkin, param3:Drone, param4:BattleService, param5:ISettingsService) {
      super();
      this.isLocal = param1;
      this.drone = param3;
      this.battleService = param4;
      this.settings = param5;
      this.tankSkin = param2;
      this.turretSkin = param2.getTurret3D();
      this.basePosition = param1 ? param2.getTurretDescriptor().flagMountPoint.clone().add(this.LOCAL_DRONE_OFFSET) : this.POSITION_FOR_REMOTE_DRONE;
    }

    public function start() : void {
      this.stop();
      this.startTime = getTimer();
      this.drone.setCurrentRenderer(this);
      this.battleService.getBattleScene3D().addRenderer(this);
    }

    public function stop() : void {
      if(Boolean(this.drone.getCurrentRenderer())) {
        this.battleService.getBattleScene3D().removeRenderer(this.drone.getCurrentRenderer());
        this.drone.setCurrentRenderer(null);
      }
    }

    internal function updateVisibility() : void {
      var local1:* = !this.isTankOccluded() && this.drone.isTankActive() ? 1 : -1;
      this.alpha += 0.1 * local1;
      if(this.alpha > 1) {
        this.alpha = 1;
      } else if(this.alpha < 0.1) {
        this.alpha = 0;
      }
      var local2:Object3D = this.drone.getObject3D();
      local2.alpha = this.targetAlpha * this.alpha;
      local2.visible = local2.alpha > 0.1;
      if(!this.drone.isTankActive() && !local2.visible) {
        this.stop();
      }
    }

    private function isTankOccluded() : Boolean {
      if(this.isLocal) {
        return false;
      }
      var local1:* = this.battleService.getBattleScene3D().getCamera().position;
      var local2:* = this.tankSkin.getTurretSkin().getTurret3D();
      this.direction.reset(local2.x,local2.y,local2.z);
      this.direction.subtract(local1);
      this.normalizedDirection.copy(this.direction).normalize();
      var local3:TanksCollisionDetector = this.battleService.getBattleRunner().getCollisionDetector();
      return local3.raycastStatic(local1,this.normalizedDirection,CollisionGroup.STATIC,this.direction.length(),null,this.rayHit);
    }

    internal function setPositionAndRotation(param1:int, param2:int) : * {
      var local5:* = undefined;
      var local8:* = undefined;
      var local3:* = this.battleService.getBattleScene3D().getCamera();
      var local4:Object3D = this.drone.getObject3D();
      local4.x = this.drone.getPosition().x;
      local4.y = this.drone.getPosition().y;
      local4.z = this.drone.getPosition().z;
      local4.rotationX = 0;
      local4.rotationY = 0;
      if(this.isLocal) {
        local5 = local3.rotationZ;
      } else {
        local8 = this.tankSkin.getHullMesh();
        this.matrix4.setRotationMatrix(local8.rotationX,local8.rotationY,local8.rotationZ);
        local5 = -Math.atan2(this.matrix4.m01,this.matrix4.m11);
      }
      var local6:* = this.normalizeAngle(local4.rotationZ,local5) - local5;
      if(Math.abs(local6) < 0.1) {
        this.rotationSpeed = 0;
        return;
      }
      if(Math.abs(local6) > this.MAX_ANGLE) {
        local6 = MathUtils.sign(local6) * this.MAX_ANGLE;
        local4.rotationZ = local5 + local6;
        return;
      }
      if(Math.abs(local6) > 0.1) {
        this.rotationSpeed = 0.008 * local6 / this.MAX_ANGLE;
      }
      var local7:* = this.rotationSpeed * param2;
      local4.rotationZ -= local7;
    }

    private function setObjectLookAtCamera(param1:Camera3D) : * {
      var local2:Object3D = this.drone.getObject3D();
      var local3:Number = param1.x - local2.x;
      var local4:Number = param1.y - local2.y;
      local2.rotationZ = -Math.atan2(local3,local4);
    }

    internal function getTurretMatrix() : Matrix4 {
      var local1:* = 0;
      if(this.isLocal) {
        local1 = this.battleService.getBattleScene3D().getCamera().rotationZ;
        return this.matrix4.setMatrix(this.turretSkin.x,this.turretSkin.y,this.turretSkin.z,0,0,local1);
      }
      return this.matrix4.setMatrix(this.turretSkin.x,this.turretSkin.y,this.turretSkin.z,0,0,0);
    }

    private function normalizeAngle(param1:Number, param2:Number) : Number {
      return param1 - 2 * Math.PI * Math.floor((param1 + Math.PI - param2) / (2 * Math.PI));
    }

    public function render(param1:int, param2:int) : void {
    }
  }
}
