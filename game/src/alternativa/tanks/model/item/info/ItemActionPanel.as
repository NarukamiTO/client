package alternativa.tanks.model.item.info {
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;

  [ModelInterface]
  public interface ItemActionPanel {
    function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void;
    function handleDoubleClickOnItemPreview() : void;
  }
}
