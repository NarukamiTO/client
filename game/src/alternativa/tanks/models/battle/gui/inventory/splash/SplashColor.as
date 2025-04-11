package alternativa.tanks.models.battle.gui.inventory.splash {
  import alternativa.tanks.models.inventory.InventoryItemType;

  public class SplashColor {
    public static const WHITE:uint = 4294967295;
    public static const COOLDOWN:uint = 126;

    private static const FIRST_AID:uint = 3135184319;
    private static const ARMOR:uint = 3819201471;
    private static const DAMAGE:uint = 4285085631;
    private static const NITRO:uint = 4293333951;
    private static const MINE:uint = 14527935;
    private static const GOLD:uint = 4289270719;
    private static const ULTIMATE:uint = 495830;

    public function SplashColor() {
      super();
    }

    public static function getColor(param1:int) : uint {
      var local2:uint = 0;
      switch(param1) {
        case InventoryItemType.FIRST_AID:
          local2 = uint(SplashColor.FIRST_AID);
          break;
        case InventoryItemType.ARMOR:
          local2 = uint(SplashColor.ARMOR);
          break;
        case InventoryItemType.DAMAGE:
          local2 = uint(SplashColor.DAMAGE);
          break;
        case InventoryItemType.NITRO:
          local2 = uint(SplashColor.NITRO);
          break;
        case InventoryItemType.MINE:
          local2 = uint(SplashColor.MINE);
          break;
        case InventoryItemType.GOLD:
          local2 = uint(SplashColor.GOLD);
          break;
        case InventoryItemType.ULTIMATE:
          local2 = uint(SplashColor.ULTIMATE);
          break;
        default:
          local2 = uint(SplashColor.WHITE);
      }
      return local2;
    }
  }
}
