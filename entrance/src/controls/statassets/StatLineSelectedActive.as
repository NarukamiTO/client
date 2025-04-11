package controls.statassets {
  import assets.stat.hall_SELECTED_ACTIVE;
  import flash.display.BitmapData;

  public class StatLineSelectedActive extends StatLineBase {
    public function StatLineSelectedActive() {
      super();
      tl = new hall_SELECTED_ACTIVE(1,1);
      px = new BitmapData(1,1,false,881920);
      frameColor = 5898034;
    }
  }
}
