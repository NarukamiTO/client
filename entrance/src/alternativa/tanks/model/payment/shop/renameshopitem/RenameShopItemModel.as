package alternativa.tanks.model.payment.shop.renameshopitem {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.customname.DetailsViewWithDescription;
  import alternativa.tanks.gui.shop.shopitems.item.customname.ShopButtonWithCustomName;
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsView;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.renameshopitem.IRenameShopItemModelBase;
  import projects.tanks.client.panel.model.shop.renameshopitem.RenameShopItemModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  [ModelInfo]
  public class RenameShopItemModel extends RenameShopItemModelBase implements IRenameShopItemModelBase, ShopItemView, ShopItemDetailsView {
    [Inject]
    public static var localeService:ILocaleService;

    public function RenameShopItemModel() {
      super();
    }

    public function getButtonView() : ShopButton {
      return new ShopButtonWithCustomName(object,getInitParam().name);
    }

    public function getDetailsView() : ShopItemDetails {
      return new DetailsViewWithDescription(object,localeService.getText(TanksLocale.TEXT_RENAME_ITEM_SHOP_DESCRIPTION));
    }

    public function isDetailedViewRequired() : Boolean {
      return true;
    }
  }
}
