package alternativa.tanks.model.item.container.lootboxes {
  import alternativa.tanks.model.garage.passtoshop.PassToShopService;
  import alternativa.tanks.model.item.container.ContainerPanelAction;
  import alternativa.tanks.model.item.container.gui.ContainerPanel;
  import alternativa.tanks.model.item.container.gui.opening.ContainerEvent;
  import alternativa.tanks.model.item.container.gui.opening.ContainerOpenDialog;
  import alternativa.tanks.model.item.container.resource.ContainerResource;
  import alternativa.tanks.model.item.countable.ICountableItem;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.garage.models.item.container.ContainerGivenItem;
  import projects.tanks.client.garage.models.item.container.lootbox.ILootBoxModelBase;
  import projects.tanks.client.garage.models.item.container.lootbox.LootBoxModelBase;
  import projects.tanks.client.garage.models.item.container.resources.ContainerResourceCC;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;

  [ModelInfo]
  public class LootBoxModel extends LootBoxModelBase implements ILootBoxModelBase, ObjectLoadPostListener, ItemActionPanel, ContainerPanelAction {
    [Inject]
    public static var paymentService:PaymentDisplayService;

    [Inject]
    public static var passToShop:PassToShopService;

    [Inject]
    public static var dialogService:IDialogsService;

    private var lootBoxDialog:ContainerOpenDialog;

    public function LootBoxModel() {
      super();
    }

    public function objectLoadedPost() : void {
      var local1:ContainerPanel = new ContainerPanel(this,getFunctionWrapper(this.openContainerDialog));
      local1.setOpenButtonEnabled(this.getContainersCount() > 0);
      putData(ContainerPanel,local1);
    }

    private function getContainersCount() : int {
      return ICountableItem(object.adapt(ICountableItem)).getCount();
    }

    public function openSuccessful(param1:Vector.<ContainerGivenItem>) : void {
      this.lootBoxDialog.openLoots(param1);
      this.getPanel().setOpenButtonEnabled(this.getContainersCount() > 0);
    }

    public function updateCount(param1:int) : void {
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
      if(passToShop.isPassToShopEnabled()) {
        paymentService.openPaymentAt(ShopCategoryEnum.LOOT_BOXES);
      }
    }

    public function needBuyButton() : Boolean {
      return true;
    }

    public function clickBuyButton() : void {
      paymentService.openPaymentAt(ShopCategoryEnum.LOOT_BOXES);
    }

    public function openContainerDialog() : void {
      this.lootBoxDialog = new ContainerOpenDialog(this.getResources(),this.getContainersCount(),false);
      this.lootBoxDialog.addEventListener(ContainerEvent.OPEN,getFunctionWrapper(this.onOpenContainer),false,0,true);
      dialogService.enqueueDialog(this.lootBoxDialog);
    }

    private function getResources() : ContainerResourceCC {
      return ContainerResource(object.adapt(ContainerResource)).getResources();
    }

    private function onOpenContainer(param1:ContainerEvent) : void {
      this.lootBoxDialog.removeEventListener(ContainerEvent.OPEN,getFunctionWrapper(this.onOpenContainer));
      server.open(param1.count);
    }
  }
}
