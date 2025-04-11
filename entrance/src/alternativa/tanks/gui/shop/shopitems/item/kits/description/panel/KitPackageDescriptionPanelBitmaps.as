package alternativa.tanks.gui.shop.shopitems.item.kits.description.panel {
  import flash.display.BitmapData;
  import utils.FlipBitmapDataUtils;

  public class KitPackageDescriptionPanelBitmaps {
    private static const bitmapLeftTopCorner:Class = KitPackageDescriptionPanelBitmaps_bitmapLeftTopCorner;

    public static const leftTopCorner:BitmapData = new bitmapLeftTopCorner().bitmapData;
    public static const rightTopCorner:BitmapData = FlipBitmapDataUtils.flipH(leftTopCorner);

    private static const bitmapLeftBottomCorner:Class = KitPackageDescriptionPanelBitmaps_bitmapLeftBottomCorner;

    public static const leftBottomCorner:BitmapData = new bitmapLeftBottomCorner().bitmapData;
    public static const rightBottomCorner:BitmapData = FlipBitmapDataUtils.flipH(leftBottomCorner);

    private static const bitmapTopLine:Class = KitPackageDescriptionPanelBitmaps_bitmapTopLine;

    public static const topLine:BitmapData = new bitmapTopLine().bitmapData;
    public static const centerLine:BitmapData = FlipBitmapDataUtils.flipW(topLine);
    public static const bottomLine:BitmapData = FlipBitmapDataUtils.flipW(topLine);

    private static const bitmapLeftLine:Class = KitPackageDescriptionPanelBitmaps_bitmapLeftLine;

    public static const leftLine:BitmapData = new bitmapLeftLine().bitmapData;
    public static const rightLine:BitmapData = FlipBitmapDataUtils.flipH(leftLine);

    private static const bitmapBackgroundPixel:Class = KitPackageDescriptionPanelBitmaps_bitmapBackgroundPixel;

    public static const backgroundPixel:BitmapData = new bitmapBackgroundPixel().bitmapData;

    public function KitPackageDescriptionPanelBitmaps() {
      super();
    }
  }
}
