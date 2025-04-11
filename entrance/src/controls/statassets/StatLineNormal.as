package controls.statassets {
  import assets.stat.hall_NORMAL;
  import flash.display.BitmapData;

  public class StatLineNormal extends StatLineBase {
    public function StatLineNormal() {
      super();
      tl = new hall_NORMAL(1,1);
      px = new BitmapData(1,1,false,543488);
    }
  }
}
