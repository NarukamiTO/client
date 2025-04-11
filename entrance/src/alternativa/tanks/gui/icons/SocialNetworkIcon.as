package alternativa.tanks.gui.icons {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class SocialNetworkIcon {
    private static const vkBitmap:Class = SocialNetworkIcon_vkBitmap;
    private static const vkBd:BitmapData = new vkBitmap().bitmapData;
    private static const fbBitmap:Class = SocialNetworkIcon_fbBitmap;
    private static const fbBd:BitmapData = new fbBitmap().bitmapData;
    private static const googleBitmap:Class = SocialNetworkIcon_googleBitmap;
    private static const googleBd:BitmapData = new googleBitmap().bitmapData;

    public function SocialNetworkIcon() {
      super();
    }

    public static function createVk() : Bitmap {
      return new Bitmap(vkBd);
    }

    public static function createFb() : Bitmap {
      return new Bitmap(fbBd);
    }

    public static function createGoogle() : Bitmap {
      return new Bitmap(googleBd);
    }
  }
}
