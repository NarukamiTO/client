package resources.windowheaders.background {
  import flash.display.BitmapData;

  public class BackgroundHeader {
    private static const shortBackgroundHeaderClass:Class = BackgroundHeader_shortBackgroundHeaderClass;

    public static const shortBackgroundHeader:BitmapData = new shortBackgroundHeaderClass().bitmapData;

    private static const longBackgroundHeaderClass:Class = BackgroundHeader_longBackgroundHeaderClass;

    public static const longBackgroundHeader:BitmapData = new longBackgroundHeaderClass().bitmapData;

    private static const verticalBackgroundHeaderClass:Class = BackgroundHeader_verticalBackgroundHeaderClass;

    public static const verticalBackgroundHeader:BitmapData = new verticalBackgroundHeaderClass().bitmapData;

    public function BackgroundHeader() {
      super();
    }
  }
}
