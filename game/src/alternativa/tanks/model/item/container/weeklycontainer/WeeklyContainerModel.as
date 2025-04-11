package alternativa.tanks.model.item.container.weeklycontainer {
  import alternativa.tanks.model.item.container.ContainerPanelAction;
  import alternativa.tanks.model.item.container.gui.ContainerPanel;
  import alternativa.tanks.model.item.container.gui.opening.ContainerEvent;
  import alternativa.tanks.model.item.container.gui.opening.ContainerOpenDialog;
  import alternativa.tanks.model.item.container.resource.ContainerResource;
  import alternativa.tanks.model.item.countable.ICountableItem;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;
  import projects.tanks.client.garage.models.item.container.weekly.IWeeklyContainerModelBase;
  import projects.tanks.client.garage.models.item.container.weekly.WeeklyContainerModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;

  [ModelInfo]
  public class WeeklyContainerModel extends WeeklyContainerModelBase implements IWeeklyContainerModelBase, ObjectLoadListener, ItemActionPanel, ContainerPanelAction {
    [Inject]
    public static var dialogService:IDialogsService;

    private var containerDialog:ContainerOpenDialog;

    public function WeeklyContainerModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:ContainerPanel = new ContainerPanel(this,getFunctionWrapper(this.openContainerDialog));
      local1.setOpenButtonEnabled(this.getContainersCount() > 0);
      putData(ContainerPanel,local1);
    }

    private function getContainersCount() : int {
      return ICountableItem(object.adapt(ICountableItem)).getCount();
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      var local3:ContainerPanel = this.getPanel();
      local3.updateActionElements(param1);
      local3.setOpenButtonEnabled(this.getContainersCount() > 0);
    }

    private function getPanel() : ContainerPanel {
      return getData(ContainerPanel) as ContainerPanel;
    }

    public function handleDoubleClickOnItemPreview() : void {
    }

    public function needBuyButton() : Boolean {
      return false;
    }

    public function clickBuyButton() : void {
    }

    public function openContainerDialog() : void {
      this.containerDialog = new ContainerOpenDialog(this.getResources(),this.getContainersCount(),true);
      this.containerDialog.addEventListener(ContainerEvent.OPEN,getFunctionWrapper(this.onOpenContainer),false,0,true);
      dialogService.enqueueDialog(this.containerDialog);
    }

    private function getResources() : ContainerResourceCC {
      return ContainerResource(object.adapt(ContainerResource)).getResources();
    }

    private function onOpenContainer(param1:ContainerEvent) : void {
      this.containerDialog.removeEventListener(ContainerEvent.OPEN,getFunctionWrapper(this.onOpenContainer));
      server.open(param1.count);
    }

    public function openSuccessful(param1:Vector.<ContainerGivenItem>) : void {
      this.getPanel().setOpenButtonEnabled(false);
      this.containerDialog.openLoots(param1);
    }

    public function updateCount(param1:int) : void {
    }
  }
}
