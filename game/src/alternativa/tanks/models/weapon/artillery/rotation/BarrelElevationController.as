package alternativa.tanks.models.weapon.artillery.rotation {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.controllers.BarrelElevator;
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.services.battleinput.MouseLockListener;
  import alternativa.tanks.services.battleinput.MouseMovementListener;
  import alternativa.tanks.utils.MathUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;

  public class BarrelElevationController implements GameActionListener, MouseLockListener, MouseMovementListener {
    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var fullScreenService:FullscreenService;

    private static const MOUSE_SENS_MUL:Number = 0.0001;

    private var tank:Tank;
    private var barrelElevator:BarrelElevator;
    private var isEnabled:Boolean = false;
    private var up:Boolean;
    private var down:Boolean;
    private var mouseLookDirection:Number = 0;

    public function BarrelElevationController(param1:Tank, param2:BarrelElevator) {
      super();
      this.tank = param1;
      this.barrelElevator = param2;
    }

    public function enable() : void {
      if(!this.isEnabled) {
        this.isEnabled = true;
        battleInputService.addMouseLockListener(this);
        battleInputService.addMouseMoveListener(this);
        battleInputService.addGameActionListener(this);
      }
    }

    public function disable() : void {
      if(this.isEnabled) {
        this.isEnabled = false;
        this.up = false;
        this.down = false;
        this.barrelElevator.setUserControl(BarrelElevator.STOP);
        battleInputService.removeMouseLockListener(this);
        battleInputService.removeMouseMoveListener(this);
        battleInputService.removeGameActionListener(this);
      }
    }

    public function onMouseLock(param1:Boolean) : void {
      if(param1) {
        if(FollowCameraController.getFollowCameraMode() != FollowCameraController.CAMERA_FOLLOWS_MOUSE) {
          this.mouseLookDirection = this.tank.getInterpolatedTurretWorldDirection();
          FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_MOUSE);
          FollowCameraController.setFollowCameraDirection(this.mouseLookDirection);
        }
      } else if(!fullScreenService.isFullScreenNow()) {
        FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_TURRET);
      }
    }

    public function onMouseRelativeMovement(param1:Number, param2:Number) : void {
      this.mouseLookDirection = MathUtils.clampAngle(this.mouseLookDirection - param1 * settingsService.mouseSensitivity * MOUSE_SENS_MUL);
      FollowCameraController.setFollowCameraDirection(this.mouseLookDirection);
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      switch(param1) {
        case GameActionEnum.ROTATE_TURRET_LEFT:
          this.rotateDown(param2);
          break;
        case GameActionEnum.ROTATE_TURRET_RIGHT:
          this.rotateUp(param2);
          break;
        case GameActionEnum.CENTER_TURRET:
          this.center(param2);
          break;
        case GameActionEnum.LOOK_AROUND:
          if(param2) {
            battleInputService.releaseMouse();
            FollowCameraController.setFollowCameraMode(FollowCameraController.CAMERA_FOLLOWS_TURRET);
          }
      }
    }

    private function rotateUp(param1:Boolean) : void {
      this.up = param1;
      this.setDirectionalRotation();
    }

    private function rotateDown(param1:Boolean) : void {
      this.down = param1;
      this.setDirectionalRotation();
    }

    private function setDirectionalRotation() : void {
      if(this.up == this.down) {
        this.barrelElevator.setUserControl(BarrelElevator.STOP);
      } else if(this.up) {
        this.barrelElevator.setUserControl(BarrelElevator.UP);
      } else if(this.down) {
        this.barrelElevator.setUserControl(BarrelElevator.DOWN);
      }
    }

    private function center(param1:Boolean) : void {
      if(param1 && !(this.up || this.down)) {
        this.barrelElevator.setUserControl(BarrelElevator.CENTER);
      }
    }

    public function onAddToBattle() : void {
      if(FollowCameraController.getFollowCameraMode() == FollowCameraController.CAMERA_FOLLOWS_MOUSE) {
        this.mouseLookDirection = this.tank.getInterpolatedTurretWorldDirection();
        FollowCameraController.setFollowCameraDirection(this.mouseLookDirection);
      }
    }
  }
}
