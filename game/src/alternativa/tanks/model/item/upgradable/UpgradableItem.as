package alternativa.tanks.model.item.upgradable {
  import controls.timer.CountDownTimer;

  [ModelInterface]
  public interface UpgradableItem {
    function getUpgradableItem() : UpgradableItemParams;
    function getUpgradableProperties() : Vector.<UpgradableItemPropertyValue>;
    function getVisibleUpgradableProperties() : Vector.<UpgradableItemPropertyValue>;
    function isUpgrading() : Boolean;
    function speedUp() : void;
    function getCountDownTimer() : CountDownTimer;
    function traceUpgrades() : void;
    function hasUpgradeDiscount() : Boolean;
    function hasSpeedUpDiscount() : Boolean;
  }
}
