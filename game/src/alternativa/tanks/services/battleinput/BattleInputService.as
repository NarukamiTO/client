package alternativa.tanks.services.battleinput {
  import flash.events.IEventDispatcher;

  public interface BattleInputService extends IEventDispatcher {
    function lock(param1:BattleInputLockType) : void;
    function unlock(param1:BattleInputLockType) : void;
    function lockMouseLocking(param1:MouseLockLockType) : void;
    function unlockMouseLocking(param1:MouseLockLockType) : void;
    function isInputLocked() : Boolean;
    function addGameActionListener(param1:GameActionListener) : void;
    function removeGameActionListener(param1:GameActionListener) : void;
    function addMouseLockListener(param1:MouseLockListener) : void;
    function removeMouseLockListener(param1:MouseLockListener) : void;
    function addMouseMoveListener(param1:MouseMovementListener) : void;
    function removeMouseMoveListener(param1:MouseMovementListener) : void;
    function addMouseWheelListener(param1:MouseWheelListener) : void;
    function removeMouseWheelListener(param1:MouseWheelListener) : void;
    function releaseMouse() : void;
    function forbidMouseLock() : void;
    function allowMouseLock() : void;
  }
}
