package alternativa.tanks.model.item.info {
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemActionPanelAdapt implements ItemActionPanel {
    private var object:IGameObject;
    private var impl:ItemActionPanel;

    public function ItemActionPanelAdapt(param1:IGameObject, param2:ItemActionPanel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      var actionContainer:DisplayObjectContainer = param1;
      var garageWindowDispatcher:IEventDispatcher = param2;
      try {
        Model.object = this.object;
        this.impl.updateActionElements(actionContainer,garageWindowDispatcher);
      }
      finally {
        Model.popObject();
      }
    }

    public function handleDoubleClickOnItemPreview() : void {
      try {
        Model.object = this.object;
        this.impl.handleDoubleClickOnItemPreview();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
