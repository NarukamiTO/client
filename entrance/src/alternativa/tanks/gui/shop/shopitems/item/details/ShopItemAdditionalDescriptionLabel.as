package alternativa.tanks.gui.shop.shopitems.item.details {
  import alternativa.tanks.gui.shop.components.item.GridItemBase;
  import controls.base.LabelBase;
  import forms.ColorConstants;

  public class ShopItemAdditionalDescriptionLabel extends GridItemBase {
    private static const WIDTH:int = 800;

    public function ShopItemAdditionalDescriptionLabel(param1:String) {
      var local2:LabelBase = null;
      super();
      local2 = new LabelBase();
      local2.color = ColorConstants.GREEN_TEXT;
      local2.htmlText = param1;
      local2.multiline = true;
      local2.wordWrap = true;
      local2.width = WIDTH;
      addChild(local2);
    }

    override public function get forceNewLine() : Boolean {
      return true;
    }
  }
}
