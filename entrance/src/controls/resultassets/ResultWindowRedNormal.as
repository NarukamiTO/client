package controls.resultassets {
  import assets.resultwindow.bres_NORMAL_RED_PIXEL;
  import assets.resultwindow.bres_NORMAL_RED_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowRedNormal extends StatLineBase {
    public function ResultWindowRedNormal() {
      super();
      tl = new bres_NORMAL_RED_TL(1,1);
      px = new bres_NORMAL_RED_PIXEL(1,1);
    }
  }
}
