package controls.statassets {
  import assets.stat.hall_NORMAL_ACTIVE;
  import flash.display.BitmapData;

  public class StatLineNormalActive extends StatLineBase {
    public function StatLineNormalActive() {
      super();
      tl = new hall_NORMAL_ACTIVE(1,1);
      px = new BitmapData(1,1,false,881920);
    }
  }
}
