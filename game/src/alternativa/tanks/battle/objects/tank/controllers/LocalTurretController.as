package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.services.battleinput.MouseLockListener;
  import alternativa.tanks.services.battleinput.MouseMovementListener;
  import alternativa.tanks.utils.MathUtils;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;

  public final class LocalTurretController implements GameActionListener, MouseLockListener, MouseMovementListener, AutoClosable {
    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var settingsService:ISettingsService;

    private static const MOUSE_SENS_MUL:Number = 0.0001;

    private var actionMap:TurretActions = TurretActions.DEFAULT;
    private var tank:Tank;
    private var turret:Turret;
    private var isEnabled:Boolean = false;
    private var left:Boolean = false;
    private var right:Boolean = false;
    private var mouseLookDirection:Number = 0;
    private var lockTurretDirection:Boolean = false;

    public function LocalTurretController(param1:Tank, param2:Turret) {
      super();
      this.tank = param1;
      this.turret = param2;
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      var local3:* = undefined;
      if(param1 == GameActionEnum.LOOK_AROUND) {
        this.lockTurretDirection = param2;
        if(FollowCameraController.getFollowCameraMode() == FollowCameraController.CAMERA_FOLLOWS_MOUSE) {
          if(this.lockTurretDirection) {
            this.turret.setTurretControlState(TurretControlType.TARGET_ANGLE_LOCAL,this.turret.getTurretPhysicsDirection(),Turret.TURN_SPEED_COUNT);
          } else {
            this.turret.setTurretControlState(TurretControlType.TARGET_ANGLE_WORLD,this.mouseLookDirection,Turret.TURN_SPEED_COUNT);
          }
        }
      } else {
        local3 = this.actionMap.getTurretAction(param1);
        if(local3 != null) {
          switch(int(local3)) {
            case TurretActions.LEFT:
              this.rotateLeft(param2);
              break;
            case TurretActions.RIGHT:
              this.rotateRight(param2);
              break;
            case TurretActions.CENTER:
              this.center(param2);
          }
        }
      }
    }

    private function rotateLeft(param1:Boolean) : void {
      this.left = param1;
      this.setDirectionalRotationControlState();
      FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_TURRET);
      battleInputService.releaseMouse();
    }

    private function rotateRight(param1:Boolean) : void {
      this.right = param1;
      this.setDirectionalRotationControlState();
      FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_TURRET);
      battleInputService.releaseMouse();
    }

    private function setDirectionalRotationControlState() : void {
      var local1:int = int(this.left) - int(this.right);
      this.turret.setTurretControlState(TurretControlType.ROTATION_DIRECTION,local1,Turret.TURN_SPEED_COUNT);
    }

    private function center(param1:Boolean) : void {
      if(param1 && !(this.left || this.right)) {
        this.turret.setTurretControlState(TurretControlType.TARGET_ANGLE_LOCAL,0,Turret.TURN_SPEED_COUNT);
        FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_TURRET);
        battleInputService.releaseMouse();
      }
    }

    public function onMouseLock(param1:Boolean) : void {
      if(param1 && FollowCameraController.getFollowCameraMode() != FollowCameraController.CAMERA_FOLLOWS_MOUSE) {
        this.mouseLookDirection = this.tank.getInterpolatedTurretWorldDirection();
        FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_MOUSE);
        FollowCameraController.setFollowCameraDirection(this.mouseLookDirection);
        this.turret.setTurretControlState(TurretControlType.TARGET_ANGLE_WORLD,this.mouseLookDirection,Turret.TURN_SPEED_COUNT);
      }
    }

    public function onMouseRelativeMovement(param1:Number, param2:Number) : void {
      this.mouseLookDirection = MathUtils.clampAngle(this.mouseLookDirection - param1 * settingsService.mouseSensitivity * MOUSE_SENS_MUL);
      FollowCameraController.setFollowCameraDirection(this.mouseLookDirection);
      if(!this.lockTurretDirection) {
        this.turret.setTurretControlState(TurretControlType.TARGET_ANGLE_WORLD,this.mouseLookDirection,Turret.TURN_SPEED_COUNT);
      }
    }

    public function enable() : void {
      if(!this.isEnabled) {
        this.isEnabled = true;
        battleInputService.addGameActionListener(this);
        battleInputService.addMouseLockListener(this);
        battleInputService.addMouseMoveListener(this);
      }
    }

    public function disable() : void {
      if(this.isEnabled) {
        this.isEnabled = false;
        battleInputService.removeGameActionListener(this);
        battleInputService.removeMouseLockListener(this);
        battleInputService.removeMouseMoveListener(this);
        this.left = false;
        this.right = false;
        FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_TURRET);
        this.turret.setTurretControlState(TurretControlType.ROTATION_DIRECTION,0,Turret.TURN_SPEED_COUNT);
      }
    }

    public function onAddToBattle() : void {
      if(FollowCameraController.getFollowCameraMode() == FollowCameraController.CAMERA_FOLLOWS_MOUSE) {
        this.mouseLookDirection = this.tank.getInterpolatedTurretWorldDirection();
        FollowCameraController.setFollowCameraDirection(this.mouseLookDirection);
        this.turret.setTurretControlState(TurretControlType.TARGET_ANGLE_WORLD,this.mouseLookDirection,Turret.TURN_SPEED_COUNT);
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.disable();
    }
  }
}
