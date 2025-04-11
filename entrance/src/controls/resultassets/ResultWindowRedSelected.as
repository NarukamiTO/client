package controls.resultassets {
  import assets.resultwindow.bres_SELECTED_RED_PIXEL;
  import assets.resultwindow.bres_SELECTED_RED_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowRedSelected extends StatLineBase {
    public function ResultWindowRedSelected() {
      super();
      tl = new bres_SELECTED_RED_TL(1,1);
      px = new bres_SELECTED_RED_PIXEL(1,1);
      frameColor = 16673333;
    }
  }
}
