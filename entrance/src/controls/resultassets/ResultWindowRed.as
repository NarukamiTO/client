package controls.resultassets {
  import assets.resultwindow.bres_BG_RED_PIXEL;
  import assets.resultwindow.bres_BG_RED_TL;

  public class ResultWindowRed extends ResultWindowBase {
    public function ResultWindowRed() {
      super();
      tl = new bres_BG_RED_TL(1,1);
      px = new bres_BG_RED_PIXEL(1,1);
    }
  }
}
