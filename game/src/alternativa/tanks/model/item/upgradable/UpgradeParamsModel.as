package alternativa.tanks.model.item.upgradable {
  import alternativa.tanks.model.item.properties.ItemProperties;
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.service.item.ItemService;
  import controls.timer.CountDownTimer;
  import projects.tanks.client.garage.models.item.upgradeable.IUpgradeableParamsConstructorModelBase;
  import projects.tanks.client.garage.models.item.upgradeable.UpgradeParamsCC;
  import projects.tanks.client.garage.models.item.upgradeable.UpgradeableParamsConstructorModelBase;

  [ModelInfo]
  public class UpgradeParamsModel extends UpgradeableParamsConstructorModelBase implements IUpgradeableParamsConstructorModelBase, UpgradableItem, ItemProperties {
    [Inject]
    public static var itemService:ItemService;

    public function UpgradeParamsModel() {
      super();
    }

    public function getUpgradableItem() : UpgradableItemParams {
      return this.data();
    }

    public function getProperties() : Vector.<ItemPropertyValue> {
      return Vector.<ItemPropertyValue>(this.data().properties);
    }

    public function getPropertiesForInfoWindow() : Vector.<ItemPropertyValue> {
      return Vector.<ItemPropertyValue>(this.data().visibleProperties);
    }

    public function getUpgradableProperties() : Vector.<UpgradableItemPropertyValue> {
      return this.data().properties;
    }

    public function getVisibleUpgradableProperties() : Vector.<UpgradableItemPropertyValue> {
      return this.data().visibleProperties;
    }

    public function isUpgrading() : Boolean {
      return this.data().isUpgrading();
    }

    public function speedUp() : void {
      return this.data().speedUp();
    }

    public function getCountDownTimer() : CountDownTimer {
      return this.data().timer;
    }

    public function traceUpgrades() : void {
      var local1:String = null;
      if(this.data().getLevelsCount() > 0) {
        local1 = itemService.getName(object);
        this.data().traceUpgrades();
      }
    }

    private function data() : UpgradableItemParams {
      var local2:UpgradeParamsCC = null;
      var local1:UpgradableItemParams = UpgradableItemParams(getData(UpgradableItemParams));
      if(local1 == null) {
        local2 = getInitParam();
        local1 = new UpgradableItemParams(local2,object);
        putData(UpgradableItemParams,local1);
      }
      return local1;
    }

    public function hasUpgradeDiscount() : Boolean {
      var local1:UpgradeParamsCC = getInitParam();
      return local1.timeDiscount > 0 || local1.upgradeDiscount > 0;
    }

    public function hasSpeedUpDiscount() : Boolean {
      return getInitParam().speedUpDiscount > 0;
    }
  }
}
