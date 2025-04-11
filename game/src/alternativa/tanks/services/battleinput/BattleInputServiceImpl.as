package alternativa.tanks.services.battleinput {
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.utils.BitMask;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.FullScreenEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;

  public class BattleInputServiceImpl extends EventDispatcher implements BattleInputService {
    [Inject]
    public static var fullScreenService:FullscreenService;

    [Inject]
    public static var settingsService:ISettingsService;

    private var stage:Stage;
    private var keysBindingService:KeysBindingService;

    private const inputLocks:BitMask = new BitMask();
    private const mouseLockLocks:BitMask = new BitMask();
    private const pressedKeys:Dictionary = new Dictionary();

    private var activeActions:Dictionary = new Dictionary();

    private const actionListeners:Vector.<GameActionListener> = new Vector.<GameActionListener>();
    private const mouseLockListeners:Vector.<MouseLockListener> = new Vector.<MouseLockListener>();
    private const mouseMoveListeners:Vector.<MouseMovementListener> = new Vector.<MouseMovementListener>();
    private const mouseWheelListeners:Vector.<MouseWheelListener> = new Vector.<MouseWheelListener>();

    private var isFullScreen:Boolean = false;

    private const leftMouseAction:MouseButtonAction = new MouseButtonAction(GameActionEnum.SHOT);
    private const rightMouseAction:MouseButtonAction = new MouseButtonAction(GameActionEnum.LOOK_AROUND);

    private var mouseJustLocked:Boolean = false;
    private var isMouseLockAllowed:Boolean = true;

    public function BattleInputServiceImpl(param1:Stage, param2:KeysBindingService) {
      super();
      this.stage = param1;
      this.keysBindingService = param2;
      this.lock(BattleInputLockType.INACTIVE_BATTLE);
      param1.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      param1.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      param1.addEventListener(Event.DEACTIVATE,this.onPlayerDeactivate);
      param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onLeftMouseDown);
      param1.addEventListener(MouseEvent.MOUSE_UP,this.onLeftMouseUp);
      param1.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,this.onRightMouseDown);
      param1.addEventListener(MouseEvent.RIGHT_MOUSE_UP,this.onRightMouseUp);
      param1.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      param1.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      param1.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
      param1.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreen);
      param1.addEventListener(FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED,this.onFullScreen);
    }

    public function forbidMouseLock() : void {
      this.isMouseLockAllowed = false;
    }

    public function allowMouseLock() : void {
      this.isMouseLockAllowed = true;
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local3:GameActionEnum = null;
      var local2:Boolean = this.pressedKeys[param1.keyCode] != true;
      if(local2) {
        this.pressedKeys[param1.keyCode] = true;
        if(this.isNotLocked()) {
          local3 = this.keysBindingService.getBindingAction(param1.keyCode);
          if(local3 != null) {
            this.handleActionActivation(local3);
          }
        }
      }
    }

    private function handleActionActivation(param1:GameActionEnum) : void {
      var local2:int = int(this.activeActions[param1]) + 1;
      this.activeActions[param1] = local2;
      if(local2 == 1) {
        this.dispatchActionEvent(param1,true);
      }
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      var local3:GameActionEnum = null;
      var local2:Boolean = this.pressedKeys[param1.keyCode] == true;
      if(local2) {
        delete this.pressedKeys[param1.keyCode];
        if(this.isNotLocked()) {
          local3 = this.keysBindingService.getBindingAction(param1.keyCode);
          if(local3 != null) {
            this.handleActionDeactivation(local3);
          }
        }
      }
    }

    private function handleActionDeactivation(param1:GameActionEnum) : void {
      var local2:int = int(this.activeActions[param1]);
      if(local2 > 0) {
        if(local2 == 1) {
          delete this.activeActions[param1];
          this.dispatchActionEvent(param1,false);
        } else {
          this.activeActions[param1] = local2 - 1;
        }
      }
    }

    private function onPlayerDeactivate(param1:Event) : void {
      var local2:* = undefined;
      var local3:Dictionary = null;
      var local4:* = undefined;
      this.leftMouseAction.isActive = false;
      this.rightMouseAction.isActive = false;
      for(local2 in this.pressedKeys) {
        delete this.pressedKeys[local2];
      }
      local3 = this.activeActions;
      this.activeActions = new Dictionary();
      if(this.isNotLocked()) {
        for(local4 in local3) {
          this.dispatchActionEvent(GameActionEnum(local4),false);
        }
      }
    }

    private function onLeftMouseDown(param1:MouseEvent) : void {
      if(this.isLocked()) {
        return;
      }
      if(this.isFullScreen) {
        if(this.stage.mouseLock) {
          this.activateMouseAction(this.leftMouseAction);
        } else if(param1.target == this.stage && this.canLockMouse()) {
          this.setMouseLock(true);
        }
      } else if(param1.target == this.stage && this.canLockMouse()) {
        fullScreenService.switchFullscreen();
      }
    }

    private function onLeftMouseUp(param1:MouseEvent) : void {
      this.deactivateMouseAction(this.leftMouseAction);
    }

    private function onRightMouseDown(param1:MouseEvent) : void {
      if(this.stage.mouseLock) {
        this.activateMouseAction(this.rightMouseAction);
      }
    }

    private function onRightMouseUp(param1:MouseEvent) : void {
      this.deactivateMouseAction(this.rightMouseAction);
    }

    private function onMouseMove(param1:MouseEvent) : void {
      var local2:int = 0;
      if(this.stage.mouseLock) {
        if(this.mouseJustLocked) {
          this.mouseJustLocked = false;
        } else {
          local2 = 0;
          while(local2 < this.mouseMoveListeners.length) {
            this.mouseMoveListeners[local2].onMouseRelativeMovement(param1.movementX,param1.movementY);
            local2++;
          }
        }
      }
    }

    private function onMouseWheel(param1:MouseEvent) : void {
      var local2:int = 0;
      if(this.stage.mouseLock) {
        local2 = 0;
        while(local2 < this.mouseWheelListeners.length) {
          this.mouseWheelListeners[local2].onMouseWheel(param1.delta);
          local2++;
        }
      }
    }

    private function onMouseLeave(param1:Event) : void {
    }

    private function onFullScreen(param1:FullScreenEvent) : void {
      this.isFullScreen = param1.fullScreen;
      if(this.isLocked()) {
        return;
      }
      if(this.isFullScreen) {
        if(this.canLockMouse()) {
          this.setMouseLock(true);
        }
      } else {
        this.deactivateMouseAction(this.leftMouseAction);
        this.deactivateMouseAction(this.rightMouseAction);
        this.setMouseLock(false);
      }
    }

    private function dispatchActionEvent(param1:GameActionEnum, param2:Boolean) : void {
      var local3:int = 0;
      while(local3 < this.actionListeners.length) {
        this.actionListeners[local3].onGameAction(param1,param2);
        local3++;
      }
    }

    public function lock(param1:BattleInputLockType) : void {
      var local4:* = undefined;
      var local2:Boolean = this.isChatLocked();
      var local3:Boolean = this.isInputLocked();
      this.inputLocks.setBits(param1.getMask());
      if(!local2 && this.isChatLocked()) {
        dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.CHAT_LOCKED));
      }
      if(!local3 && this.isInputLocked()) {
        if(this.stage.mouseLock) {
          this.setMouseLock(false);
        }
        for(local4 in this.activeActions) {
          this.dispatchActionEvent(GameActionEnum(local4),false);
        }
        this.activeActions = new Dictionary();
        dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.INPUT_LOCKED));
      }
    }

    public function unlock(param1:BattleInputLockType) : void {
      var local4:* = undefined;
      var local5:GameActionEnum = null;
      var local2:Boolean = this.isChatLocked();
      var local3:Boolean = this.isLocked();
      this.inputLocks.clearBits(param1.getMask());
      if(local2 && !this.isChatLocked()) {
        dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.CHAT_UNLOCKED));
      }
      if(local3 && this.isNotLocked()) {
        for(local4 in this.pressedKeys) {
          local5 = this.keysBindingService.getBindingAction(local4);
          if(local5 != null) {
            this.handleActionActivation(local5);
          }
        }
        if(this.isFullScreen && !this.stage.mouseLock && this.canLockMouse()) {
          this.setMouseLock(true);
        }
        dispatchEvent(new BattleInputLockEvent(BattleInputLockEvent.INPUT_UNLOCKED));
      }
    }

    public function lockMouseLocking(param1:MouseLockLockType) : void {
      var local2:Boolean = this.mouseLockLocks.isEmpty();
      this.mouseLockLocks.setBits(param1.bit);
      if(local2 && this.mouseLockLocks.isNotEmpty()) {
        if(this.stage.mouseLock) {
          this.setMouseLock(false);
        }
      }
    }

    public function unlockMouseLocking(param1:MouseLockLockType) : void {
      var local2:Boolean = this.mouseLockLocks.isNotEmpty();
      this.mouseLockLocks.clearBits(param1.bit);
      if(local2 && this.canLockMouse()) {
        if(this.isNotLocked() && this.isFullScreen && !this.stage.mouseLock) {
          this.setMouseLock(true);
        }
      }
    }

    public function isInputLocked() : Boolean {
      return this.isLocked();
    }

    private function isChatLocked() : Boolean {
      return this.inputLocks.hasAnyBit(BattleInputLockType.MODAL_DIALOG.getMask());
    }

    public function addGameActionListener(param1:GameActionListener) : void {
      var local2:* = undefined;
      if(this.actionListeners.indexOf(param1) < 0) {
        this.actionListeners.push(param1);
        if(this.inputLocks.isEmpty()) {
          for(local2 in this.activeActions) {
            param1.onGameAction(GameActionEnum(local2),true);
          }
        }
      }
    }

    public function removeGameActionListener(param1:GameActionListener) : void {
      var local2:int = int(this.actionListeners.indexOf(param1));
      if(local2 >= 0) {
        this.actionListeners.splice(local2,1);
      }
    }

    public function addMouseLockListener(param1:MouseLockListener) : void {
      var local2:int = int(this.mouseLockListeners.indexOf(param1));
      if(local2 < 0) {
        this.mouseLockListeners.push(param1);
        if(this.stage.mouseLock) {
          param1.onMouseLock(true);
        }
      }
    }

    public function removeMouseLockListener(param1:MouseLockListener) : void {
      var local2:int = int(this.mouseLockListeners.indexOf(param1));
      if(local2 >= 0) {
        this.mouseLockListeners.splice(local2,1);
      }
    }

    public function addMouseMoveListener(param1:MouseMovementListener) : void {
      var local2:int = int(this.mouseMoveListeners.indexOf(param1));
      if(local2 < 0) {
        this.mouseMoveListeners.push(param1);
      }
    }

    public function removeMouseMoveListener(param1:MouseMovementListener) : void {
      var local2:int = int(this.mouseMoveListeners.indexOf(param1));
      if(local2 >= 0) {
        this.mouseMoveListeners.splice(local2,1);
      }
    }

    public function addMouseWheelListener(param1:MouseWheelListener) : void {
      var local2:int = int(this.mouseWheelListeners.indexOf(param1));
      if(local2 < 0) {
        this.mouseWheelListeners.push(param1);
      }
    }

    public function removeMouseWheelListener(param1:MouseWheelListener) : void {
      var local2:int = int(this.mouseWheelListeners.indexOf(param1));
      if(local2 >= 0) {
        this.mouseWheelListeners.splice(local2,1);
      }
    }

    private function activateMouseAction(param1:MouseButtonAction) : void {
      if(!param1.isActive) {
        param1.isActive = true;
        this.handleActionActivation(param1.gameAction);
      }
    }

    private function deactivateMouseAction(param1:MouseButtonAction) : void {
      if(param1.isActive) {
        param1.isActive = false;
        this.handleActionDeactivation(param1.gameAction);
      }
    }

    private function setMouseLock(param1:Boolean) : void {
      if(param1) {
        this.mouseJustLocked = true;
      }
      if(this.isFullScreen) {
        this.stage.mouseLock = param1;
      }
      var local2:int = 0;
      while(local2 < this.mouseLockListeners.length) {
        this.mouseLockListeners[local2].onMouseLock(param1);
        local2++;
      }
    }

    private function isLocked() : Boolean {
      return this.inputLocks.isNotEmpty();
    }

    private function isNotLocked() : Boolean {
      return this.inputLocks.isEmpty();
    }

    private function canLockMouse() : Boolean {
      return this.isMouseLockAllowed && this.mouseLockLocks.isEmpty() && Boolean(settingsService.mouseControl) && Boolean(fullScreenService.isMouseLockEnabled());
    }

    public function releaseMouse() : void {
      if(this.stage.mouseLock) {
        this.setMouseLock(false);
      }
    }
  }
}
