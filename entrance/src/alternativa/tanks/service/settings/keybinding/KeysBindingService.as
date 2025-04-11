package alternativa.tanks.service.settings.keybinding {
  import flash.events.IEventDispatcher;

  public interface KeysBindingService extends IEventDispatcher {
    function isFreeKey(param1:uint) : Boolean;
    function setKeyBinding(param1:GameActionEnum, param2:uint, param3:int) : Boolean;
    function getBindingAction(param1:uint) : GameActionEnum;
    function getKeyBinding(param1:GameActionEnum, param2:uint) : uint;
    function getKeyBindings(param1:GameActionEnum) : Vector.<uint>;
    function restoreDefaultBindings() : void;
    function getKeyCodeLabel(param1:uint) : String;
  }
}
