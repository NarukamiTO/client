package controls.resultassets {
  import assets.resultwindow.bres_NORMAL_BLUE_PIXEL;
  import assets.resultwindow.bres_NORMAL_BLUE_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowBlueNormal extends StatLineBase {
    public function ResultWindowBlueNormal() {
      super();
      tl = new bres_NORMAL_BLUE_TL(1,1);
      px = new bres_NORMAL_BLUE_PIXEL(1,1);
    }
  }
}
