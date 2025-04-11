package alternativa.tanks.gui.shop.shopitems.item.kits.description.panel {
  import alternativa.tanks.gui.shop.shopitems.item.kits.description.KitPackageDescriptionView;
  import flash.display.Bitmap;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class KitPackageDescriptionPanel extends Sprite {
    private var top:Bitmap;
    private var topLeft:Bitmap;
    private var topRight:Bitmap;
    private var left:Bitmap;
    private var right:Bitmap;
    private var bottom:Bitmap;
    private var bottomLeft:Bitmap;
    private var bottomRight:Bitmap;
    private var center:Bitmap;
    private var backgroundFillTopPart:Shape;
    private var backgroundFillBottomPart:Shape;

    public function KitPackageDescriptionPanel() {
      super();
      this.topLeft = new Bitmap(KitPackageDescriptionPanelBitmaps.leftTopCorner);
      addChild(this.topLeft);
      this.top = new Bitmap(KitPackageDescriptionPanelBitmaps.topLine);
      addChild(this.top);
      this.topRight = new Bitmap(KitPackageDescriptionPanelBitmaps.rightTopCorner);
      addChild(this.topRight);
      this.left = new Bitmap(KitPackageDescriptionPanelBitmaps.leftLine);
      addChild(this.left);
      this.right = new Bitmap(KitPackageDescriptionPanelBitmaps.rightLine);
      addChild(this.right);
      this.bottom = new Bitmap(KitPackageDescriptionPanelBitmaps.bottomLine);
      addChild(this.bottom);
      this.bottomLeft = new Bitmap(KitPackageDescriptionPanelBitmaps.leftBottomCorner);
      addChild(this.bottomLeft);
      this.bottomRight = new Bitmap(KitPackageDescriptionPanelBitmaps.rightBottomCorner);
      addChild(this.bottomRight);
      this.center = new Bitmap(KitPackageDescriptionPanelBitmaps.centerLine);
      addChild(this.center);
      this.backgroundFillTopPart = new Shape();
      addChild(this.backgroundFillTopPart);
      this.backgroundFillBottomPart = new Shape();
      addChild(this.backgroundFillBottomPart);
    }

    public function resize(param1:int) : void {
      var local2:int = 0;
      var local3:int = 0;
      local2 = KitPackageDescriptionView.WIDTH;
      local3 = (param1 + 2) * KitPackageDescriptionView.ITEM_HEIGHT + KitPackageDescriptionView.LEFT_TOP_MARGIN * 3 - this.topLeft.height;
      this.top.x = this.topLeft.width;
      this.top.width = local2 - this.topRight.width - this.topLeft.width;
      this.topRight.x = local2 - this.topRight.width;
      this.bottomLeft.y = local3 - this.bottomLeft.height;
      this.bottomRight.x = this.topRight.x;
      this.bottomRight.y = this.bottomLeft.y;
      this.bottom.y = this.bottomLeft.y;
      this.bottom.x = this.top.x;
      this.bottom.width = this.top.width;
      this.left.y = this.topLeft.height;
      this.left.height = this.bottomLeft.y - this.left.y;
      this.right.y = this.left.y;
      this.right.x = this.topRight.x;
      this.right.height = this.bottomRight.y - this.right.y;
      this.center.x = 1;
      this.center.y = local3 - KitPackageDescriptionView.LEFT_TOP_MARGIN * 2 - KitPackageDescriptionView.ITEM_HEIGHT + this.center.height;
      this.center.width = local2 - 2;
      this.fillBackgroundShape(this.backgroundFillTopPart,this.topLeft.width,this.topLeft.height,this.top.width,this.center.y - this.center.height);
      this.fillBackgroundShape(this.backgroundFillBottomPart,this.topLeft.width,this.center.y + this.center.height,this.top.width,KitPackageDescriptionView.LEFT_TOP_MARGIN * 2 + KitPackageDescriptionView.ITEM_HEIGHT - this.center.height * 3);
    }

    private function fillBackgroundShape(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number) : void {
      param1.graphics.clear();
      param1.graphics.beginBitmapFill(KitPackageDescriptionPanelBitmaps.backgroundPixel);
      param1.graphics.drawRect(param2,param3,param4,param5);
    }
  }
}
