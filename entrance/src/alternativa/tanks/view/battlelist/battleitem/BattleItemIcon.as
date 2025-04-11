package alternativa.tanks.view.battlelist.battleitem {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.client.battleservice.BattleMode;

  public class BattleItemIcon {
    private static const dmNormalClass:Class = BattleItemIcon_dmNormalClass;
    private static const dmNormalData:BitmapData = Bitmap(new dmNormalClass()).bitmapData;
    private static const tdmNormalClass:Class = BattleItemIcon_tdmNormalClass;
    private static const tdmNormalData:BitmapData = Bitmap(new tdmNormalClass()).bitmapData;
    private static const ctfNormalClass:Class = BattleItemIcon_ctfNormalClass;
    private static const ctfNormalData:BitmapData = Bitmap(new ctfNormalClass()).bitmapData;
    private static const cpNormalClass:Class = BattleItemIcon_cpNormalClass;
    private static const cpNormalData:BitmapData = Bitmap(new cpNormalClass()).bitmapData;
    private static const dmGreyClass:Class = BattleItemIcon_dmGreyClass;
    private static const dmGreyData:BitmapData = Bitmap(new dmGreyClass()).bitmapData;
    private static const tdmGreyClass:Class = BattleItemIcon_tdmGreyClass;
    private static const tdmGreyData:BitmapData = Bitmap(new tdmGreyClass()).bitmapData;
    private static const ctfGreyClass:Class = BattleItemIcon_ctfGreyClass;
    private static const ctfGreyData:BitmapData = Bitmap(new ctfGreyClass()).bitmapData;
    private static const cpGreyClass:Class = BattleItemIcon_cpGreyClass;
    private static const cpGreyData:BitmapData = Bitmap(new cpGreyClass()).bitmapData;

    public function BattleItemIcon() {
      super();
    }

    private static function getBattleModeIcon(param1:BattleMode) : Bitmap {
      switch(param1) {
        case BattleMode.DM:
          return new Bitmap(dmNormalData);
        case BattleMode.TDM:
          return new Bitmap(tdmNormalData);
        case BattleMode.CTF:
          return new Bitmap(ctfNormalData);
        case BattleMode.CP:
        case BattleMode.AS:
          return new Bitmap(cpNormalData);
        default:
          return new Bitmap(dmNormalData);
      }
    }

    private static function getBattleModeGrayIcon(param1:BattleMode) : Bitmap {
      switch(param1) {
        case BattleMode.DM:
          return new Bitmap(dmGreyData);
        case BattleMode.TDM:
          return new Bitmap(tdmGreyData);
        case BattleMode.CTF:
          return new Bitmap(ctfGreyData);
        case BattleMode.CP:
        case BattleMode.AS:
          return new Bitmap(cpGreyData);
        default:
          return new Bitmap(dmGreyData);
      }
    }

    public static function getBattleLimitIcon(param1:BattleMode) : Bitmap {
      if(param1 == BattleMode.TDM) {
        return new Bitmap(dmNormalData);
      }
      return getBattleModeIcon(param1);
    }

    public static function getBattleLimitGrayIcon(param1:BattleMode) : Bitmap {
      if(param1 == BattleMode.TDM) {
        return new Bitmap(dmGreyData);
      }
      return getBattleModeGrayIcon(param1);
    }
  }
}
