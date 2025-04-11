package utils {
  import controls.scroller.blue.ScrollSkinBlue;
  import controls.scroller.blue.ScrollThumbSkinBlue;
  import controls.scroller.gray.ScrollSkinGray;
  import controls.scroller.gray.ScrollThumbSkinGray;
  import controls.scroller.green.ScrollSkinGreen;
  import controls.scroller.green.ScrollThumbSkinGreen;
  import controls.scroller.red.ScrollSkinRed;
  import controls.scroller.red.ScrollThumbSkinRed;
  import fl.core.UIComponent;

  public class ScrollStyleUtils {
    public function ScrollStyleUtils() {
      super();
    }

    public static function setStyle(param1:UIComponent, param2:Class, param3:Class, param4:Class, param5:Class) : void {
      param1.setStyle("downArrowUpSkin",param2);
      param1.setStyle("downArrowDownSkin",param2);
      param1.setStyle("downArrowOverSkin",param2);
      param1.setStyle("downArrowDisabledSkin",param2);
      param1.setStyle("upArrowUpSkin",param3);
      param1.setStyle("upArrowDownSkin",param3);
      param1.setStyle("upArrowOverSkin",param3);
      param1.setStyle("upArrowDisabledSkin",param3);
      param1.setStyle("trackUpSkin",param4);
      param1.setStyle("trackDownSkin",param4);
      param1.setStyle("trackOverSkin",param4);
      param1.setStyle("trackDisabledSkin",param4);
      param1.setStyle("thumbUpSkin",param5);
      param1.setStyle("thumbDownSkin",param5);
      param1.setStyle("thumbOverSkin",param5);
      param1.setStyle("thumbDisabledSkin",param5);
    }

    public static function setGreenStyle(param1:UIComponent) : void {
      setStyle(param1,ScrollSkinGreen.trackBottom,ScrollSkinGreen.trackTop,ScrollSkinGreen.track,ScrollThumbSkinGreen);
    }

    public static function setGrayStyle(param1:UIComponent) : void {
      setStyle(param1,ScrollSkinGray.trackBottom,ScrollSkinGray.trackTop,ScrollSkinGray.track,ScrollThumbSkinGray);
    }

    public static function setBlueStyle(param1:UIComponent) : void {
      setStyle(param1,ScrollSkinBlue.trackBottom,ScrollSkinBlue.trackTop,ScrollSkinBlue.track,ScrollThumbSkinBlue);
    }

    public static function setRedStyle(param1:UIComponent) : void {
      setStyle(param1,ScrollSkinRed.trackBottom,ScrollSkinRed.trackTop,ScrollSkinRed.track,ScrollThumbSkinRed);
    }
  }
}
