package controls.resultassets {
  import assets.resultwindow.bres_HEADER_BLUE_PIXEL;
  import assets.resultwindow.bres_HEADER_BLUE_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowBlueHeader extends StatLineBase {
    public function ResultWindowBlueHeader() {
      super();
      tl = new bres_HEADER_BLUE_TL(1,1);
      px = new bres_HEADER_BLUE_PIXEL(1,1);
    }
  }
}
