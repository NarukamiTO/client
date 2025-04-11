package alternativa.tanks.services.battlegui {
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;

  public interface BattleGUIService extends IEventDispatcher {
    function getViewportContainer() : DisplayObjectContainer;
    function getGuiContainer() : DisplayObjectContainer;
    function getTabContainer() : DisplayObjectContainer;
    function hide() : void;
    function show() : void;
    function setPositionXDefaultLayout(param1:int) : void;
    function getPositionXDefaultLayout() : int;
    function setPositionXInventory(param1:int) : void;
    function getPositionXInventory() : int;
    function resetPositionXInventory() : void;
  }
}
