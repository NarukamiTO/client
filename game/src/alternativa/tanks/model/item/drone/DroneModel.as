package alternativa.tanks.model.item.drone {
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.garage.models.item.drone.DroneModelBase;
  import projects.tanks.client.garage.models.item.drone.IDroneModelBase;

  [ModelInfo]
  public class DroneModel extends DroneModelBase implements IDroneModelBase, ItemActionPanel, ObjectLoadListener {
    public function DroneModel() {
      super();
    }

    public function objectLoaded() : void {
      putData(DronePanel,new DronePanel());
    }

    public function handleDoubleClickOnItemPreview() : void {
      this.getActionPanel().onDoubleClick();
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      this.getActionPanel().updateActionElements(param1,param2,object);
    }

    private function getActionPanel() : DronePanel {
      return DronePanel(getData(DronePanel));
    }
  }
}
