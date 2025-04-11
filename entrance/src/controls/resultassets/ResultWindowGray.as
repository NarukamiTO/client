package controls.resultassets {
  import assets.resultwindow.bres_BG_GRAY_PIXEL;
  import assets.resultwindow.bres_BG_GRAY_TL;

  public class ResultWindowGray extends ResultWindowBase {
    public function ResultWindowGray() {
      super();
      tl = new bres_BG_GRAY_TL(1,1);
      px = new bres_BG_GRAY_PIXEL(1,1);
    }
  }
}
