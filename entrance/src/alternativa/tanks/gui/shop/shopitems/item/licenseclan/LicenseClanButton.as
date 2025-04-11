package alternativa.tanks.gui.shop.shopitems.item.licenseclan {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.shopitems.item.AbstractGarageItemShopItemButton;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class LicenseClanButton extends AbstractGarageItemShopItemButton {
    [Inject]
    public static var localeService:ILocaleService;

    public function LicenseClanButton(param1:IGameObject) {
      super(param1);
    }

    override protected function getNameLabelValue(param1:IGameObject) : String {
      return localeService.getText(TanksLocale.TEXT_CLAN_LICENSE);
    }
  }
}
