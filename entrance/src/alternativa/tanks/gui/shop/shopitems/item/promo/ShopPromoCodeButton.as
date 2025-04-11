package alternativa.tanks.gui.shop.shopitems.item.promo {
  import alternativa.tanks.gui.shop.shopitems.item.OtherShopItemButton;
  import flash.display.Bitmap;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ShopPromoCodeButton extends OtherShopItemButton {
    private static const promoCodePreviewClass:Class = ShopPromoCodeButton_promoCodePreviewClass;

    public function ShopPromoCodeButton(param1:IGameObject) {
      this.preview = new Bitmap(new promoCodePreviewClass().bitmapData);
      super(param1,localeService.getText(TanksLocale.TEXT_PROMO_CODE_SHOP_LABEL));
      updateLazyLoadedPreview();
    }

    override protected function align() : void {
      super.align();
      if(preview != null) {
        preview.y += 4;
        preview.x -= PADDING;
      }
    }
  }
}
