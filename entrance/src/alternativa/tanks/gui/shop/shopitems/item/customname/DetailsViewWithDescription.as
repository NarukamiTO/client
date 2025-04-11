package alternativa.tanks.gui.shop.shopitems.item.customname {
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import controls.base.LabelBase;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class DetailsViewWithDescription extends ShopItemDetails {
    private static const WIDTH:int = 250;

    public function DetailsViewWithDescription(param1:IGameObject, param2:String) {
      super(param1);
      this.addDescription(param2);
    }

    private function addDescription(param1:String) : void {
      var local2:LabelBase = null;
      local2 = new LabelBase();
      local2.multiline = true;
      local2.wordWrap = true;
      local2.color = ColorConstants.GREEN_TEXT;
      local2.htmlText = param1;
      local2.mouseWheelEnabled = false;
      local2.width = WIDTH;
      addChild(local2);
    }
  }
}
