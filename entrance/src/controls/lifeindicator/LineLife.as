package controls.lifeindicator {
  public class LineLife extends HorizontalBar {
    private static const bitmapLeft:Class = LineLife_bitmapLeft;
    private static const bitmapCenter:Class = LineLife_bitmapCenter;
    private static const bitmapRight:Class = LineLife_bitmapRight;

    public function LineLife() {
      super(new bitmapLeft().bitmapData,new bitmapCenter().bitmapData,new bitmapRight().bitmapData);
    }
  }
}
