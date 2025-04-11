package controls.resultassets {
  import assets.resultwindow.bres_HEADER_RED_PIXEL;
  import assets.resultwindow.bres_HEADER_RED_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowRedHeader extends StatLineBase {
    public function ResultWindowRedHeader() {
      super();
      tl = new bres_HEADER_RED_TL(1,1);
      px = new bres_HEADER_RED_PIXEL(1,1);
    }
  }
}
