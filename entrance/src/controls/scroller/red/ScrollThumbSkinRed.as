package controls.scroller.red {
  import controls.scroller.*;

  public class ScrollThumbSkinRed extends ScrollThumbSkin {
    public function ScrollThumbSkinRed() {
      super();
    }

    override public function initSkin() : void {
      toppng = new ScrollSkinRed.thumbTop().bitmapData;
      midpng = new ScrollSkinRed.thumbMiddle().bitmapData;
    }
  }
}
