package controls.scroller.blue {
  import controls.scroller.*;

  public class ScrollThumbSkinBlue extends ScrollThumbSkin {
    public function ScrollThumbSkinBlue() {
      super();
    }

    override public function initSkin() : void {
      toppng = new ScrollSkinBlue.thumbTop().bitmapData;
      midpng = new ScrollSkinBlue.thumbMiddle().bitmapData;
    }
  }
}
