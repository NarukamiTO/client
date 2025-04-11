package controls.resultassets {
  import assets.resultwindow.bres_BG_GREEN_PIXEL;
  import assets.resultwindow.bres_BG_GREEN_TL;

  public class ResultWindowGreen extends ResultWindowBase {
    public function ResultWindowGreen() {
      super();
      tl = new bres_BG_GREEN_TL(1,1);
      px = new bres_BG_GREEN_PIXEL(1,1);
    }
  }
}
