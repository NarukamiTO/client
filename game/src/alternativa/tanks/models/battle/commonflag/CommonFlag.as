package alternativa.tanks.models.battle.commonflag {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.PhysicsController;
  import alternativa.tanks.battle.PhysicsInterpolator;
  import alternativa.tanks.battle.Trigger;
  import alternativa.tanks.battle.hidablegraphicobjects.HidableGraphicObject;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.teamlight.ModeLight;
  import alternativa.tanks.models.teamlight.TeamLightColor;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import alternativa.types.Long;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class CommonFlag implements HidableGraphicObject, Trigger, Renderer, PhysicsController, PhysicsInterpolator {
    [Inject]
    public static var lightingEffectsService:ILightingEffectsService;

    [Inject]
    public static var battleService:BattleService;

    private static const contacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
    private static const rayOrigin:Vector3 = new Vector3();
    private static const rayHit:RayHit = new RayHit();

    protected static const TMP_POSITION:Vector3 = new Vector3();
    protected static const TMP_ROTATION:Vector3 = new Vector3();
    protected static const TMP_ROTATION_Q:Quaternion = new Quaternion();

    private static const rayDirection:Vector3 = new Vector3();

    protected static const NO_POSITION:Vector3 = new Vector3(NaN,NaN,NaN);

    private static const DEFAULT_ROTATION:Quaternion = new Quaternion();
    private static const TOUCH_TIMEOUT_MS:int = 100;

    public static const MARKER_HIDE_DISTANCE:Number = 3500;

    public var teamType:BattleTeam;
    public var collisionPrimitive:CollisionShape;

    private var _id:int;
    private var _carrier:Tank;
    private var _carrierId:Long;

    protected var _state:FlagState = FlagState.AT_BASE;
    protected var basePosition:Vector3;
    protected var _alphaCoefficient:Number = 1;
    protected var isLocalCarrier:Boolean;

    private var collisionDetector:CollisionDetector;
    private var triggerCallback:ICommonFlagModeModel;

    protected var lightSource:OmniLight;
    protected var flyingData:FlagFlyingData = new FlagFlyingData();

    private var oldStatus:FlagStatus = new FlagStatus();
    private var newStatus:FlagStatus = new FlagStatus();

    protected var interpolatedStatus:FlagStatus = new FlagStatus();
    protected var skinObject:Object3D;
    protected var skinHeight:Number = 400;
    protected var mountPointOffsetZ:Number = -50;

    public var ballTouchedFunction:Function;

    private var battleObject:IGameObject;
    private var lastTimeTouched:* = 0;
    private var vec:Vector3 = new Vector3();

    public function CommonFlag(param1:int, param2:BattleTeam, param3:Vector3) {
      super();
      var local4:BattleRunner = battleService.getBattleRunner();
      this._id = param1;
      this.collisionDetector = local4.getCollisionDetector();
      this.teamType = param2;
      this.basePosition = param3;
      this.skinHeight = this.skinHeight;
      this.createLight(param2);
      local4.addPhysicsController(this);
      local4.addPhysicsInterpolator(this);
      this.battleObject = Model.object;
    }

    private function createLight(param1:BattleTeam) : void {
      var local2:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CTF);
      var local3:TeamLightColor = local2.getLightForTeam(param1);
      this.lightSource = new OmniLight(local3.getColor(),local2.getAttenuationBegin(),local2.getAttenuationEnd());
      this.lightSource.intensity = local3.getIntensity();
    }

    public function registerTouch() : Boolean {
      var local1:int = getTimer();
      var local2:Boolean = local1 - this.lastTimeTouched > TOUCH_TIMEOUT_MS;
      if(local2) {
        this.lastTimeTouched = local1;
      }
      return local2;
    }

    public function setAlphaMultiplier(param1:Number) : void {
      this._alphaCoefficient = param1 < 0.2 ? 0.2 : param1;
      this.setSkinAlpha(this.isLocalCarrier ? 0.5 : 1);
    }

    protected function setSkinAlpha(param1:Number) : void {
      this.setAlpha(this._state == FlagState.CARRIED ? param1 : this._alphaCoefficient);
    }

    public function get id() : int {
      return this._id;
    }

    public function setAlpha(param1:Number) : void {
      this.skinObject.alpha = param1;
    }

    public function readPosition(param1:Vector3) : void {
      param1.x = this.skinObject.x;
      param1.y = this.skinObject.y;
      param1.z = this.skinObject.z;
    }

    public function checkTrigger(param1:Body) : void {
      var local3:CollisionShape = null;
      var local4:ShapeContact = null;
      var local5:int = 0;
      if(this.state == FlagState.CARRIED || this.state == FlagState.EXILED) {
        return;
      }
      var local2:int = 0;
      while(true) {
        if(local2 >= param1.numCollisionShapes) {
          return;
        }
        local3 = param1.collisionShapes[local2];
        this.collisionDetector.getContacts(local3,this.collisionPrimitive,contacts);
        if(contacts.length > 0) {
          local4 = contacts[0];
          rayOrigin.copy(local4.position);
          rayDirection.x = this.collisionPrimitive.transform.m03 - rayOrigin.x;
          rayDirection.y = this.collisionPrimitive.transform.m13 - rayOrigin.y;
          rayDirection.z = this.collisionPrimitive.transform.m23 - rayOrigin.z;
          if(!this.collisionDetector.raycastStatic(rayOrigin,rayDirection,CollisionGroup.STATIC,1,null,rayHit)) {
            break;
          }
          rayOrigin.x = local3.transform.m03;
          rayOrigin.y = local3.transform.m13;
          rayOrigin.z = local3.transform.m23;
          rayDirection.x = this.collisionPrimitive.transform.m03 - rayOrigin.x;
          rayDirection.y = this.collisionPrimitive.transform.m13 - rayOrigin.y;
          rayDirection.z = this.collisionPrimitive.aabb.minZ - rayOrigin.z + 1;
          if(!this.collisionDetector.raycastStatic(rayOrigin,rayDirection,CollisionGroup.STATIC,1,null,rayHit)) {
            break;
          }
        }
        local2++;
      }
      local5 = 0;
      while(local5 < contacts.length) {
        local4 = contacts[local5];
        local4.dispose();
        local5++;
      }
      contacts.length = 0;
      this.triggerCallback.onFlagTouch(this);
    }

    public function render(param1:int, param2:int) : void {
      if(this._carrier != null) {
        this._carrier.getSkin().readGlobalFlagMountPoint(TMP_POSITION,TMP_ROTATION);
        TMP_POSITION.z += this.mountPointOffsetZ;
        TMP_ROTATION_Q.setFromEulerAngles(TMP_ROTATION);
        this.setPositionAndRotation(TMP_POSITION,TMP_ROTATION_Q);
      }
      this.renderImpl(param1,param2,this.interpolatedStatus);
    }

    protected function renderImpl(param1:int, param2:int, param3:FlagStatus) : void {
    }

    public function get carrier() : Tank {
      return this._carrier;
    }

    public function get carrierId() : Long {
      return this._carrierId;
    }

    final public function setPositionAndRotation(param1:Vector3, param2:Quaternion) : * {
      this.oldStatus.apply(param1,param2);
      this.newStatus.apply(param1,param2);
      this.interpolatedStatus.apply(param1,param2);
      this.positionChanged(param1,param2);
    }

    final public function setPosition(param1:Vector3) : void {
      this.oldStatus.applyPos(param1);
      this.newStatus.applyPos(param1);
      this.interpolatedStatus.applyPos(param1);
      this.positionChanged(param1,DEFAULT_ROTATION);
    }

    public function positionChanged(param1:Vector3, param2:Quaternion) : void {
    }

    public function moveObjects(param1:Vector3) : * {
      this.skinObject.x = param1.x;
      this.skinObject.y = param1.y;
      this.skinObject.z = param1.z;
      this.collisionPrimitive.transform.m03 = param1.x;
      this.collisionPrimitive.transform.m13 = param1.y;
      this.collisionPrimitive.transform.m23 = param1.z + 0.5 * this.skinHeight;
      this.collisionPrimitive.calculateAABB();
      this.lightSource.x = param1.x;
      this.lightSource.y = param1.y;
      this.lightSource.z = param1.z;
    }

    public function addToScene() : void {
      var local1:BattleScene3D = battleService.getBattleScene3D();
      local1.addObject(this.skinObject);
      local1.addObject(this.lightSource);
    }

    public function get state() : FlagState {
      return this._state;
    }

    public function setLocalCarrier(param1:Long, param2:Tank) : void {
      this.isLocalCarrier = true;
      this.setCarrier(param1,param2,0.5);
    }

    public function setRemoteCarrier(param1:Long, param2:Tank) : void {
      this.isLocalCarrier = false;
      this.setCarrier(param1,param2,1);
    }

    private function setCarrier(param1:Long, param2:Tank, param3:Number) : void {
      this._carrierId = param1;
      this._carrier = param2;
      this._state = FlagState.CARRIED;
      if(param2 != null) {
        this.show();
        this.setSkinAlpha(param3);
      } else {
        this.hide();
      }
    }

    public function returnToBase() : void {
      if(this.basePosition == NO_POSITION) {
        this.reset(FlagState.EXILED);
        this.hide();
      } else {
        this.reset(FlagState.AT_BASE);
        this.setPositionAndRotation(this.basePosition,DEFAULT_ROTATION);
        this.show();
      }
    }

    public function dropAt(param1:Vector3) : void {
      this.reset(FlagState.DROPPED);
      this.setPositionAndRotation(param1,DEFAULT_ROTATION);
    }

    public function dispose() : void {
      var local1:BattleScene3D = battleService.getBattleScene3D();
      local1.removeObject(this.skinObject);
      local1.removeObject(this.lightSource);
      var local2:BattleRunner = battleService.getBattleRunner();
      local2.removePhysicsController(this);
      local2.removePhysicsInterpolator(this);
      this.battleObject = null;
    }

    protected function reset(param1:FlagState) : void {
      this._state = param1;
      this._carrierId = null;
      this._carrier = null;
      this.setSkinAlpha(1);
    }

    public function setTriggerCallback(param1:ICommonFlagModeModel) : void {
      this.triggerCallback = param1;
    }

    public function dropFlying(param1:ClientFlagFlyingData, param2:FlagState) : void {
      this.reset(param2);
      this.flyingData.init(param1);
      this.setPositionAndRotation(this.flyingData.currentPosition,DEFAULT_ROTATION);
      if(this.flyingData.isFlying && this._state == FlagState.DROPPED) {
        this.initFalling();
      }
      this.show();
    }

    protected function show() : void {
      this.skinObject.visible = true;
      this.lightSource.visible = true;
    }

    protected function hide() : void {
      this.skinObject.visible = false;
      this.lightSource.visible = false;
    }

    protected function initFalling() : void {
    }

    public function stopFalling() : void {
      this.flyingData.isFlying = false;
      this._state = FlagState.DROPPED;
    }

    public function runBeforePhysicsUpdate(param1:Number) : void {
      if(this.flyingData.isFlying) {
        this.oldStatus.copy(this.newStatus);
        this.flyingData.update(param1);
        this.newStatus.apply(this.flyingData.currentPosition,this.flyingData.currentOrientation);
        this.positionChanged(this.flyingData.currentPosition,this.flyingData.currentOrientation);
        if(!this.flyingData.isFlying && !this.flyingData.isKilled) {
          this.stopFalling();
          this.setPosition(this.flyingData.getFinalPosition());
        }
      }
    }

    private function disablePickup() : void {
      battleService.getBattleRunner().removeTrigger(this);
    }

    public function interpolatePhysicsState(param1:Number, param2:int) : void {
      if(this.flyingData.isFlying) {
        this.interpolatedStatus.interpolate(this.oldStatus,this.newStatus,param1);
      } else {
        this.interpolatedStatus.copy(this.newStatus);
      }
    }

    public function getIndicatorPosition() : Vector3 {
      return this.flyingData.isFlying && this._state == FlagState.DROPPED ? this.flyingData.getFinalPosition() : this.newStatus.position;
    }

    public function isFlying() : Boolean {
      return this.flyingData.isFlying;
    }
  }
}
