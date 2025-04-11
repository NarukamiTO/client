package alternativa.tanks.gui.shop.shopitems.item.kits.description {
  import assets.Diamond;
  import controls.Money;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;

  public class KitPackageDescriptionRow extends Sprite {
    public function KitPackageDescriptionRow(param1:KitPackageItemInfo) {
      super();
      var local2:LabelBase = new LabelBase();
      local2.textColor = ColorConstants.WHITE;
      local2.align = TextFormatAlign.LEFT;
      local2.text = param1.itemName + (param1.count <= 1 ? "" : " ×" + String(param1.count));
      local2.x = KitPackageDescriptionView.LEFT_TOP_MARGIN;
      addChild(local2);
      var local3:Diamond = new Diamond();
      local3.x = KitPackageDescriptionView.WIDTH - local2.x - local3.width;
      local3.y = 4;
      addChild(local3);
      var local4:int = param1.crystalPrice * param1.count;
      var local5:LabelBase = new LabelBase();
      local5.color = ColorConstants.WHITE;
      local5.align = TextFormatAlign.RIGHT;
      local5.text = Money.numToString(local4,false);
      local5.x = local3.x - local5.width - 1;
      addChild(local5);
    }
  }
}
