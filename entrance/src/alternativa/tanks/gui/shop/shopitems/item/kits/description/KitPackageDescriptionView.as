package alternativa.tanks.gui.shop.shopitems.item.kits.description {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import alternativa.tanks.gui.shop.shopitems.item.kits.description.panel.KitPackageDescriptionPanel;
  import alternativa.tanks.model.payment.shop.kit.KitPackage;
  import assets.Diamond;
  import controls.Money;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class KitPackageDescriptionView extends ShopItemDetails {
    [Inject]
    public static var localeService:ILocaleService;

    public static const LEFT_TOP_MARGIN:int = 12;
    public static const ITEM_HEIGHT:int = 17;
    public static const WIDTH:int = 350;

    private var container:Sprite;

    public function KitPackageDescriptionView(param1:IGameObject) {
      super(param1);
      this.container = new Sprite();
      this.container.y = 3;
      addChild(this.container);
      this.addPanel();
      this.addHeader();
      this.addRows();
      this.addSummary();
    }

    private function addPanel() : void {
      var local1:KitPackageDescriptionPanel = new KitPackageDescriptionPanel();
      local1.resize(this.kitPackage.getItemInfos().length);
      this.container.addChild(local1);
    }

    private function addHeader() : void {
      var local2:LabelBase = null;
      var local1:LabelBase = new LabelBase();
      local1.color = ColorConstants.GREEN_LABEL;
      local1.align = TextFormatAlign.LEFT;
      local1.text = localeService.getText(TanksLocale.TEXT_ITEMS_IN_KIT);
      local1.x = LEFT_TOP_MARGIN;
      local1.y = LEFT_TOP_MARGIN;
      this.container.addChild(local1);
      local2 = new LabelBase();
      local2.color = ColorConstants.GREEN_LABEL;
      local2.align = TextFormatAlign.RIGHT;
      local2.text = localeService.getText(TanksLocale.TEXT_GARAGE_PRICE);
      local2.x = WIDTH - local2.width - local1.x;
      local2.y = local1.y;
      this.container.addChild(local2);
    }

    private function addRows() : void {
      var local2:KitPackageItemInfo = null;
      var local3:KitPackageDescriptionRow = null;
      var local1:int = LEFT_TOP_MARGIN + ITEM_HEIGHT;
      for each(local2 in this.kitPackage.getItemInfos()) {
        local3 = new KitPackageDescriptionRow(local2);
        local3.y = local1;
        this.container.addChild(local3);
        local1 += ITEM_HEIGHT;
      }
    }

    private function addSummary() : void {
      var local1:LabelBase = null;
      local1 = new LabelBase();
      local1.color = ColorConstants.GREEN_LABEL;
      local1.align = TextFormatAlign.LEFT;
      local1.text = localeService.getText(TanksLocale.TEXT_TOTAL_PRICE_KIT);
      local1.x = LEFT_TOP_MARGIN;
      local1.y = LEFT_TOP_MARGIN + (this.kitPackage.getItemInfos().length + 1) * ITEM_HEIGHT + LEFT_TOP_MARGIN;
      this.container.addChild(local1);
      var local2:Diamond = new Diamond();
      local2.x = WIDTH - local1.x - local2.width;
      local2.y = local1.y + 4;
      this.container.addChild(local2);
      var local3:LabelBase = new LabelBase();
      local3.color = ColorConstants.GREEN_LABEL;
      local3.align = TextFormatAlign.RIGHT;
      local3.text = Money.numToString(this.getKitPrice(),false);
      local3.x = local2.x - local3.width - 1;
      local3.y = local1.y;
      this.container.addChild(local3);
    }

    private function getKitPrice() : int {
      var local2:KitPackageItemInfo = null;
      var local1:int = 0;
      for each(local2 in this.kitPackage.getItemInfos()) {
        local1 += local2.crystalPrice * local2.count;
      }
      return local1;
    }

    private function get kitPackage() : KitPackage {
      return KitPackage(shopItemObject.adapt(KitPackage));
    }
  }
}
