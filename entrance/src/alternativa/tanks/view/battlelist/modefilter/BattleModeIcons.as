package alternativa.tanks.view.battlelist.modefilter {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.client.battleservice.BattleMode;

  public class BattleModeIcons {
    private static const dmIconClass:Class = BattleModeIcons_dmIconClass;
    private static const dmIconBitmapData:BitmapData = Bitmap(new dmIconClass()).bitmapData;
    private static const tdmIconClass:Class = BattleModeIcons_tdmIconClass;
    private static const tdmIconBitmapData:BitmapData = Bitmap(new tdmIconClass()).bitmapData;
    private static const ctfIconClass:Class = BattleModeIcons_ctfIconClass;
    private static const ctfIconBitmapData:BitmapData = Bitmap(new ctfIconClass()).bitmapData;
    private static const cpIconClass:Class = BattleModeIcons_cpIconClass;
    private static const cpIconBitmapData:BitmapData = Bitmap(new cpIconClass()).bitmapData;
    private static const asIconClass:Class = BattleModeIcons_asIconClass;
    private static const asIconBitmapData:BitmapData = Bitmap(new asIconClass()).bitmapData;
    private static const rugbyIconClass:Class = BattleModeIcons_rugbyIconClass;
    private static const rugbyIconBitmapData:BitmapData = Bitmap(new rugbyIconClass()).bitmapData;
    private static const jgrIconClass:Class = BattleModeIcons_jgrIconClass;
    private static const jgrIconBitmapData:BitmapData = Bitmap(new jgrIconClass()).bitmapData;

    public function BattleModeIcons() {
      super();
    }

    public static function getIcon(param1:BattleMode) : BitmapData {
      switch(param1) {
        case BattleMode.DM:
          return dmIconBitmapData;
        case BattleMode.TDM:
          return tdmIconBitmapData;
        case BattleMode.CTF:
          return ctfIconBitmapData;
        case BattleMode.CP:
          return cpIconBitmapData;
        case BattleMode.AS:
          return asIconBitmapData;
        case BattleMode.RUGBY:
          return rugbyIconBitmapData;
        case BattleMode.JGR:
          return jgrIconBitmapData;
        default:
          return null;
      }
    }
  }
}
