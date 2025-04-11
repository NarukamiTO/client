package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.shaft.ShaftAimingStateListener;
  import alternativa.tanks.models.weapon.shaft.ShaftAimingType;
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.services.battleinput.MouseLockListener;
  import alternativa.tanks.services.battleinput.MouseMovementListener;
  import flash.display.Stage;
  import flash.utils.Dictionary;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;

  public class LocalShaftController implements ShaftAimingStateListener, GameActionListener, MouseLockListener, MouseMovementListener, LogicUnit {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var settings:ISettingsService;

    private static const actionsMap:TurretActions = createActionsMap();

    private var weaponPlatform:WeaponPlatform;
    private var weapon:ShaftWeapon;
    private var weaponMount:WeaponMount;
    private var localTurretController:LocalTurretController;
    private var isMouseLocked:Boolean = false;
    private var isActive:Boolean = false;
    private var left:Boolean = false;
    private var right:Boolean = false;
    private var up:Boolean = false;
    private var down:Boolean = false;
    private var mouseMovementX:Number = 0;
    private var mouseMovementY:Number = 0;
    private var isInitialKeyboardActionsSetup:Boolean = false;
    private var initialKeyboardActions:Dictionary = new Dictionary();
    private var lockedDirection:Number = 0;
    private var isLookAround:Boolean = false;

    public function LocalShaftController(param1:WeaponPlatform, param2:ShaftWeapon, param3:LocalTurretController) {
      super();
      this.weaponPlatform = param1;
      this.weapon = param2;
      this.weaponMount = param1.getWeaponMount();
      this.localTurretController = param3;
    }

    private static function createActionsMap() : TurretActions {
      var local1:TurretActions = new TurretActions();
      local1.setMapping(GameActionEnum.ROTATE_TURRET_LEFT,TurretActions.LEFT);
      local1.setMapping(GameActionEnum.ROTATE_TURRET_RIGHT,TurretActions.RIGHT);
      local1.setMapping(GameActionEnum.CENTER_TURRET,TurretActions.CENTER);
      local1.setMapping(GameActionEnum.CHASSIS_LEFT_MOVEMENT,TurretActions.LEFT);
      local1.setMapping(GameActionEnum.CHASSIS_RIGHT_MOVEMENT,TurretActions.RIGHT);
      local1.setMapping(GameActionEnum.CHASSIS_FORWARD_MOVEMENT,TurretActions.UP);
      local1.setMapping(GameActionEnum.CHASSIS_BACKWARD_MOVEMENT,TurretActions.DOWN);
      return local1;
    }

    public function destroy() : void {
      this.removeAllListeners();
    }

    private function removeAllListeners() : void {
      battleService.getBattleRunner().removeInputProcessor(this);
      battleInputService.removeGameActionListener(this);
      battleInputService.removeMouseLockListener(this);
      battleInputService.removeMouseMoveListener(this);
    }

    public function onAimingStart() : void {
      if(!this.isActive) {
        this.isActive = true;
        this.localTurretController.disable();
        this.left = false;
        this.right = false;
        this.up = false;
        this.down = false;
        this.isMouseLocked = false;
        this.isLookAround = false;
        this.mouseMovementX = 0;
        this.mouseMovementY = 0;
        battleService.getBattleRunner().addInputProcessor(this);
        battleInputService.addMouseLockListener(this);
        this.isInitialKeyboardActionsSetup = this.isMouseLocked;
        this.initialKeyboardActions = new Dictionary();
        battleInputService.addGameActionListener(this);
        this.isInitialKeyboardActionsSetup = false;
      }
    }

    public function onAimingStop() : void {
      if(this.isActive) {
        this.isActive = false;
        this.removeAllListeners();
        if(this.weaponMount.getTurretRealControlType() == TurretControlType.ROTATION_DIRECTION) {
          this.weaponMount.setTurretControlState(TurretControlType.ROTATION_DIRECTION,0,0);
        }
        this.localTurretController.enable();
      }
    }

    public function onAimedShot() : void {
      this.removeAllListeners();
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param1 == GameActionEnum.LOOK_AROUND) {
        this.handleLookaround(param2);
        return;
      }
      var local3:* = actionsMap.getTurretAction(param1);
      if(local3 != null) {
        if(this.isInitialKeyboardActionsSetup) {
          this.initialKeyboardActions[param1] = true;
        } else if(this.initialKeyboardActions[param1] != null) {
          delete this.initialKeyboardActions[param1];
        } else {
          switch(local3) {
            case TurretActions.LEFT:
              this.rotateLeft(param2);
              break;
            case TurretActions.RIGHT:
              this.rotateRight(param2);
              break;
            case TurretActions.CENTER:
              this.center(param2);
              break;
            case TurretActions.UP:
              this.rotateUp(param2);
              break;
            case TurretActions.DOWN:
              this.rotateDown(param2);
          }
        }
      }
    }

    private function handleLookaround(param1:Boolean) : void {
      this.isLookAround = param1;
      this.weapon.pauseElevation(param1);
      if(param1) {
        this.lockedDirection = this.weaponMount.getTurretPhysicsDirection();
      }
    }

    private function rotateLeft(param1:Boolean) : void {
      this.left = param1;
      this.setDirectionalTurretRotation();
    }

    private function rotateRight(param1:Boolean) : void {
      this.right = param1;
      this.setDirectionalTurretRotation();
    }

    private function setDirectionalTurretRotation() : void {
      this.setDirectionalAmingType();
      var local1:int = int(this.left) - int(this.right);
      this.weaponMount.setTurretControlState(TurretControlType.ROTATION_DIRECTION,local1,Turret.TURN_SPEED_COUNT);
    }

    private function center(param1:Boolean) : void {
      if(param1 && !(this.left || this.right)) {
        this.setDirectionalAmingType();
        this.weaponMount.setTurretControlState(TurretControlType.TARGET_ANGLE_LOCAL,0,Turret.TURN_SPEED_COUNT);
      }
    }

    private function rotateUp(param1:Boolean) : void {
      this.up = param1;
      this.setDirectionalElevation();
    }

    private function rotateDown(param1:Boolean) : void {
      this.down = param1;
      this.setDirectionalElevation();
    }

    private function setDirectionalElevation() : void {
      this.setDirectionalAmingType();
      this.weapon.setElevationDirecton(int(this.up) - int(this.down));
    }

    private function setDirectionalAmingType() : void {
      this.isLookAround = false;
      battleInputService.releaseMouse();
      this.weapon.setAimingType(ShaftAimingType.DIRECTIONAL);
    }

    public function onMouseLock(param1:Boolean) : void {
      if(this.isMouseLocked != param1) {
        this.isMouseLocked = param1;
        if(param1) {
          battleInputService.addMouseMoveListener(this);
          this.weapon.setAimingType(ShaftAimingType.MOUSE);
        } else {
          this.mouseMovementX = 0;
          this.mouseMovementY = 0;
          battleInputService.removeMouseMoveListener(this);
        }
      }
    }

    public function onMouseRelativeMovement(param1:Number, param2:Number) : void {
      this.mouseMovementX += param1;
      this.mouseMovementY += param2 * (!!settings.mouseYInverseShaftAim ? -1 : 1);
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:Number = NaN;
      if(this.isMouseLocked) {
        this.weapon.changeTargetElevation(-this.mouseMovementY * this.getCameraVerticalFov() / display.stage.stageHeight);
        this.weapon.changeTargetDirection(-this.mouseMovementX * this.getCameraHorizontalFov() / display.stage.stageWidth);
        local3 = this.isLookAround ? this.lockedDirection : this.weapon.getTargetDirection();
        this.weaponMount.setTurretControlState(TurretControlType.TARGET_ANGLE_LOCAL,local3,Turret.TURN_SPEED_COUNT);
        this.mouseMovementX = 0;
        this.mouseMovementY = 0;
      }
    }

    private function getCameraVerticalFov() : Number {
      return 2 * Math.atan(display.stage.stageHeight / (2 * this.getCameraFocalLen()));
    }

    private function getCameraHorizontalFov() : Number {
      return 2 * Math.atan(display.stage.stageWidth / (2 * this.getCameraFocalLen()));
    }

    private function getCameraFocalLen() : Number {
      var local1:Stage = display.stage;
      var local2:GameCamera = battleService.getBattleScene3D().getCamera();
      return Math.sqrt(local1.stageWidth * local1.stageWidth + local1.stageHeight * local1.stageHeight) / (2 * Math.tan(local2.fov * 0.5));
    }
  }
}
