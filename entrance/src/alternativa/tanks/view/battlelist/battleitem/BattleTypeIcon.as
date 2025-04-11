package alternativa.tanks.view.battlelist.battleitem {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class BattleTypeIcon {
    private static const privateClass:Class = BattleTypeIcon_privateClass;
    private static const privateData:BitmapData = Bitmap(new privateClass()).bitmapData;
    private static const privateDisableClass:Class = BattleTypeIcon_privateDisableClass;
    private static const privateDisableData:BitmapData = Bitmap(new privateDisableClass()).bitmapData;
    private static const proClass:Class = BattleTypeIcon_proClass;
    private static const proData:BitmapData = Bitmap(new proClass()).bitmapData;
    private static const proDisableClass:Class = BattleTypeIcon_proDisableClass;
    private static const proDisableData:BitmapData = Bitmap(new proDisableClass()).bitmapData;
    private static const formatClass:Class = BattleTypeIcon_formatClass;
    private static const formatData:BitmapData = Bitmap(new formatClass()).bitmapData;
    private static const formatDisableClass:Class = BattleTypeIcon_formatDisableClass;
    private static const formatDisableData:BitmapData = Bitmap(new formatDisableClass()).bitmapData;

    public function BattleTypeIcon() {
      super();
    }

    public static function getPrivateIconData(param1:Boolean) : BitmapData {
      return param1 ? privateData : privateDisableData;
    }

    public static function getProIconData(param1:Boolean) : BitmapData {
      return param1 ? proData : proDisableData;
    }

    public static function getFormatIconData(param1:Boolean) : BitmapData {
      return param1 ? formatData : formatDisableData;
    }
  }
}
