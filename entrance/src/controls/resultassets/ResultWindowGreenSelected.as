package controls.resultassets {
  import assets.resultwindow.bres_SELECTED_GREEN_PIXEL;
  import assets.resultwindow.bres_SELECTED_GREEN_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowGreenSelected extends StatLineBase {
    public function ResultWindowGreenSelected() {
      super();
      tl = new bres_SELECTED_GREEN_TL(1,1);
      px = new bres_SELECTED_GREEN_PIXEL(1,1);
      frameColor = 5898034;
    }
  }
}
