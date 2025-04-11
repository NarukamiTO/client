package alternativa.tanks.model.item.info {
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemActionPanelEvents implements ItemActionPanel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ItemActionPanelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      var i:int = 0;
      var m:ItemActionPanel = null;
      var actionContainer:DisplayObjectContainer = param1;
      var garageWindowDispatcher:IEventDispatcher = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemActionPanel(this.impl[i]);
          m.updateActionElements(actionContainer,garageWindowDispatcher);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function handleDoubleClickOnItemPreview() : void {
      var i:int = 0;
      var m:ItemActionPanel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemActionPanel(this.impl[i]);
          m.handleDoubleClickOnItemPreview();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
