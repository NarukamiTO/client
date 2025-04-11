package controls.resultassets {
  import assets.resultwindow.bres_HEADER_GREEN_PIXEL;
  import assets.resultwindow.bres_HEADER_GREEN_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowGreenHeader extends StatLineBase {
    public function ResultWindowGreenHeader() {
      super();
      tl = new bres_HEADER_GREEN_TL(1,1);
      px = new bres_HEADER_GREEN_PIXEL(1,1);
    }
  }
}
