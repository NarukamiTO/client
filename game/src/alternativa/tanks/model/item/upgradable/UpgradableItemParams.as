package alternativa.tanks.model.item.upgradable {
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.upgradingitems.UpgradingItemsService;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteAfter;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.upgradeable.UpgradeParamsCC;
  import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
  import projects.tanks.client.garage.models.item.upgradeable.types.UpgradeParamsData;

  public class UpgradableItemParams implements CountDownTimerOnCompleteAfter {
    [Inject]
    public static var upgradingItemService:UpgradingItemsService;

    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    [Inject]
    public static var itemService:ItemService;

    private static const SECONDS_IN_MINUTE:int = 60;

    public var properties:Vector.<UpgradableItemPropertyValue>;
    public var visibleProperties:Vector.<UpgradableItemPropertyValue>;
    public var timer:CountDownTimer = null;

    private var currentLevel:int;
    private var upgradeParams:UpgradeParamsData;
    private var speedUpDiscount:int;
    private var upgradeDiscount:int;
    private var timeDiscount:int;

    public function UpgradableItemParams(param1:UpgradeParamsCC, param2:IGameObject) {
      var local3:GaragePropertyParams = null;
      var local4:UpgradableItemPropertyValue = null;
      var local5:UpgradableItemPropertyValue = null;
      var local6:int = 0;
      super();
      this.currentLevel = param1.currentLevel;
      this.upgradeParams = param1.itemData;
      this.speedUpDiscount = param1.speedUpDiscount;
      this.upgradeDiscount = param1.upgradeDiscount;
      this.timeDiscount = param1.timeDiscount;
      this.properties = new Vector.<UpgradableItemPropertyValue>();
      for each(local3 in param1.itemData.properties) {
        local5 = new UpgradableItemPropertyValue(this.upgradeParams.upgradeLevelsCount,local3);
        this.properties.push(local5);
      }
      this.properties.sort(this.compare);
      this.visibleProperties = new Vector.<UpgradableItemPropertyValue>();
      for each(local4 in this.properties) {
        if(local4.isVisibleInInfo()) {
          this.visibleProperties.push(local4);
        }
      }
      if(param1.remainingTimeInMS > 0) {
        this.timer = upgradingItemService.getCountDownTimer(param2);
        if(this.timer == null) {
          this.timer = new CountDownTimer();
          upgradingItemService.add(itemService.getGarageItemInfo(param2),this.timer);
        }
        local6 = Math.max(this.timer.getEndTime(),getTimer() + param1.remainingTimeInMS);
        this.setTimer(this.timer);
        this.timer.start(local6);
      }
    }

    private function compare(param1:UpgradableItemPropertyValue, param2:UpgradableItemPropertyValue) : Number {
      var local3:ItemPropertyParams = propertyService.getParams(param1.getProperty());
      var local4:ItemPropertyParams = propertyService.getParams(param2.getProperty());
      var local5:int = local3 != null ? local3.sortIndex : 0;
      var local6:int = local4 != null ? local4.sortIndex : 0;
      if(local5 < local6) {
        return -1;
      }
      if(local5 > local6) {
        return 1;
      }
      return 0;
    }

    private function setTimer(param1:CountDownTimer) : void {
      this.timer = param1;
      param1.addListener(CountDownTimerOnCompleteAfter,this);
    }

    public function getValue(param1:ItemGarageProperty) : UpgradableItemPropertyValue {
      var local2:UpgradableItemPropertyValue = null;
      for each(local2 in this.properties) {
        if(local2.getProperty() == param1) {
          return local2;
        }
      }
      return null;
    }

    public function startUpgrade(param1:CountDownTimer) : void {
      this.setTimer(param1);
    }

    public function speedUp() : void {
      ++this.currentLevel;
      this.timer.removeListener(CountDownTimerOnCompleteAfter,this);
      this.timer = null;
    }

    public function isUpgrading() : Boolean {
      return this.timer != null;
    }

    public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void {
      this.speedUp();
    }

    public function getLevelsCount() : int {
      return this.upgradeParams.upgradeLevelsCount;
    }

    public function isFullUpgraded() : Boolean {
      return this.currentLevel == this.getLevelsCount();
    }

    public function getLevel() : int {
      return this.currentLevel;
    }

    public function getStartUpgradePrice() : int {
      var local1:int = this.getStartUpgradePriceForLevelWithoutDiscount(this.getLevel());
      return this.applyDiscount(local1,this.upgradeDiscount);
    }

    private function getStartUpgradePriceForLevelWithoutDiscount(param1:int) : int {
      if(this.getLevelsCount() == 1) {
        return this.upgradeParams.initialUpgradePrice;
      }
      var local2:int = this.upgradeParams.initialUpgradePrice + (this.upgradeParams.finalUpgradePrice - this.upgradeParams.initialUpgradePrice) * param1 / (this.getLevelsCount() - 1) + 0.001;
      return int((local2 + 5) / 10 + 0.01) * 10;
    }

    public function getSpeedUpPrice() : int {
      var local1:Number = this.getSpeedUpPriceWithoutDiscount(this.timer.getRemainingSeconds() / SECONDS_IN_MINUTE);
      return this.applyDiscount(local1,this.speedUpDiscount);
    }

    public function getInitialSpeedUpPrice() : int {
      var local1:Number = this.getSpeedUpPriceWithoutDiscount(this.getTimeInMinutes());
      return this.applyDiscount(local1,this.speedUpDiscount);
    }

    private function getSpeedUpPriceWithoutDiscount(param1:Number) : int {
      return Math.round(param1 * this.upgradeParams.speedUpCoeff / this.upgradeParams.upgradeTimeCoeff) + 0.1;
    }

    public function getTimeInSeconds() : int {
      return this.getTimeInMinutes() * SECONDS_IN_MINUTE + 0.1;
    }

    private function getTimeInMinutes() : Number {
      var local1:int = this.getTimeInMinutesForLevelWithoutDiscount(this.getLevel()) * SECONDS_IN_MINUTE;
      return this.applyDiscount(local1,this.timeDiscount) / SECONDS_IN_MINUTE;
    }

    private function getTimeInMinutesForLevelWithoutDiscount(param1:int) : Number {
      return Math.round(this.getStartUpgradePriceForLevelWithoutDiscount(param1) * this.upgradeParams.upgradeTimeCoeff);
    }

    private function applyDiscount(param1:int, param2:int) : int {
      if(param2 == 0) {
        return param1;
      }
      return int(param1 * (100 - param2) / 100 + 0.001);
    }

    public function hasSpeedUpDiscount() : Boolean {
      return this.speedUpDiscount > 0;
    }

    public function hasUpgradeDiscount() : Boolean {
      return this.upgradeDiscount > 0 || this.timeDiscount > 0;
    }

    public function traceUpgrades() : void {
      var local1:UpgradableItemPropertyValue = null;
      var local2:int = 0;
      var local3:Number = NaN;
      for each(local1 in this.properties) {
      }
      local2 = 0;
      while(local2 <= this.getLevelsCount()) {
        for each(local1 in this.properties) {
        }
        if(local2 != this.getLevelsCount()) {
          local3 = this.getTimeInMinutesForLevelWithoutDiscount(local2);
        }
        local2++;
      }
    }
  }
}
