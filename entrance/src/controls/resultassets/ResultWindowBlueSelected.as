package controls.resultassets {
  import assets.resultwindow.bres_SELECTED_BLUE_PIXEL;
  import assets.resultwindow.bres_SELECTED_BLUE_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowBlueSelected extends StatLineBase {
    public function ResultWindowBlueSelected() {
      super();
      tl = new bres_SELECTED_BLUE_TL(1,1);
      px = new bres_SELECTED_BLUE_PIXEL(1,1);
      frameColor = 7520742;
    }
  }
}
