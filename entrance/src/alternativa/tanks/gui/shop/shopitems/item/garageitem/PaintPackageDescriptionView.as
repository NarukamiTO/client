package alternativa.tanks.gui.shop.shopitems.item.garageitem {
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import alternativa.tanks.model.payment.shop.paint.PaintPackage;
  import controls.base.LabelBase;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class PaintPackageDescriptionView extends ShopItemDetails {
    private static const WIDTH:int = 250;

    public function PaintPackageDescriptionView(param1:IGameObject) {
      super(param1);
      this.addDescription();
    }

    private function addDescription() : void {
      var local1:LabelBase = null;
      local1 = new LabelBase();
      local1.multiline = true;
      local1.wordWrap = true;
      local1.color = ColorConstants.GREEN_TEXT;
      local1.htmlText = PaintPackage(shopItemObject.adapt(PaintPackage)).getDescription();
      local1.mouseWheelEnabled = false;
      local1.width = WIDTH;
      addChild(local1);
    }
  }
}
