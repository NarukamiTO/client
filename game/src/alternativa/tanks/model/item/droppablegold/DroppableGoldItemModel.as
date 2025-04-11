package alternativa.tanks.model.item.droppablegold {
  import alternativa.tanks.gui.item.actionpanel.SingleActionWithCheckBoxPanel;
  import alternativa.tanks.model.garage.passtoshop.PassToShopService;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import alternativa.tanks.service.item.ItemService;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.garage.models.item.droppablegold.DroppableGoldItemModelBase;
  import projects.tanks.client.garage.models.item.droppablegold.IDroppableGoldItemModelBase;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class DroppableGoldItemModel extends DroppableGoldItemModelBase implements IDroppableGoldItemModelBase, ItemActionPanel, ObjectLoadListener {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var userProperties:IUserPropertiesService;

    [Inject]
    public static var passToShop:PassToShopService;

    public function DroppableGoldItemModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:SingleActionWithCheckBoxPanel = new SingleActionWithCheckBoxPanel(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT,!!passToShop.isPassToShopEnabled() ? this.openPayment : null);
      local1.initCheckBox(TanksLocale.TEXT_GOLD_CHECKBOX,getInitParam().showDroppableGoldAuthor,getFunctionWrapper(this.setShowGoldAuthor));
      putData(SingleActionWithCheckBoxPanel,local1);
    }

    private function setShowGoldAuthor() : void {
      server.setShowGoldAuthor(this.getActionPanel().isChecked());
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      var local3:SingleActionWithCheckBoxPanel = this.getActionPanel();
      local3.updateActionElements(param1);
      local3.enabled = userProperties.rank >= itemService.getMinRankIndex(object);
    }

    public function handleDoubleClickOnItemPreview() : void {
      if(Boolean(passToShop.isPassToShopEnabled()) && this.getActionPanel().enabled) {
        this.openPayment();
      }
    }

    private function openPayment() : void {
      if(passToShop.isPassToShopEnabled()) {
        paymentDisplayService.openPaymentAt(ShopCategoryEnum.GOLD_BOXES);
      }
    }

    private function getActionPanel() : SingleActionWithCheckBoxPanel {
      return SingleActionWithCheckBoxPanel(getData(SingleActionWithCheckBoxPanel));
    }
  }
}
