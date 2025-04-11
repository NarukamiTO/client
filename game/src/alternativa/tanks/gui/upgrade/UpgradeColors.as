package alternativa.tanks.gui.upgrade {
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import alternativa.tanks.service.item.ItemService;
  import platform.client.fp10.core.type.IGameObject;

  public class UpgradeColors {
    [Inject]
    public static var itemService:ItemService;

    public static const GREEN:int = 65291;
    public static const WHITE:int = 16777215;
    public static const GOLD:int = 16580352;
    public static const LIGHT_GREEN:int = 8847108;

    public function UpgradeColors() {
      super();
    }

    public static function getColorForItem(param1:IGameObject, param2:ItemPropertyValue) : int {
      if(itemService.isUpgradableItem(param1)) {
        return getColor(itemService.getUpgradableItemParams(param1),UpgradableItemPropertyValue(param2));
      }
      return WHITE;
    }

    public static function getColor(param1:UpgradableItemParams, param2:UpgradableItemPropertyValue) : int {
      return getColorForLevel(param1,param2,param1.getLevel());
    }

    public static function getNextColor(param1:UpgradableItemParams, param2:UpgradableItemPropertyValue) : int {
      return getColorForLevel(param1,param2,param1.getLevel() + 1);
    }

    private static function getColorForLevel(param1:UpgradableItemParams, param2:UpgradableItemPropertyValue, param3:int) : int {
      if(param2.isUpgradable()) {
        return getColorForUpgradableItem(param1,param3);
      }
      return UpgradeColors.GOLD;
    }

    private static function getColorForUpgradableItem(param1:UpgradableItemParams, param2:int) : int {
      if(param1.getLevelsCount() == param2) {
        return GOLD;
      }
      if(param2 > 0) {
        return LIGHT_GREEN;
      }
      return WHITE;
    }
  }
}
