package alternativa.tanks.camera {
  import alternativa.engine3d.core.EllipsoidCollider;
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingEnum;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.services.battleinput.MouseMovementListener;
  import alternativa.tanks.services.battleinput.MouseWheelListener;
  import alternativa.tanks.utils.MathUtils;
  import flash.geom.Point;
  import flash.geom.Vector3D;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class FollowCameraController implements CameraController, IFollowCameraController, MouseWheelListener, MouseMovementListener, GameActionListener {
    [Inject]
    public static var settings:ISettingsService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInputService:BattleInputService;

    public static const CAMERA_FOLLOWS_TURRET:int = 0;
    public static const CAMERA_FOLLOWS_MOUSE:int = 1;

    private static var followCameraMode:int = 0;
    private static var followCameraDirection:Number = 0;

    private static const VERTICAL_CAMERA_SPEED:Number = 0.7;
    private static const ROTATE_SENS:Number = 0.001;
    private static const MIN_CAMERA_ANGLE:Number = 5 * Math.PI / 180;
    private static const COLLIDER_RADIUS:Number = 50;
    private static const MAX_CAMERA_MOVE_SPEED:Number = 5;
    private static const MIN_CAMERA_ROTATE_SPEED:Number = 3;
    private static const MAX_CAMERA_ROTATE_SPEED:Number = 9;
    private static const collisionPoint:Vector3 = new Vector3();
    private static const _v:Vector3 = new Vector3();
    private static const rayOrigin3D:Vector3D = new Vector3D();
    private static const displacement:Vector3D = new Vector3D();
    private static const collisionPoint3D:Vector3D = new Vector3D();
    private static const collisionNormal3D:Vector3D = new Vector3D();
    private static const rotationMatrix:Matrix3 = new Matrix3();
    private static const axis:Vector3 = new Vector3();
    private static const rayDirection:Vector3 = new Vector3();

    private static var maxCameraMoveSpeed:ConsoleVarFloat = new ConsoleVarFloat("cam_maxmove",MAX_CAMERA_MOVE_SPEED,0,MAX_CAMERA_MOVE_SPEED);

    public static var maxPositionError:Number = 10;
    public static var maxAngleError:Number = Math.PI / 180;
    public static var camSpeedThreshold:Number = 10;

    private static const FIXED_PITCH:Number = 10 * Math.PI / 180;
    private static const PITCH_CORRECTION_COEFF:Number = 1;
    private static const MIN_DISTANCE:Number = 300;
    private static const currentPosition:Vector3 = new Vector3();
    private static const currentRotation:Vector3 = new Vector3();
    private static const rayOrigin:Vector3 = new Vector3();
    private static const flatDirection:Vector3 = new Vector3();
    private static const positionDelta:Vector3 = new Vector3();

    private var pitchCorrectionEnabled:Boolean;

    public var inputLocked:Boolean;

    private var distanceFromPivotToCamera:Number = 0;
    private var locked:Boolean;
    private var keyUpPressed:Boolean;
    private var keyDownPressed:Boolean;
    private var active:Boolean;
    private var target:CameraTarget;
    private var position:Vector3 = new Vector3();
    private var rotation:Vector3 = new Vector3();
    private var targetPosition:Vector3 = new Vector3();
    private var targetDirection:Vector3 = new Vector3();
    private var linearSpeed:Number = 0;
    private var pitchSpeed:Number = 0;
    private var yawSpeed:Number = 0;
    private var cameraPositionData:CameraPositionData = new CameraPositionData();
    private var baseElevation:Number;
    private var cameraRelativeHeight:Number = 0;
    private var cameraPosition:Point = new Point();
    private var point0:Point;
    private var point1:Point;
    private var point2:Point;
    private var point3:Point;
    private var collider:EllipsoidCollider;
    private var collisionObject:Object3D;
    private var _mouseWheel:int;
    private var mouseLookShift:Number = 0;

    public function FollowCameraController() {
      super();
      this.point0 = new Point(145,545);
      this.point1 = new Point(930,1395);
      this.point2 = new Point(2245,1565);
      this.point3 = new Point(3105,760);
      this.collider = new EllipsoidCollider(COLLIDER_RADIUS,COLLIDER_RADIUS,COLLIDER_RADIUS);
      var local1:Number = Number(storageService.getStorage().data["cameraT"]);
      if(isNaN(local1)) {
        local1 = 0.2;
      }
      this.setCameraRelativeHeight(local1);
    }

    public static function getFollowCameraMode() : int {
      return followCameraMode;
    }

    public static function setFollowCameraMode(param1:int) : void {
      followCameraMode = param1;
    }

    public static function getFollowCameraDirection() : Number {
      return followCameraDirection;
    }

    public static function setFollowCameraDirection(param1:Number) : void {
      followCameraDirection = param1;
    }

    private static function vector3To3D(param1:Vector3, param2:Vector3D) : void {
      param2.x = param1.x;
      param2.y = param1.y;
      param2.z = param1.z;
    }

    private static function getLinearSpeed(param1:Number) : Number {
      return maxCameraMoveSpeed.value * param1;
    }

    private static function bezier(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number {
      var local6:Number = 3 * (param3 - param2);
      var local7:Number = 3 * param2 - 6 * param3 + 3 * param4;
      var local8:Number = -param2 + 3 * param3 - 3 * param4 + param5;
      return param2 + param1 * local6 + param1 * param1 * local7 + param1 * param1 * param1 * local8;
    }

    private function configAlternateCamera(param1:SettingsServiceEvent = null) : void {
      if(param1 == null || param1.getSetting() == SettingEnum.ALTERNATE_CAMERA) {
        this.pitchCorrectionEnabled = !settings.alternateCamera;
      }
    }

    public function setCollisionObject(param1:Object3D) : void {
      this.collisionObject = param1;
    }

    public function setTarget(param1:CameraTarget) : void {
      this.target = param1;
    }

    public function setCurrentState(param1:Vector3, param2:Vector3) : void {
      this.targetPosition.copy(param1);
      this.targetDirection.copy(param2);
      this.getCameraPositionData(param1,param2,this.cameraPositionData);
      this.position.copy(this.cameraPositionData.position);
      this.rotation.x = this.getPitchAngle(this.cameraPositionData) - 0.5 * Math.PI;
      this.rotation.y = 0;
      this.rotation.z = Math.atan2(-param2.x,param2.y);
    }

    public function activate(param1:GameCamera) : void {
      if(!this.active) {
        this.active = true;
        this.configAlternateCamera();
        settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.configAlternateCamera);
        param1.readPosition(this.position);
        param1.readRotation(this.rotation);
        battleInputService.addGameActionListener(this);
        battleInputService.addMouseMoveListener(this);
        battleInputService.addMouseWheelListener(this);
      }
    }

    public function deactivate() : void {
      if(this.active) {
        this.active = false;
        battleInputService.removeGameActionListener(this);
        battleInputService.removeMouseMoveListener(this);
        battleInputService.removeMouseWheelListener(this);
        settings.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.configAlternateCamera);
        storageService.getStorage().data["cameraT"] = this.cameraRelativeHeight;
        this.keyUpPressed = false;
        this.keyDownPressed = false;
      }
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
      var local4:Number = param3 * 0.001;
      if(local4 > 0.1) {
        local4 = 0.1;
      }
      this.updateCameraHeight(local4);
      if(!this.locked && this.target != null) {
        this.target.getCameraParams(this.targetPosition,this.targetDirection);
      }
      this.getCameraPositionData(this.targetPosition,this.targetDirection,this.cameraPositionData);
      positionDelta.diff(this.cameraPositionData.position,this.position);
      var local5:Number = positionDelta.length();
      if(local5 > maxPositionError) {
        this.linearSpeed = getLinearSpeed(local5 - maxPositionError);
      }
      var local6:Number = this.linearSpeed * local4;
      if(local6 > local5) {
        local6 = local5;
      }
      positionDelta.normalize().scale(local6);
      var local7:Number = this.getPitchAngle(this.cameraPositionData);
      var local8:Number = Math.atan2(-this.targetDirection.x,this.targetDirection.y);
      var local9:Number = MathUtils.clampAngle(this.rotation.x + 0.5 * Math.PI);
      var local10:Number = MathUtils.clampAngle(this.rotation.z);
      var local11:Number = MathUtils.clampAngle(local7 - local9);
      this.pitchSpeed = this.getAngularSpeed(local11,this.pitchSpeed);
      var local12:Number = this.pitchSpeed * local4;
      if(local11 > 0 && local12 > local11 || local11 < 0 && local12 < local11) {
        local12 = local11;
      }
      var local13:Number = MathUtils.clampAngle(local8 - local10);
      this.yawSpeed = this.getAngularSpeed(local13,this.yawSpeed);
      var local14:Number = this.yawSpeed * local4;
      if(local13 > 0 && local14 > local13 || local13 < 0 && local14 < local13) {
        local14 = local13;
      }
      this.linearSpeed = MathUtils.snap(this.linearSpeed,0,camSpeedThreshold);
      this.pitchSpeed = MathUtils.snap(this.pitchSpeed,0,camSpeedThreshold);
      this.yawSpeed = MathUtils.snap(this.yawSpeed,0,camSpeedThreshold);
      this.position.add(positionDelta);
      this.rotation.x += local12;
      this.rotation.y = MathUtils.moveValueTowards(this.rotation.y,0,local4);
      this.rotation.z += local14;
      currentPosition.copy(this.position);
      currentRotation.copy(this.rotation);
      param1.setPosition(currentPosition);
      param1.setRotation(currentRotation);
    }

    public function setLocked(param1:Boolean) : void {
      this.locked = param1;
      if(param1) {
        this._mouseWheel = 0;
      }
    }

    private function setCameraRelativeHeight(param1:Number) : void {
      this.cameraRelativeHeight = MathUtils.clamp(param1,0,1);
      var local2:Number = MathUtils.clamp(this.cameraRelativeHeight + this.mouseLookShift * 0.1,0,1);
      this.cameraPosition.x = bezier(local2,this.point0.x,this.point1.x,this.point2.x,this.point3.x);
      this.cameraPosition.y = bezier(local2,this.point0.y,this.point1.y,this.point2.y,this.point3.y);
      this.baseElevation = Math.atan2(this.cameraPosition.x,this.cameraPosition.y);
      this.distanceFromPivotToCamera = this.cameraPosition.length;
    }

    public function getCameraState(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3) : void {
      this.getCameraPositionData(param1,param2,this.cameraPositionData);
      param4.x = this.getPitchAngle(this.cameraPositionData) - 0.5 * Math.PI;
      param4.z = Math.atan2(-param2.x,param2.y);
      param3.copy(this.cameraPositionData.position);
    }

    private function getCameraPositionData(param1:Vector3, param2:Vector3, param3:CameraPositionData) : void {
      var local7:Number = NaN;
      var local4:Number = this.baseElevation;
      var local5:Number = Math.sqrt(param2.x * param2.x + param2.y * param2.y);
      if(local5 < 0.00001) {
        flatDirection.x = 1;
        flatDirection.y = 0;
      } else {
        flatDirection.x = param2.x / local5;
        flatDirection.y = param2.y / local5;
      }
      param3.extraPitch = 0;
      param3.t = 1;
      rayOrigin.copy(param1);
      axis.x = flatDirection.y;
      axis.y = -flatDirection.x;
      flatDirection.reverse();
      rotationMatrix.fromAxisAngle(axis,-local4);
      rotationMatrix.transformVector(flatDirection,rayDirection);
      this.getCollisionPoint(rayOrigin,rayDirection,this.distanceFromPivotToCamera,collisionPoint);
      var local6:Number = _v.copy(rayOrigin).subtract(collisionPoint).length();
      param3.t = local6 / this.distanceFromPivotToCamera;
      if(local6 < MIN_DISTANCE) {
        rayOrigin.copy(collisionPoint);
        local7 = MIN_DISTANCE - local6;
        this.getCollisionPoint(rayOrigin,Vector3.Z_AXIS,local7,collisionPoint);
      }
      param3.position.copy(collisionPoint);
    }

    private function getCollisionPoint(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : void {
      var local5:Number = NaN;
      vector3To3D(param1,rayOrigin3D);
      displacement.x = param3 * param2.x;
      displacement.y = param3 * param2.y;
      displacement.z = param3 * param2.z;
      if(this.collider.getCollision(rayOrigin3D,displacement,collisionPoint3D,collisionNormal3D,this.collisionObject)) {
        local5 = COLLIDER_RADIUS + 0.1;
        param4.x = collisionPoint3D.x + local5 * collisionNormal3D.x;
        param4.y = collisionPoint3D.y + local5 * collisionNormal3D.y;
        param4.z = collisionPoint3D.z + local5 * collisionNormal3D.z;
      } else {
        param4.copy(param1).addScaled(param3,param2);
      }
    }

    private function updateCameraHeight(param1:Number) : void {
      var local2:int = 0;
      if(this._mouseWheel < 0) {
        this.keyUpPressed = true;
        this.keyDownPressed = false;
        ++this._mouseWheel;
        if(this._mouseWheel == 0) {
          this.keyUpPressed = false;
        }
      } else if(this._mouseWheel > 0) {
        this.keyUpPressed = false;
        this.keyDownPressed = true;
        --this._mouseWheel;
        if(this._mouseWheel == 0) {
          this.keyDownPressed = false;
        }
      }
      if(!this.inputLocked && this.keyUpPressed != this.keyDownPressed) {
        local2 = this.keyUpPressed ? 1 : -1;
        this.setCameraRelativeHeight(this.cameraRelativeHeight + local2 * VERTICAL_CAMERA_SPEED * param1);
      } else {
        this.setCameraRelativeHeight(this.cameraRelativeHeight);
      }
    }

    private function getAngularSpeed(param1:Number, param2:Number) : Number {
      var local3:Number = followCameraMode == CAMERA_FOLLOWS_TURRET ? MIN_CAMERA_ROTATE_SPEED : MAX_CAMERA_ROTATE_SPEED;
      if(param1 < -maxAngleError) {
        return local3 * (param1 + maxAngleError);
      }
      if(param1 > maxAngleError) {
        return local3 * (param1 - maxAngleError);
      }
      return param2;
    }

    private function getPitchAngle(param1:CameraPositionData) : Number {
      var local2:Number = this.baseElevation - FIXED_PITCH;
      if(local2 < 0) {
        local2 = 0;
      }
      var local3:Number = param1.t;
      if(local3 >= 1 || local2 < MIN_CAMERA_ANGLE || !this.pitchCorrectionEnabled) {
        return param1.extraPitch - local2;
      }
      var local4:Number = this.cameraPosition.x;
      return param1.extraPitch - Math.atan2(local3 * local4,PITCH_CORRECTION_COEFF * local4 * (1 / Math.tan(local2) - (1 - local3) / Math.tan(this.baseElevation)));
    }

    public function onMouseRelativeMovement(param1:Number, param2:Number) : void {
      if(!this.locked) {
        this.mouseLookShift += param2 * ROTATE_SENS * this.getMouseMoveMultiplier();
        this.mouseLookShift = MathUtils.clamp(this.mouseLookShift,-1,1);
      }
    }

    public function onMouseWheel(param1:int) : void {
      var local2:Boolean = false;
      param1 *= this.getMouseMoveMultiplier();
      if(!this.locked) {
        local2 = false;
        if(param1 > 1) {
          if(this._mouseWheel < 0) {
            this._mouseWheel = 0;
          }
          local2 = true;
        }
        if(param1 < 1) {
          if(this._mouseWheel > 0) {
            this._mouseWheel = 0;
          }
          local2 = true;
        }
        if(local2) {
          this._mouseWheel = param1 * 2;
        }
      }
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      switch(param1) {
        case GameActionEnum.FOLLOW_CAMERA_UP:
          this.keyUpPressed = param2;
          break;
        case GameActionEnum.FOLLOW_CAMERA_DOWN:
          this.keyDownPressed = param2;
      }
    }

    private function getMouseMoveMultiplier() : int {
      return !!settings.mouseYInverse ? -1 : 1;
    }
  }
}
