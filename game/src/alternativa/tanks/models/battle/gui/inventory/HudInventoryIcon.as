package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.tanks.models.inventory.InventoryItemType;
  import flash.display.BitmapData;
  import forms.ColorConstants;

  public class HudInventoryIcon {
    private static const ultimateBgdClass:Class = HudInventoryIcon_ultimateBgdClass;
    private static const ultimateBgdBitmapData:BitmapData = new ultimateBgdClass().bitmapData;
    private static const overdriveDictatorIconClass:Class = HudInventoryIcon_overdriveDictatorIconClass;
    private static const overdriveDictatorIconBitmapData:BitmapData = new overdriveDictatorIconClass().bitmapData;
    private static const overdriveHornetIconClass:Class = HudInventoryIcon_overdriveHornetIconClass;
    private static const overdriveHornetIconBitmapData:BitmapData = new overdriveHornetIconClass().bitmapData;
    private static const overdriveHunterIconClass:Class = HudInventoryIcon_overdriveHunterIconClass;
    private static const overdriveHunterIconBitmapData:BitmapData = new overdriveHunterIconClass().bitmapData;
    private static const overdriveJuggernautIconClass:Class = HudInventoryIcon_overdriveJuggernautIconClass;
    private static const overdriveJuggernautIconBitmapData:BitmapData = new overdriveJuggernautIconClass().bitmapData;
    private static const overdriveMammothIconClass:Class = HudInventoryIcon_overdriveMammothIconClass;
    private static const overdriveMammothIconBitmapData:BitmapData = new overdriveMammothIconClass().bitmapData;
    private static const overdriveTitanIconClass:Class = HudInventoryIcon_overdriveTitanIconClass;
    private static const overdriveTitanIconBitmapData:BitmapData = new overdriveTitanIconClass().bitmapData;
    private static const overdriveVikingIconClass:Class = HudInventoryIcon_overdriveVikingIconClass;
    private static const overdriveVikingIconBitmapData:BitmapData = new overdriveVikingIconClass().bitmapData;
    private static const overdriveWaspIconClass:Class = HudInventoryIcon_overdriveWaspIconClass;
    private static const overdriveWaspIconBitmapData:BitmapData = new overdriveWaspIconClass().bitmapData;
    private static const bgdClass:Class = HudInventoryIcon_bgdClass;
    private static const bgdBitmapData:BitmapData = new bgdClass().bitmapData;
    private static const overdriveBg2xClass:Class = HudInventoryIcon_overdriveBg2xClass;
    private static const overdriveBgBitmapData:BitmapData = new overdriveBg2xClass().bitmapData;
    private static const lockClass:Class = HudInventoryIcon_lockClass;
    private static const lockBitmapData:BitmapData = new lockClass().bitmapData;
    private static const borderClass:Class = HudInventoryIcon_borderClass;
    private static const borderBitmapData:BitmapData = new borderClass().bitmapData;
    private static const darkClass:Class = HudInventoryIcon_darkClass;
    private static const darkBitmapData:BitmapData = new darkClass().bitmapData;
    private static const dark2xClass:Class = HudInventoryIcon_dark2xClass;
    private static const dark2xBitmapData:BitmapData = new dark2xClass().bitmapData;
    private static const firstAidBgdClass:Class = HudInventoryIcon_firstAidBgdClass;
    private static const firstAidBgdBitmapData:BitmapData = new firstAidBgdClass().bitmapData;
    private static const armorBgdClass:Class = HudInventoryIcon_armorBgdClass;
    private static const armorBgdBitmapData:BitmapData = new armorBgdClass().bitmapData;
    private static const damageBgdClass:Class = HudInventoryIcon_damageBgdClass;
    private static const damageBgdBitmapData:BitmapData = new damageBgdClass().bitmapData;
    private static const nitroBgdClass:Class = HudInventoryIcon_nitroBgdClass;
    private static const nitroBgdBitmapData:BitmapData = new nitroBgdClass().bitmapData;
    private static const mineBgdClass:Class = HudInventoryIcon_mineBgdClass;
    private static const mineBgdBitmapData:BitmapData = new mineBgdClass().bitmapData;
    private static const firstAidWhiteIconClass:Class = HudInventoryIcon_firstAidWhiteIconClass;
    private static const firstAidWhiteIconBitmapData:BitmapData = new firstAidWhiteIconClass().bitmapData;
    private static const armorWhiteIconClass:Class = HudInventoryIcon_armorWhiteIconClass;
    private static const armorWhiteIconBitmapData:BitmapData = new armorWhiteIconClass().bitmapData;
    private static const damageWhiteIconClass:Class = HudInventoryIcon_damageWhiteIconClass;
    private static const damageWhiteIconBitmapData:BitmapData = new damageWhiteIconClass().bitmapData;
    private static const nitroWhiteIconClass:Class = HudInventoryIcon_nitroWhiteIconClass;
    private static const nitroWhiteIconBitmapData:BitmapData = new nitroWhiteIconClass().bitmapData;
    private static const mineWhiteIconClass:Class = HudInventoryIcon_mineWhiteIconClass;
    private static const mineWhiteIconBitmapData:BitmapData = new mineWhiteIconClass().bitmapData;
    private static const firstAidColorIconClass:Class = HudInventoryIcon_firstAidColorIconClass;
    private static const firstAidColorIconBitmapData:BitmapData = new firstAidColorIconClass().bitmapData;
    private static const armorColorIconClass:Class = HudInventoryIcon_armorColorIconClass;
    private static const armorColorIconBitmapData:BitmapData = new armorColorIconClass().bitmapData;
    private static const damageColorIconClass:Class = HudInventoryIcon_damageColorIconClass;
    private static const damageColorIconBitmapData:BitmapData = new damageColorIconClass().bitmapData;
    private static const nitroColorIconClass:Class = HudInventoryIcon_nitroColorIconClass;
    private static const nitroColorIconBitmapData:BitmapData = new nitroColorIconClass().bitmapData;
    private static const mineColorIconClass:Class = HudInventoryIcon_mineColorIconClass;
    private static const mineColorIconBitmapData:BitmapData = new mineColorIconClass().bitmapData;
    private static const firstAidGrayIconClass:Class = HudInventoryIcon_firstAidGrayIconClass;
    private static const firstAidGrayIconBitmapData:BitmapData = new firstAidGrayIconClass().bitmapData;
    private static const armorGrayIconClass:Class = HudInventoryIcon_armorGrayIconClass;
    private static const armorGrayIconBitmapData:BitmapData = new armorGrayIconClass().bitmapData;
    private static const damageGrayIconClass:Class = HudInventoryIcon_damageGrayIconClass;
    private static const damageGrayIconBitmapData:BitmapData = new damageGrayIconClass().bitmapData;
    private static const nitroGrayIconClass:Class = HudInventoryIcon_nitroGrayIconClass;
    private static const nitroGrayIconBitmapData:BitmapData = new nitroGrayIconClass().bitmapData;
    private static const mineGrayIconClass:Class = HudInventoryIcon_mineGrayIconClass;
    private static const mineGrayIconBitmapData:BitmapData = new mineGrayIconClass().bitmapData;
    private static const goldBgdClass:Class = HudInventoryIcon_goldBgdClass;
    private static const goldBgdBitmapData:BitmapData = new goldBgdClass().bitmapData;
    private static const goldWhiteIconClass:Class = HudInventoryIcon_goldWhiteIconClass;
    private static const goldWhiteIconBitmapData:BitmapData = new goldWhiteIconClass().bitmapData;
    private static const goldColorIconClass:Class = HudInventoryIcon_goldColorIconClass;
    private static const goldColorIconBitmapData:BitmapData = new goldColorIconClass().bitmapData;
    private static const goldGrayIconClass:Class = HudInventoryIcon_goldGrayIconClass;
    private static const goldGrayIconBitmapData:BitmapData = new goldGrayIconClass().bitmapData;
    private static const droneIconClass:Class = HudInventoryIcon_droneIconClass;
    private static const droneIconBitmapData:BitmapData = new droneIconClass().bitmapData;

    public static const BGD:int = 10;
    public static const LOCK_OVERLAY:int = 11;
    public static const BORDER:int = 12;
    public static const COOLDOWN_OVERLAY:int = 14;
    public static const OVERDRIVE_BG:int = 15;
    public static const OVERDRIVE_COOLDOWN_OVERLAY:int = 17;

    public function HudInventoryIcon() {
      super();
    }

    public static function getIcon(param1:int) : BitmapData {
      var local2:BitmapData = null;
      switch(param1) {
        case HudInventoryIcon.BGD:
          local2 = bgdBitmapData;
          break;
        case HudInventoryIcon.OVERDRIVE_BG:
          local2 = overdriveBgBitmapData;
          break;
        case HudInventoryIcon.LOCK_OVERLAY:
          local2 = lockBitmapData;
          break;
        case HudInventoryIcon.BORDER:
          local2 = borderBitmapData;
          break;
        case HudInventoryIcon.COOLDOWN_OVERLAY:
          local2 = darkBitmapData;
          break;
        case HudInventoryIcon.OVERDRIVE_COOLDOWN_OVERLAY:
          local2 = dark2xBitmapData;
      }
      return local2;
    }

    public static function getBgdIcon(param1:int) : BitmapData {
      var local2:BitmapData = null;
      switch(param1) {
        case InventoryItemType.ULTIMATE:
          local2 = ultimateBgdBitmapData;
          break;
        case InventoryItemType.FIRST_AID:
          local2 = firstAidBgdBitmapData;
          break;
        case InventoryItemType.ARMOR:
          local2 = armorBgdBitmapData;
          break;
        case InventoryItemType.DAMAGE:
          local2 = damageBgdBitmapData;
          break;
        case InventoryItemType.NITRO:
          local2 = nitroBgdBitmapData;
          break;
        case InventoryItemType.MINE:
          local2 = mineBgdBitmapData;
          break;
        case InventoryItemType.GOLD:
          local2 = goldBgdBitmapData;
          break;
        case InventoryItemType.BATTERY:
          local2 = droneIconBitmapData;
      }
      return local2;
    }

    public static function getUltimateIcon(param1:int) : BitmapData {
      switch(param1) {
        case 0:
          return overdriveDictatorIconBitmapData;
        case 1:
          return overdriveHornetIconBitmapData;
        case 2:
          return overdriveHunterIconBitmapData;
        case 3:
          return overdriveJuggernautIconBitmapData;
        case 4:
          return overdriveMammothIconBitmapData;
        case 5:
          return overdriveTitanIconBitmapData;
        case 6:
          return overdriveVikingIconBitmapData;
        case 7:
          return overdriveWaspIconBitmapData;
        default:
          return null;
      }
    }

    public static function getNeutralInventoryIcon(param1:int) : BitmapData {
      var local2:BitmapData = null;
      switch(param1) {
        case InventoryItemType.FIRST_AID:
          local2 = firstAidWhiteIconBitmapData;
          break;
        case InventoryItemType.ARMOR:
          local2 = armorWhiteIconBitmapData;
          break;
        case InventoryItemType.DAMAGE:
          local2 = damageWhiteIconBitmapData;
          break;
        case InventoryItemType.NITRO:
          local2 = nitroWhiteIconBitmapData;
          break;
        case InventoryItemType.MINE:
          local2 = mineWhiteIconBitmapData;
          break;
        case InventoryItemType.GOLD:
          local2 = goldWhiteIconBitmapData;
          break;
        case InventoryItemType.BATTERY:
          local2 = droneIconBitmapData;
      }
      return local2;
    }

    public static function getEffectInventoryIcon(param1:int) : BitmapData {
      var local2:BitmapData = null;
      switch(param1) {
        case InventoryItemType.FIRST_AID:
          local2 = firstAidColorIconBitmapData;
          break;
        case InventoryItemType.ARMOR:
          local2 = armorColorIconBitmapData;
          break;
        case InventoryItemType.DAMAGE:
          local2 = damageColorIconBitmapData;
          break;
        case InventoryItemType.NITRO:
          local2 = nitroColorIconBitmapData;
          break;
        case InventoryItemType.MINE:
          local2 = mineColorIconBitmapData;
          break;
        case InventoryItemType.GOLD:
          local2 = goldColorIconBitmapData;
          break;
        case InventoryItemType.BATTERY:
          local2 = droneIconBitmapData;
      }
      return local2;
    }

    public static function getCooldownInventoryIcon(param1:int) : BitmapData {
      var local2:BitmapData = null;
      switch(param1) {
        case InventoryItemType.FIRST_AID:
          local2 = firstAidGrayIconBitmapData;
          break;
        case InventoryItemType.ARMOR:
          local2 = armorGrayIconBitmapData;
          break;
        case InventoryItemType.DAMAGE:
          local2 = damageGrayIconBitmapData;
          break;
        case InventoryItemType.NITRO:
          local2 = nitroGrayIconBitmapData;
          break;
        case InventoryItemType.MINE:
          local2 = mineGrayIconBitmapData;
          break;
        case InventoryItemType.GOLD:
          local2 = goldGrayIconBitmapData;
          break;
        case InventoryItemType.BATTERY:
          local2 = droneIconBitmapData;
      }
      return local2;
    }

    public static function getIndicatorColor(param1:int) : uint {
      switch(param1) {
        case InventoryItemType.FIRST_AID:
          return 10210624;
        case InventoryItemType.ARMOR:
          return 15248503;
        case InventoryItemType.DAMAGE:
          return 15623237;
        case InventoryItemType.NITRO:
          return 15648305;
        case InventoryItemType.MINE:
          return 3193743;
        case InventoryItemType.GOLD:
          return 16760654;
        case InventoryItemType.BATTERY:
          return ColorConstants.WHITE;
        default:
          return 0;
      }
    }
  }
}
