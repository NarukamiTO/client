package alternativa.tanks.bonuses {
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.PhysicsController;
  import alternativa.tanks.battle.PhysicsInterpolator;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.tanks.sfx.FadingLightEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import alternativa.types.Long;
  import org1.osflash.signals.ISignal;
  import org1.osflash.signals.Signal;

  public class BattleBonus extends PooledObject implements PhysicsController, PhysicsInterpolator, Renderer, Bonus, ISpawnableObject {
    [Inject]
    public static var lightingService:ILightingEffectsService;

    private static const BIG_VALUE:Number = 10000000000;
    private static const FADEOUT_TIME:Number = 1777;
    private static const FADEOUT_CURVE:Number = 1 / 0.777;
    private static const N:Vector3 = new Vector3();
    private static const P:Vector3 = new Vector3();
    private static const P1:Vector3 = new Vector3();
    private static const X:Vector3 = new Vector3();
    private static const Y:Vector3 = new Vector3();
    private static const Y1:Vector3 = new Vector3();
    private static const origin:Vector3 = new Vector3();
    private static const _rayHit:RayHit = new RayHit();
    private static const _bonusTransform:Matrix4 = new Matrix4();
    private static const m:Matrix3 = new Matrix3();
    private static const m1:Matrix3 = new Matrix3();
    private static const axis:Vector3 = new Vector3();
    private static const eulerAngles:Vector3 = new Vector3();
    private static const offsetVector:Vector3 = new Vector3();
    private static const _bonusPosition:Vector3 = new Vector3();

    private var bonusMesh:BonusMesh;
    private var parachute:Parachute;
    private var cords:Cords;
    private var lightSource:OmniLight;
    private var battleService:BattleService;
    private var fallSpeed:Number = 0;
    private var bonusObjectId:Long;
    private var data:BattleBonusData;
    private var _bonusId:Long;
    private var controllersActive:Boolean;
    private var trigger:BonusTrigger;
    private var controllers:Vector.<BonusController> = new Vector.<BonusController>();
    private var currentController:BonusController;
    private var fallController:FallController;
    private var landingController:LandingController;

    public const onPickup:ISignal = new Signal();
    public const onRemove:ISignal = new Signal();
    public const onDestroy:ISignal = new Signal();

    private const onTankCollision:ISignal = new Signal();

    private var globalLightIntensity:Number;

    public function BattleBonus(param1:Pool) {
      super(param1);
      this.trigger = new BonusTrigger(this);
      this.fallController = new FallController(this);
      this.landingController = new LandingController(this);
      this.lightSource = new OmniLight(0,0,0);
    }

    private static function isFlatSurface(param1:Vector3) : Boolean {
      return param1.z > BonusConst.COS_ONE_DEGREE;
    }

    public function init(param1:Long, param2:Long, param3:BattleBonusData, param4:BattleService) : void {
      this.bonusObjectId = param1;
      this._bonusId = param2;
      this.data = param3;
      this.battleService = param4;
      this.controllers.length = 0;
    }

    private function initLight() : void {
      this.globalLightIntensity = lightingService.getBonusLightIntensity();
      this.lightSource.color = this.data.lightColor;
      this.lightSource.attenuationBegin = this.data.attenuationBegin;
      this.lightSource.attenuationEnd = this.data.attenuationEnd;
      this.lightSource.intensity = this.data.lightIntensity * this.globalLightIntensity;
      this.lightSource.calculateBounds();
      this.bonusMesh.readPosition(origin);
      this.lightSource.x = origin.x;
      this.lightSource.y = origin.y;
      this.lightSource.z = origin.z;
      this.battleService.getBattleScene3D().addObject(this.lightSource);
    }

    public function spawn(param1:Vector3, param2:int, param3:Number, param4:Boolean, param5:Function) : void {
      this.fallSpeed = param3;
      this.onTankCollision.add(param5);
      this.initBonusMesh();
      this.controllersActive = false;
      this.controllers.length = 0;
      this.getGroundPointAndNormal(param1,P,N);
      if(param4 || this.isUnderCeil(param1)) {
        this.initOnGround(P,N);
      } else {
        this.initAirborne(param1,P,N,param2);
        this.trigger.enable();
      }
      this.initRemovalAnimation();
      if(this.runNextController()) {
        this.activateRendererAndPhysicsController();
      }
      this.initLight();
    }

    private function initOnGround(param1:Vector3, param2:Vector3) : void {
      var local3:Number = NaN;
      offsetVector.reset(0,0,BonusConst.BONUS_HALF_SIZE);
      if(isFlatSurface(param2)) {
        eulerAngles.reset(0,0,this.getStartingAngleZ());
      } else {
        axis.cross2(Vector3.Z_AXIS,param2);
        axis.normalize();
        local3 = Math.acos(param2.z);
        m.fromAxisAngle(axis,local3);
        m1.setRotationMatrix(0,0,this.getStartingAngleZ());
        m1.append(m);
        m1.getEulerAngles(eulerAngles);
        offsetVector.transform3(m);
      }
      this.bonusMesh.setRotation(eulerAngles);
      this.bonusMesh.setPositionComponents(param1.x + offsetVector.x,param1.y + offsetVector.y,param1.z + offsetVector.z);
      this.updateTriggerFromMesh();
      this.bonusMesh.addToScene();
      this.startGroundSpawnAnimation();
    }

    private function startGroundSpawnAnimation() : void {
      var local1:GroundSpawnRenderer = GroundSpawnRenderer(this.battleService.getObjectPool().getObject(GroundSpawnRenderer));
      local1.start(this);
    }

    private function updateTriggerFromMesh() : void {
      this.bonusMesh.readTransform(_bonusTransform);
      this.trigger.update(_bonusTransform);
    }

    private function getStartingAngleZ() : Number {
      return Math.PI * 10 * this._bonusId.low / 180;
    }

    private function initAirborne(param1:Vector3, param2:Vector3, param3:Vector3, param4:int) : void {
      var local5:Number = NaN;
      if(isFlatSurface(param3)) {
        local5 = this.calculateFallTime(param1,param2);
        P1.copy(param2);
      } else {
        X.cross2(param3,Vector3.Z_AXIS);
        X.normalize();
        Y.cross2(param3,X);
        Y1.cross2(Vector3.Z_AXIS,X);
        origin.copy(param1);
        origin.addScaled(-BonusConst.BONUS_HALF_SIZE,Y1);
        P1.copy(param2);
        P1.addScaled(-BonusConst.BONUS_HALF_SIZE / param3.z,Y);
        if(this.battleService.getBattleRunner().getCollisionDetector().raycastStatic(origin,Vector3.DOWN,CollisionGroup.STATIC,BIG_VALUE,null,_rayHit)) {
          if(param2.z < _rayHit.position.z && _rayHit.position.z < P1.z) {
            P1.addScaled(BonusConst.BONUS_HALF_SIZE / param3.z * (P1.z - _rayHit.position.z) / (P1.z - param2.z),Y);
          }
        }
        local5 = this.calculateFallTime(param1,P1);
        this.landingController.init(P1,param3);
        this.controllers.push(this.landingController);
      }
      var local6:Number = P1.z + BonusConst.BONUS_HALF_SIZE + BonusConst.BONUS_OFFSET_Z;
      var local7:Number = this.getStartingAngleZ();
      if(local5 * 1000 <= param4) {
        this.bonusMesh.setPositionComponents(P1.x,P1.y,P1.z + BonusConst.BONUS_HALF_SIZE);
        this.bonusMesh.setRotationZ(local7 + local5 * BonusConst.ANGULAR_SPEED_Z);
        this.updateTriggerFromMesh();
        this.bonusMesh.addToScene();
      } else {
        this.initParachute();
        this.addAllToScene();
        this.startSpawnAnimation(this.battleService);
        this.fallController.init(param1,this.fallSpeed,local6,-local5,param4 / 1000,local7);
        this.controllers.push(this.fallController);
      }
    }

    private function isUnderCeil(param1:Vector3) : Boolean {
      var local2:CollisionDetector = this.battleService.getBattleRunner().getCollisionDetector();
      return local2.hasStaticHit(param1,Vector3.Z_AXIS,CollisionGroup.STATIC,BIG_VALUE);
    }

    private function getGroundPointAndNormal(param1:Vector3, param2:Vector3, param3:Vector3) : void {
      var local4:CollisionDetector = this.battleService.getBattleRunner().getCollisionDetector();
      if(local4.raycastStatic(param1,Vector3.DOWN,CollisionGroup.STATIC,BIG_VALUE,null,_rayHit)) {
        param3.copy(_rayHit.normal);
        param2.copy(_rayHit.position);
      } else {
        param3.copy(Vector3.Z_AXIS);
        param2.copy(param1);
        param2.z -= 1000;
      }
    }

    public function get bonusId() : Long {
      return this._bonusId;
    }

    public function pickup() : void {
      this.onPickup.dispatch();
      this.playPickupSound();
      this.detachParachute();
      this.startPickupAnimation();
      this.destroy();
    }

    private function playPickupSound() : void {
      var local1:Sound3D = null;
      if(this.data.pickupSound != null) {
        local1 = Sound3D.create(this.data.pickupSound,0.5);
        this.bonusMesh.readPosition(_bonusPosition);
        this.battleService.addSound3DEffect(Sound3DEffect.create(_bonusPosition,local1));
      }
    }

    private function startPickupAnimation() : void {
      var local1:BonusPickupAnimation = BonusPickupAnimation(this.battleService.getObjectPool().getObject(BonusPickupAnimation));
      local1.start(this.bonusMesh);
      this.onRemove.dispatch();
      this.bonusMesh = null;
    }

    public function remove() : void {
      this.onRemove.dispatch();
      this.bonusMesh = null;
      this.destroy();
    }

    private function destroy() : void {
      this.onDestroy.dispatch();
      this.onPickup.removeAll();
      this.onRemove.removeAll();
      this.onDestroy.removeAll();
      this.destroyBonusMesh();
      this.destroyParachute();
      this.deactivateRendererAndPhysicsController();
      this.removeLight();
      this.trigger.disable();
      this.onTankCollision.removeAll();
      this.battleService = null;
      this.data = null;
      recycle();
    }

    private function destroyBonusMesh() : void {
      if(this.bonusMesh != null) {
        this.bonusMesh.removeFromScene();
        this.bonusMesh.recycle();
        this.bonusMesh = null;
      }
    }

    private function destroyParachute() : void {
      if(this.parachute != null) {
        this.parachute.removeFromScene();
        this.parachute.recycle();
        this.parachute = null;
        this.cords.removeFromScene();
        this.cords.recycle();
        this.cords = null;
      }
    }

    private function calculateFallTime(param1:Vector3, param2:Vector3) : Number {
      return (param1.z - param2.z - BonusConst.BONUS_HALF_SIZE) / this.fallSpeed;
    }

    private function initRemovalAnimation() : void {
      var local1:RemovalAnimation = RemovalAnimation(this.battleService.getObjectPool().getObject(RemovalAnimation));
      local1.init(this);
    }

    private function startSpawnAnimation(param1:BattleService) : void {
      var local2:SpawnAnimation = SpawnAnimation(param1.getObjectPool().getObject(SpawnAnimation));
      local2.start(this);
    }

    private function activateRendererAndPhysicsController() : void {
      if(!this.controllersActive) {
        this.controllersActive = true;
        this.battleService.getBattleRunner().addPhysicsController(this);
        this.battleService.getBattleRunner().addPhysicsInterpolator(this);
        this.battleService.getBattleScene3D().addRenderer(this,0);
      }
    }

    private function initParachute() : void {
      if(BonusCache.isParachuteCacheEmpty()) {
        this.parachute = new Parachute(this.data.parachuteOuterMesh,this.data.parachuteInnerMesh);
      } else {
        this.parachute = BonusCache.getParachute();
      }
      if(BonusCache.isCordsCacheEmpty()) {
        this.cords = new Cords(Parachute.RADIUS,BonusConst.BONUS_HALF_SIZE,Parachute.NUM_STRAPS,this.data.cordsMaterial);
      } else {
        this.cords = BonusCache.getCords();
      }
      this.cords.init(this.bonusMesh,this.parachute);
    }

    private function initBonusMesh() : void {
      if(BonusCache.isBonusMeshCacheEmpty(this.bonusObjectId)) {
        this.bonusMesh = new BonusMesh(this.bonusObjectId,this.data.boxMesh);
      } else {
        this.bonusMesh = BonusMesh(BonusCache.getBonusMesh(this.bonusObjectId));
      }
      this.bonusMesh.init();
    }

    private function addAllToScene() : void {
      this.parachute.addToScene();
      this.bonusMesh.addToScene();
      this.cords.addToScene();
    }

    public function runBeforePhysicsUpdate(param1:Number) : void {
      this.currentController.runBeforePhysicsUpdate(param1);
    }

    private function deactivateRendererAndPhysicsController() : void {
      if(this.controllersActive) {
        this.controllersActive = false;
        this.battleService.getBattleRunner().removePhysicsController(this);
        this.battleService.getBattleRunner().removePhysicsInterpolator(this);
        this.battleService.getBattleScene3D().removeRenderer(this,0);
      }
    }

    private function detachParachute() : void {
      var local1:ParachuteDetachAnimation = null;
      if(this.parachute != null) {
        local1 = ParachuteDetachAnimation(this.battleService.getObjectPool().getObject(ParachuteDetachAnimation));
        local1.start(this.parachute,this.cords,this.fallSpeed / 2);
        this.parachute = null;
        this.cords = null;
      }
    }

    public function interpolatePhysicsState(param1:Number, param2:int) : void {
      this.currentController.interpolatePhysicsState(param1);
    }

    public function render(param1:int, param2:int) : void {
      this.currentController.render();
      this.bonusMesh.readPosition(origin);
      this.lightSource.intensity = this.globalLightIntensity * this.data.lightIntensity;
      this.lightSource.x = origin.x;
      this.lightSource.y = origin.y;
      this.lightSource.z = origin.z;
    }

    public function setAlpha(param1:Number) : void {
      this.bonusMesh.setAlpha(param1);
      if(this.parachute != null) {
        this.parachute.setAlpha(param1);
        this.cords.setAlpha(param1);
      }
    }

    public function onTriggerActivated() : void {
      this.trigger.disable();
      this.onTankCollision.dispatch(this);
    }

    public function onTouchGround() : void {
      this.detachParachute();
      if(!this.runNextController()) {
        this.stopMovement();
      }
    }

    public function onLandingComplete() : void {
      this.stopMovement();
    }

    private function stopMovement() : void {
      this.deactivateRendererAndPhysicsController();
    }

    public function getBonusMesh() : BonusMesh {
      return this.bonusMesh;
    }

    private function runNextController() : Boolean {
      this.currentController = this.controllers.pop();
      if(this.currentController == null) {
        return false;
      }
      this.currentController.start();
      return true;
    }

    public function getParachute() : Parachute {
      return this.parachute;
    }

    public function getCords() : Cords {
      return this.cords;
    }

    public function getTrigger() : BonusTrigger {
      return this.trigger;
    }

    public function enableTrigger() : void {
      this.trigger.enable();
    }

    private function removeLight() : void {
      var local1:FadingLightEffect = null;
      if(this.lightSource.parent != null) {
        this.battleService.getBattleScene3D().removeObject(this.lightSource);
        local1 = FadingLightEffect(this.battleService.getObjectPool().getObject(FadingLightEffect));
        local1.init(this.lightSource,FADEOUT_TIME,FADEOUT_CURVE);
        this.battleService.addGraphicEffect(local1);
      }
    }

    public function addSignal(param1:Function) : void {
      this.onDestroy.add(param1);
    }

    public function removeSignal(param1:Function) : void {
      this.onDestroy.remove(param1);
    }
  }
}
