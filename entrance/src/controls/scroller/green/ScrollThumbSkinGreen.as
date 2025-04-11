package controls.scroller.green {
  import controls.scroller.*;

  public class ScrollThumbSkinGreen extends ScrollThumbSkin {
    public function ScrollThumbSkinGreen() {
      super();
    }

    override public function initSkin() : void {
      toppng = new ScrollSkinGreen.thumbTop().bitmapData;
      midpng = new ScrollSkinGreen.thumbMiddle().bitmapData;
    }
  }
}
