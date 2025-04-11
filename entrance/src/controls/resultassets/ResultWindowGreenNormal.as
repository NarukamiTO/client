package controls.resultassets {
  import assets.resultwindow.bres_NORMAL_GREEN_PIXEL;
  import assets.resultwindow.bres_NORMAL_GREEN_TL;
  import controls.statassets.StatLineBase;

  public class ResultWindowGreenNormal extends StatLineBase {
    public function ResultWindowGreenNormal() {
      super();
      tl = new bres_NORMAL_GREEN_TL(1,1);
      px = new bres_NORMAL_GREEN_PIXEL(1,1);
    }
  }
}
