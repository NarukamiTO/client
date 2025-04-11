package controls.statassets {
  import assets.resultwindow.bres_BG_ORANGECORNER;
  import flash.display.BitmapData;

  public class OrangeRoundRect extends BlackRoundRect {
    public function OrangeRoundRect() {
      super();
      tl = new bres_BG_ORANGECORNER(1,1);
      px = new BitmapData(1,1,false,12804096);
    }
  }
}
