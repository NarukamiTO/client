package alternativa.tanks.model.quest.common.gui.greenpanel {
  import flash.display.BitmapData;
  import utils.FlipBitmapDataUtils;

  public class GreenPanelBitmaps {
    private static const LEFT_TOP_CORNER_BITMAP:Class = GreenPanelBitmaps_LEFT_TOP_CORNER_BITMAP;

    public static const LEFT_TOP_CORNER_BITMAP_DATA:BitmapData = new LEFT_TOP_CORNER_BITMAP().bitmapData;
    public static const RIGHT_TOP_CORNER_BITMAP_DATA:BitmapData = FlipBitmapDataUtils.flipH(LEFT_TOP_CORNER_BITMAP_DATA);

    private static const TOP_LINE_BITMAP:Class = GreenPanelBitmaps_TOP_LINE_BITMAP;

    public static const TOP_LINE_BITMAP_DATA:BitmapData = new TOP_LINE_BITMAP().bitmapData;
    public static const BOTTOM_LINE_BITMAP_DATA:BitmapData = FlipBitmapDataUtils.flipW(TOP_LINE_BITMAP_DATA);

    private static const LEFT_LINE_BITMAP:Class = GreenPanelBitmaps_LEFT_LINE_BITMAP;

    public static const LEFT_LINE_BITMAP_DATA:BitmapData = new LEFT_LINE_BITMAP().bitmapData;
    public static const RIGHT_LINE_BITMAP_DATA:BitmapData = FlipBitmapDataUtils.flipH(LEFT_LINE_BITMAP_DATA);

    private static const BACKGROUND_PIXEL_BITMAP:Class = GreenPanelBitmaps_BACKGROUND_PIXEL_BITMAP;

    public static const BACKGROUND_PIXEL_BITMAP_DATA:BitmapData = new BACKGROUND_PIXEL_BITMAP().bitmapData;

    private static const LEFT_BOTTOM_CORNER_BITMAP:Class = GreenPanelBitmaps_LEFT_BOTTOM_CORNER_BITMAP;

    public static const LEFT_BOTTOM_CORNER_BITMAP_DATA:BitmapData = new LEFT_BOTTOM_CORNER_BITMAP().bitmapData;
    public static const RIGHT_BOTTOM_CORNER_BITMAP_DATA:BitmapData = FlipBitmapDataUtils.flipH(LEFT_BOTTOM_CORNER_BITMAP_DATA);

    public function GreenPanelBitmaps() {
      super();
    }
  }
}
