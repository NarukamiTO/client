package alternativa.tanks.battle.objects.tank {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.FillMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.primitives.Box;
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.physics.Body;
  import alternativa.physics.BodyState;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.PhysicsScene;
  import alternativa.physics.PhysicsUtils;
  import alternativa.physics.collision.BodyCollisionFilter;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.Dust;
  import alternativa.tanks.battle.PhysicsController;
  import alternativa.tanks.battle.PhysicsInterpolator;
  import alternativa.tanks.battle.PostPhysicsController;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.objects.tank.controllers.LocalChassisController;
  import alternativa.tanks.battle.objects.tank.tankchassis.SuspensionParams;
  import alternativa.tanks.battle.objects.tank.tankchassis.Track;
  import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
  import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.TracksAnimator;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretGeometryItem;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.camera.CameraTarget;
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.display.usertitle.UserTitle;
  import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import alternativa.tanks.models.tank.ultimate.mammoth.ImpactEnable;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponUtils;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TankBody;
  import alternativa.tanks.physics.TankBodyIdProvider;
  import alternativa.tanks.sfx.TankSoundEffects;
  import alternativa.tanks.sfx.floatingmessage.FloatingTextEffect;
  import alternativa.tanks.utils.CircularObjectBuffer;
  import alternativa.tanks.utils.DataUnitValidator;
  import alternativa.tanks.utils.DataValidationErrorEvent;
  import flash.display.BitmapData;
  import flash.geom.Vector3D;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class Tank implements PhysicsController, PostPhysicsController, PhysicsInterpolator, Renderer, BodyCollisionFilter, CameraTarget, PointIndicatorStateProvider, WeaponPlatform {
    public static var logService:LogService;

    private static const _v:Vector3 = new Vector3();
    private static const _rayOrigin:Vector3 = new Vector3();
    private static const _rayVector:Vector3 = new Vector3();
    private static const _point:Vector3 = new Vector3();
    private static const _rayHit:RayHit = new RayHit();
    private static const _m:Matrix3 = new Matrix3();
    private static const _rm:Matrix3 = new Matrix3();

    public var user:IGameObject;
    public var health:Number = 0;
    public var state:ClientTankState;

    private var _teamType:BattleTeam;
    private var _incarnation:int;
    private var weapon:Weapon;
    private var _weaponMount:WeaponMount;
    private var battleService:BattleService;
    private var tankBody:TankBody;
    private var collisionCount:int;
    private var skin:TankSkin;
    private var maxSpeedSmoother:ValueSmoother = new EncryptedValueSmoother(100,1000,0,0);
    private var maxTurnSpeedSmoother:ValueSmoother = new EncryptedValueSmoother(0.3,10,0,0);
    private var suspensionParams:SuspensionParams = new SuspensionParams();

    internal var skinCenterOffset:Vector3 = new Vector3();

    private var visibilityPoints:Vector.<Vector3>;

    public var interpolatedPosition:Vector3 = new Vector3();

    internal var interpolatedOrientation:Quaternion = new Quaternion();
    internal var interpolatedTransform:Matrix4 = new Matrix4();

    private var validator:TankDataValidator;
    private var chassis:TrackedChassis;
    private var tracksAnimator:TracksAnimator;
    private var title:UserTitle;
    private var sounds:TankSoundEffects;
    private var bodyStateValidator:BodyPhysicsStateValidator;
    private var battleEventDispatcher:BattleEventDispatcher;
    private var halfLength:Number;
    private var savedBodyState:BodyState = new BodyState();
    private var floatingTextEffect:FloatingTextEffect;
    private var temperature:Number = 0;
    private var maxHealth:int;
    private var hullTransformUpdater:HullTransformUpdater;
    private var boundSphereRadius:Number;
    private var logBuffer:CircularObjectBuffer;
    private var _stunned:Boolean;

    public var lastHitPoint:Vector3 = new Vector3();
    public var isLastHitPointSet:Boolean;
    public var turretCollisions:Vector.<CollisionBox> = new Vector.<CollisionBox>();

    public function Tank(param1:IGameObject, param2:Number, param3:Number, param4:TankSoundEffects, param5:TankSkin, param6:WeaponMount, param7:Weapon, param8:UserTitle, param9:BattleEventDispatcher, param10:int) {
      super();
      this.user = param1;
      this.skin = param5;
      this.sounds = param4;
      this.battleEventDispatcher = param9;
      this.maxHealth = param10;
      this.suspensionParams.dampingCoeff = param3;
      param4.setTank(this);
      var local11:Vector3 = calculateSizeForMesh(param5.getHullDescriptor().mesh);
      var local12:Vector3 = new Vector3(local11.x / 2,local11.y / 2,local11.z / 2);
      this.halfLength = local12.y;
      this.calculateSkinCenterOffset(local11);
      this.createBody(param2,local12);
      this.createCollisionPrimitives(local12);
      this.createVisibilityPoints(local12);
      this.initTurretGeometry(param5);
      this.chassis = new TrackedChassis(this.tankBody.body,this.suspensionParams,this.maxSpeedSmoother,local11);
      this.tracksAnimator = new TracksAnimator(this.chassis,param5,this.maxSpeedSmoother);
      this.state = ClientTankState.ACTIVE;
      this.bodyStateValidator = new BodyPhysicsStateValidator(this.tankBody.body,param9);
      this._weaponMount = param6;
      this.weapon = param7;
      param7.init(this);
      this.title = param8;
      logService = LogService(OSGi.getInstance().getService(LogService));
      this.tankBody.onTankInited();
    }

    private static function calculateSizeForMesh(param1:Mesh) : Vector3 {
      return new Vector3(param1.boundMaxX - param1.boundMinX,param1.boundMaxY - param1.boundMinY,param1.boundMaxZ - param1.boundMinZ);
    }

    private static function _getPhysicsState(param1:BodyState, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:Vector3d) : void {
      BattleUtils.copyToVector3d(param1.position,param2);
      var local6:Quaternion = param1.orientation;
      local6.getEulerAngles(_v);
      param3.x = _v.x;
      param3.y = _v.y;
      param3.z = _v.z;
      BattleUtils.copyToVector3d(param1.velocity,param4);
      BattleUtils.copyToVector3d(param1.angularVelocity,param5);
    }

    private function initTurretGeometry(param1:TankSkin) : void {
      var local3:TurretGeometryItem = null;
      var local4:CollisionBox = null;
      var local2:Vector.<TurretGeometryItem> = param1.getTurretGeometry();
      for each(local3 in local2) {
        local4 = this.createTurretCollision(local3.getHalfSize());
        this.turretCollisions.push(local4);
        this.tankBody.body.addCollisionShape(local4,new Matrix4());
      }
      this.updateTurretPhysics(0);
    }

    public function getWeaponMount() : WeaponMount {
      return this._weaponMount;
    }

    private function createTurretCollision(param1:Vector3) : CollisionBox {
      return new CollisionBox(param1,0,PhysicsMaterial.DEFAULT_MATERIAL);
    }

    private function initView() : void {
    }

    private function createViewByCollision(param1:CollisionBox, param2:uint = 65535) : Box {
      var local3:Vector3 = param1.hs;
      var local4:Box = new Box(local3.x * 2,local3.y * 2,local3.z * 2);
      local4.setMaterialToAllFaces(new FillMaterial(param2,0.9));
      return local4;
    }

    public function log(param1:String) : void {
    }

    public function getLogStrings() : Vector.<String> {
      return new Vector.<String>();
    }

    public function setHullTransformUpdater(param1:HullTransformUpdater) : void {
      this.hullTransformUpdater = param1;
    }

    public function get teamType() : BattleTeam {
      return this._teamType;
    }

    public function get incarnation() : int {
      return this._incarnation;
    }

    public function getAllGunParams(param1:AllGlobalGunParams, param2:int = 0) : void {
      WeaponUtils.calculateMainGunParams(this.skin.getBarrel3D(),this.skin.getTurretDescriptor().muzzles[param2],param1);
    }

    public function getBasicGunParams(param1:BasicGlobalGunParams, param2:int = 0) : void {
      WeaponUtils.calculateBasicGunParams(this.skin.getBarrel3D(),this.skin.getTurretDescriptor().muzzles[param2],param1);
    }

    public function getLocalMuzzlePosition(param1:int = 0) : Vector3 {
      return this.skin.getTurretDescriptor().muzzles[param1];
    }

    public function getLaserLocalPosition() : Vector3 {
      return this.skin.getTurretDescriptor().laserPoint;
    }

    public function getBarrelLength(param1:int = 0) : Number {
      return Vector3(this.skin.getTurretDescriptor().muzzles[param1]).y;
    }

    public function getTurret3D() : Object3D {
      return this.skin.getTurret3D();
    }

    public function getHullMesh() : Mesh {
      return this.skin.getHullMesh();
    }

    public function getSkin() : TankSkin {
      return this.skin;
    }

    public function getTitle() : UserTitle {
      return this.title;
    }

    public function showTitle() : void {
      this.title.show();
    }

    public function hideTitle() : void {
      this.title.hide();
    }

    public function addDust(param1:int = 7) : void {
      var local2:Dust = null;
      var local3:int = 0;
      if(this.battleService != null) {
        local2 = this.battleService.getBattleScene3D().getDustEngine();
        local3 = 0;
        while(local3 < param1) {
          local2.addTankDust(this,0,0.9);
          local3++;
        }
      }
    }

    public function getCameraParams(param1:Vector3, param2:Vector3) : void {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local3:Object3D = this.skin.getTurret3D();
      param1.reset(local3.x,local3.y,local3.z + 10);
      if(FollowCameraController.getFollowCameraMode() == FollowCameraController.CAMERA_FOLLOWS_TURRET) {
        _m.setRotationMatrix(local3.rotationX,local3.rotationY,local3.rotationZ);
        param2.reset(_m.m01,_m.m11,_m.m21);
        if(_m.m22 < -0.999) {
          param2.scale(-1);
        } else {
          local4 = Math.PI / 6;
          local5 = Math.sin(local4);
          if(_m.m22 < local5) {
            _v.reset(_m.m02,_m.m12,_m.m22);
            _v.cross(Vector3.Z_AXIS).normalize();
            _rm.fromAxisAngle(_v,local4 - Math.asin(_m.m22));
            _m.append(_rm);
            param2.reset(_m.m01,_m.m11,_m.m21);
          }
        }
      } else {
        BattleUtils.fillDirectionVector(param2,FollowCameraController.getFollowCameraDirection());
      }
    }

    public function stopMovement() : void {
      this.sounds.setIdleMode();
    }

    public function lockMovement(param1:Boolean) : void {
      var local2:ITankModel = ITankModel(this.user.adapt(ITankModel));
      var local3:LocalChassisController = LocalChassisController(local2.getChassisController());
      if(param1) {
        local3.lock(TankControlLockBits.SHAFT);
      } else {
        local3.unlock(TankControlLockBits.SHAFT);
      }
    }

    public function getNumberOfBarrels() : int {
      return this.skin.getTurretDescriptor().muzzles.length;
    }

    public function enableTurretSound(param1:Boolean) : void {
      this.sounds.turretSoundEnabled = param1;
    }

    public function spawn(param1:BattleTeam, param2:int) : void {
      this._teamType = param1;
      this._incarnation = param2;
      this.title.setTeamType(param1);
      this.sounds.setIdleMode();
      this.sounds.turretSoundEnabled = true;
      this.skin.resetColorTransform();
      this.skin.setNormalState();
      this.maxSpeedSmoother.reset(this.maxSpeedSmoother.getTargetValue());
      this.maxTurnSpeedSmoother.reset(this.maxTurnSpeedSmoother.getTargetValue());
    }

    public function kill() : void {
      this.state = ClientTankState.DEAD;
      this.health = 0;
      this.sounds.enabled = false;
      this.battleService.getBattleRunner().getSoundManager().removeEffect(this.sounds);
      this.title.hideIndicators();
      this.title.hide();
    }

    public function disable() : void {
      this.title.hideIndicators();
    }

    public function isSameTeam(param1:BattleTeam) : Boolean {
      return this._teamType == param1 && param1 != BattleTeam.NONE;
    }

    public function getUser() : IGameObject {
      return this.user;
    }

    public function getMainCollisionBox() : CollisionBox {
      return this.tankBody.tankCollisionBox;
    }

    public function setSemiActivatedState() : void {
      this.state = ClientTankState.SEMI_ACTIVE;
      this.setBodyCollisionGroup(CollisionGroup.TANK);
      this.setTracksCollisionGroup(CollisionGroup.INACTIVE_TRACK);
      this.skin.setAlpha(0.5);
      this.tankBody.body.postCollisionFilter = this;
    }

    public function setActivatedState() : void {
      this.state = ClientTankState.ACTIVE;
      this.setBodyCollisionGroup(CollisionGroup.TANK | CollisionGroup.ACTIVE_TRACK | CollisionGroup.WEAPON);
      this.setTracksCollisionGroup(CollisionGroup.ACTIVE_TRACK);
      this.skin.setAlpha(1);
      this.tankBody.body.postCollisionFilter = null;
    }

    public function considerBodies(param1:Body, param2:Body) : Boolean {
      if(param1.postCollisionFilter != null && param2.postCollisionFilter == null) {
        ++param1.tank.collisionCount;
      } else if(param1.postCollisionFilter == null && param2.postCollisionFilter != null) {
        ++param2.tank.collisionCount;
      }
      return false;
    }

    public function addToBattle(param1:BattleService) : void {
      var local2:BattleRunner = null;
      var local3:BattleScene3D = null;
      if(this.battleService == null) {
        this.battleService = param1;
        this.tankBody.id = TankBodyIdProvider.claimId();
        local2 = param1.getBattleRunner();
        local2.addBodyWrapper(this.tankBody);
        local2.addPhysicsController(this);
        local2.addPostPhysicsController(this);
        local2.addPhysicsInterpolator(this);
        this.skin.addToScene();
        this.title.addToContainer();
        local3 = param1.getBattleScene3D();
        local3.addTank(this);
        local2.getSoundManager().addEffect(this.sounds);
        this.hullTransformUpdater.reset();
        local3.getDustEngine().addTank(this);
      }
    }

    private function addDebugViewToScene(param1:BattleScene3D) : void {
    }

    public function removeFromBattle() : void {
      var local1:BattleRunner = null;
      var local2:BattleScene3D = null;
      if(this.battleService != null) {
        this.battleService.getBattleScene3D().getDustEngine().removeTank(this);
        local1 = this.battleService.getBattleRunner();
        local2 = this.battleService.getBattleScene3D();
        local1.removeBodyWrapper(this.tankBody);
        local1.removePhysicsController(this);
        local1.removePostPhysicsController(this);
        local1.removePhysicsInterpolator(this);
        TankBodyIdProvider.releaseId(this.tankBody.id);
        this.skin.removeFromScene();
        this.title.removeFromContainer();
        if(this.floatingTextEffect != null) {
          this.floatingTextEffect.kill();
        }
        local2.removeTank(this);
        local1.getSoundManager().removeEffect(this.sounds);
        this.temperature = 0;
        this.tankBody.body.clearAccumulators();
        this._weaponMount.reset();
        this.weapon.deactivate();
        this.weapon.reset();
        this.battleService = null;
      }
    }

    private function removeDebugViewFromScene(param1:BattleScene3D) : void {
    }

    public function destroy() : void {
      this.user = null;
      this.state = ClientTankState.DEAD;
      this.skin.dispose();
      this.skin = null;
      this.weapon.destroy();
      this.tankBody.destroy();
      if(this.validator != null) {
        this.validator.destroy();
      }
    }

    public function setMaxSpeed(param1:Number, param2:Boolean) : void {
      if(param2) {
        this.maxSpeedSmoother.reset(param1);
      } else {
        this.maxSpeedSmoother.setTargetValue(param1);
      }
    }

    public function setMaxTurnSpeed(param1:Number, param2:Boolean) : void {
      if(param2) {
        this.maxTurnSpeedSmoother.reset(param1);
      } else {
        this.maxTurnSpeedSmoother.setTargetValue(param1);
      }
    }

    public function runBeforePhysicsUpdate(param1:Number) : void {
      this.collisionCount = 0;
      var local2:Number = Number(this.maxSpeedSmoother.update(param1));
      var local3:Number = Number(this.maxTurnSpeedSmoother.update(param1));
      this.tankBody.body.setMaxSpeedXY(local2);
      this.chassis.applyForces(local2,local3,param1);
      this.tankBody.body.slipperyMode = !this.hasTracksContactsWithStatic() && this.tankBody.isSoaring();
      this.rotateTurret(param1);
      this.validateBodyState();
    }

    public function runAfterPhysicsUpdate(param1:Number) : void {
      this.ensureBodyStateIsValid();
      this.bodyStateValidator.refresh();
      this._weaponMount.updatePhysics(this.getBody());
    }

    private function ensureBodyStateIsValid() : void {
      var local1:Body = this.tankBody.body;
      var local2:BodyState = local1.state;
      if(!local2.isValid()) {
        local2.copy(this.savedBodyState);
        local1.saveState();
      }
    }

    public function updatePhysicsState() : void {
      this.interpolatePhysicsState(1,16);
      this.hullTransformUpdater.update(0);
      this.skin.updateTurretTransform(this._weaponMount.getTurretInterpolatedDirection(),this._weaponMount.getBarrelInterpolatedElevation());
    }

    public function interpolatePhysicsState(param1:Number, param2:int) : void {
      this.tankBody.body.interpolate(param1,this.interpolatedPosition,this.interpolatedOrientation);
      this.interpolatedOrientation.normalize();
      this.interpolatedOrientation.toMatrix4(this.interpolatedTransform);
      this.interpolatedTransform.setPosition(this.interpolatedPosition);
      this._weaponMount.interpolate(param1,param2);
    }

    public function resetInterpolatedState() : void {
      var local1:BodyState = this.tankBody.body.state;
      this.interpolatedPosition.copy(local1.position);
      this.interpolatedOrientation.copy(local1.orientation);
      this.interpolatedOrientation.toMatrix4(this.interpolatedTransform);
      this.interpolatedTransform.setPosition(this.interpolatedPosition);
    }

    public function render(param1:int, param2:int) : void {
      var local4:Object3D = null;
      var local3:Number = param2 * 0.001;
      this.hullTransformUpdater.update(local3);
      this.skin.updateTurretTransform(this._weaponMount.getTurretInterpolatedDirection(),this._weaponMount.getBarrelInterpolatedElevation());
      this.skin.setColorTransformByTemperature(this.temperature);
      this.tracksAnimator.animate(local3);
      local4 = this.skin.getTurret3D();
      _v.x = local4.x;
      _v.y = local4.y;
      _v.z = local4.z;
      this.title.setWeaponStatus(100 * this.weapon.getStatus());
      this.title.update(_v);
      var local5:TankHullSkinCacheItem = this.skin.getHullDescriptor();
      if(local5.hasIncorrectData()) {
        this.battleEventDispatcher.dispatchEventOnce(new DataValidationErrorEvent(local5.getType()));
      }
      var local6:TurretSkinCacheItem = this.skin.getTurretDescriptor();
      if(local6.hasIncorrectData()) {
        this.battleEventDispatcher.dispatchEventOnce(new DataValidationErrorEvent(local6.getType()));
      }
    }

    private function renderDebugView() : void {
    }

    public function setViewPositionByCollision(param1:Object3D, param2:CollisionBox) : void {
      var local3:Matrix4 = param2.transform;
      local3.getEulerAngles(_v);
      param1.rotationX = _v.x;
      param1.rotationY = _v.y;
      param1.rotationZ = _v.z;
      param1.x = local3.m03;
      param1.y = local3.m13;
      param1.z = local3.m23;
    }

    public function getValidator() : DataUnitValidator {
      if(this.validator == null) {
        this.validator = new TankDataValidator(this.tankBody.body.collisionShapes);
      }
      return this.validator;
    }

    public function isInvisible(param1:Vector3) : Boolean {
      var local2:int = int(this.visibilityPoints.length);
      var local3:int = 0;
      while(local3 < local2) {
        _point.copy(this.visibilityPoints[local3]);
        if(this.isPointVisible(_point,param1)) {
          return false;
        }
        local3++;
      }
      return true;
    }

    private function isPointVisible(param1:Vector3, param2:Vector3) : Boolean {
      var local3:Body = this.tankBody.body;
      param1.transform3(local3.baseMatrix);
      var local4:BodyState = local3.state;
      param1.add(local4.position);
      _rayOrigin.copy(param2);
      _rayVector.diff(param1,_rayOrigin);
      var local5:PhysicsScene = local3.scene;
      if(local5 == null) {
        return false;
      }
      var local6:CollisionDetector = local5.collisionDetector;
      return !local6.raycastStatic(_rayOrigin,_rayVector,CollisionGroup.STATIC,1,null,_rayHit);
    }

    public function getBodyCollisionGroup() : int {
      return CollisionShape(this.tankBody.tankCollisionBox).collisionGroup;
    }

    public function setBodyCollisionGroup(param1:int) : void {
      var local2:CollisionBox = null;
      this.tankBody.tankCollisionBox.collisionGroup = param1;
      for each(local2 in this.turretCollisions) {
        local2.collisionGroup = param1 & CollisionGroup.WEAPON;
      }
    }

    public function setTracksCollisionGroup(param1:int) : void {
      this.chassis.setTracksCollisionGroup(param1);
    }

    public function setMovementParams(param1:int, param2:int, param3:int, param4:Boolean) : void {
      this.chassis.movementDirection = param1;
      this.chassis.turnDirection = param2;
      this.chassis.turnSpeedNumber = param3;
      this.chassis.inverseBackTurnMovement = param4;
      if(param1 != 0) {
        this.sounds.setAccelerationMode();
      } else if(param2 != 0) {
        this.sounds.setTurningMode();
      } else {
        this.sounds.setIdleMode();
      }
    }

    public function setPhysicsState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d) : void {
      var local5:Body = this.tankBody.body;
      var local6:BodyState = local5.state;
      BattleUtils.copyToVector3(param1,local6.position);
      local6.orientation.setFromEulerAnglesXYZ(param2.x,param2.y,param2.z);
      BattleUtils.copyToVector3(param3,local6.velocity);
      BattleUtils.copyToVector3(param4,local6.angularVelocity);
      local5.saveState();
      local5.calcDerivedData();
      this.bodyStateValidator.refresh();
    }

    public function getPhysicsPosition(param1:Vector3) : void {
      var local2:Vector3 = this.tankBody.body.state.position;
      param1.reset(local2.x,local2.y,local2.z);
    }

    public function getPhysicsState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d) : void {
      _getPhysicsState(this.tankBody.body.state,param1,param2,param3,param4);
    }

    public function getPreviousPhysicsState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d) : void {
      _getPhysicsState(this.tankBody.body.prevState,param1,param2,param3,param4);
    }

    public function getBody() : Body {
      return this.tankBody.body;
    }

    public function setTemperature(param1:Number) : void {
      this.temperature = param1;
    }

    public function getTemperature() : Number {
      return this.temperature;
    }

    private function rotateTurret(param1:Number) : void {
      this._weaponMount.rotate(param1,this.tankBody.body.baseMatrix);
      this.updateTurretPhysics(this._weaponMount.getTurretPhysicsDirection());
      this.sounds.playTurretSound(this._weaponMount.isRotating());
    }

    private function updateTurretPhysics(param1:Number) : void {
      var local5:CollisionBox = null;
      var local6:Matrix4 = null;
      var local7:TurretGeometryItem = null;
      var local2:TankHullSkinCacheItem = this.skin.getHullDescriptor();
      var local3:Vector.<TurretGeometryItem> = this.skin.getTurretGeometry();
      var local4:int = 0;
      while(local4 < this.turretCollisions.length) {
        local5 = this.turretCollisions[local4];
        local6 = local5.localTransform;
        local6.setMatrix(local2.getTurretMountPointX() + this.skinCenterOffset.x,local2.getTurretMountPointY() + this.skinCenterOffset.y,local2.getTurretMountPointZ() + this.skinCenterOffset.z,0,0,param1);
        local7 = local3[local4];
        local6.prepend(local7.getTransform());
        local4++;
      }
    }

    private function validateBodyState() : void {
      this.savedBodyState.copy(this.tankBody.body.state);
      this.bodyStateValidator.validate();
    }

    private function createBody(param1:Number, param2:Vector3) : void {
      var local3:Body = new Body(param1,Matrix3.IDENTITY,0);
      PhysicsUtils.setBoxInvInertia(param1,param2,local3.invInertia);
      local3.tank = this;
      this.tankBody = new TankBody(local3);
    }

    private function createCollisionPrimitives(param1:Vector3) : void {
      var local2:Number = 2 * param1.z - (this.suspensionParams.nominalRayLength - TankConst.RAY_OFFSET);
      CollisionBoxesBuilder.createTankCollisionBox(param1,local2,this.tankBody);
      CollisionBoxesBuilder.createStaticCollisionBoxes(param1,local2,this.tankBody);
      this.setBoundSphereRadius(param1,local2);
    }

    private function setBoundSphereRadius(param1:Vector3, param2:Number) : void {
      var local3:Vector3 = new Vector3(param1.x,param1.y,param2 / 2);
      var local4:Matrix4 = this.tankBody.tankCollisionBox.localTransform;
      this.boundSphereRadius = local3.length() + Math.abs(local4.m23);
    }

    private function createVisibilityPoints(param1:Vector3) : void {
      var local2:Number = param1.x;
      var local3:Number = param1.y;
      this.visibilityPoints = Vector.<Vector3>([new Vector3(-local2,local3,0),new Vector3(local2,local3,0),new Vector3(-local2,0,0),new Vector3(local2,0,0),new Vector3(-local2,-local3,0),new Vector3(local2,-local3,0)]);
    }

    private function calculateSkinCenterOffset(param1:Vector3) : void {
      var local2:Mesh = this.skin.getHullMesh();
      local2.calculateBounds();
      this.skinCenterOffset.x = -0.5 * (local2.boundMinX + local2.boundMaxX);
      this.skinCenterOffset.y = -0.5 * (local2.boundMinY + local2.boundMaxY);
      this.skinCenterOffset.z = -0.5 * param1.z - this.suspensionParams.nominalRayLength + TankConst.RAY_OFFSET;
    }

    public function getSkinCenterOffset() : Vector3 {
      return this.skinCenterOffset;
    }

    public function getTitleTexture() : BitmapData {
      return this.title.getTexture();
    }

    public function readTitlePosition(param1:Vector3D) : void {
      this.title.readPosition(param1);
    }

    public function getHalfLength() : Number {
      return this.halfLength;
    }

    public function getMaxHealth() : int {
      return this.maxHealth;
    }

    public function getBoundSphereRadius() : Number {
      return this.boundSphereRadius;
    }

    public function applyWeaponHit(param1:Vector3, param2:Vector3, param3:Number) : void {
      if(this.health > 0) {
        if(this.isImpactEnabled()) {
          this.tankBody.body.addWorldForceScaled(param1,param2,param3);
          this.tankBody.additionForcesSum.addScaled(param3,param2);
        }
        this.setLastHitPoint(param1);
      }
    }

    private function isImpactEnabled() : Boolean {
      var local1:IGameObject = ITankModel(this.user.adapt(ITankModel)).getTankSet().hull;
      if(local1.hasModel(ImpactEnable)) {
        return ImpactEnable(local1.adapt(ImpactEnable)).isImpactEnabled();
      }
      return true;
    }

    public function getLeftTrack() : Track {
      return this.chassis.leftTrack;
    }

    public function getRightTrack() : Track {
      return this.chassis.rightTrack;
    }

    public function hasTracksContactsWithStatic() : Boolean {
      return this.getLeftTrack().hasContactsWithStatic() || this.getRightTrack().hasContactsWithStatic();
    }

    public function hasCollisionWithStatic() : Boolean {
      return this.tankBody.hasContactsWithStatic;
    }

    public function hasCollisionWithOtherBodies() : Boolean {
      return this.tankBody.hasContactsWithOtherBodies();
    }

    public function getPenetratedBodies() : Vector.<Body> {
      return this.tankBody.penetratedBodies;
    }

    public function setAcceleration(param1:Number) : void {
      this.chassis.setAcceleration(param1);
    }

    public function setReverseAcceleration(param1:Number) : void {
      this.chassis.setReverseAcceleration(param1);
    }

    public function setSideAcceleration(param1:Number) : void {
      this.chassis.setSideAcceleration(param1);
    }

    public function setTurnAcceleration(param1:Number) : void {
      this.chassis.setTurnAcceleration(param1);
    }

    public function setReverseTurnAcceleration(param1:Number) : void {
      this.chassis.setReverseTurnAcceleration(param1);
    }

    public function setStabilizationAcceleration(param1:Number) : void {
      this.chassis.setStabilizationAcceleration(param1);
    }

    public function isInBattle() : Boolean {
      return this.battleService != null;
    }

    public function isJumpBegin() : Boolean {
      return this.tankBody.isJumpBegin();
    }

    public function isJumpEnd() : Boolean {
      return this.tankBody.isJumpEnd();
    }

    public function isElasticStaticCollisionWhenSoaring() : Boolean {
      return this.tankBody.isElasticStaticCollisionWhenSoaring();
    }

    public function setLastHitPoint(param1:Vector3) : void {
      this.lastHitPoint.copy(param1);
      BattleUtils.globalToLocal(this.getBody(),this.lastHitPoint);
      this.isLastHitPointSet = true;
    }

    public function getInterpolatedTurretWorldDirection() : Number {
      BattleUtils.fillDirectionVector(_v,this._weaponMount.getTurretInterpolatedDirection());
      _v.deltaTransform4(this.interpolatedTransform);
      return BattleUtils.getDirectionAngle(_v);
    }

    public function get stunned() : Boolean {
      return this._stunned;
    }

    public function set stunned(param1:Boolean) : void {
      this._stunned = param1;
    }

    public function getIndicatorPosition() : Vector3 {
      return this.tankBody.body.state.position;
    }

    public function isIndicatorActive(param1:Vector3 = null) : Boolean {
      return this.state == ClientTankState.ACTIVE && IBossState(this.user.adapt(IBossState)).role() != BossRelationRole.BOSS;
    }

    public function zOffset() : Number {
      return 0;
    }
  }
}
