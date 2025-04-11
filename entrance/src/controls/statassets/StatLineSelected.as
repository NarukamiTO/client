package controls.statassets {
  import assets.stat.hall_SELECTED;
  import flash.display.BitmapData;

  public class StatLineSelected extends StatLineHeader {
    public function StatLineSelected() {
      super();
      tl = new hall_SELECTED(1,1);
      px = new BitmapData(1,1,false,543488);
      frameColor = 5898034;
    }
  }
}
