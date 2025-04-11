package controls.resultassets {
  import assets.resultwindow.bres_BG_BLUE_PIXEL;
  import assets.resultwindow.bres_BG_BLUE_TL;

  public class ResultWindowBlue extends ResultWindowBase {
    public function ResultWindowBlue() {
      super();
      tl = new bres_BG_BLUE_TL(1,1);
      px = new bres_BG_BLUE_PIXEL(1,1);
    }
  }
}
