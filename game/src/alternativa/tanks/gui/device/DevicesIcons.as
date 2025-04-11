package alternativa.tanks.gui.device {
  import flash.display.BitmapData;

  public class DevicesIcons {
    private static const iconDefaultDeviceClass:Class = DevicesIcons_iconDefaultDeviceClass;

    public static const iconDefaultDeviceBitmap:BitmapData = new iconDefaultDeviceClass().bitmapData;

    private static const iconDefaultSkinClass:Class = DevicesIcons_iconDefaultSkinClass;

    public static const iconDefaultSkinBitmap:BitmapData = new iconDefaultSkinClass().bitmapData;

    private static const iconDefaultShotColorClass:Class = DevicesIcons_iconDefaultShotColorClass;

    public static const iconDefaultShotColorBitmap:BitmapData = new iconDefaultShotColorClass().bitmapData;

    private static const lockedIconClass:Class = DevicesIcons_lockedIconClass;

    public static const lockedIcon:BitmapData = new lockedIconClass().bitmapData;

    public function DevicesIcons() {
      super();
    }
  }
}
