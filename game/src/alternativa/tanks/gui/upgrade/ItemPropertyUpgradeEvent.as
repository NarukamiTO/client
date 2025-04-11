package alternativa.tanks.gui.upgrade {
  import controls.timer.CountDownTimer;
  import flash.events.Event;

  public class ItemPropertyUpgradeEvent extends Event {
    public static const SELECT_WINDOW_OPENED:String = "ItemPropertyUpgradeEventSelectWindowOpened";
    public static const SELECT_WINDOW_CLOSED:String = "ItemPropertyUpgradeEventSelectWindowClosed";
    public static const UPGRADE_STARTED:String = "ItemPropertyUpgradeEventUpgradeStarted";
    public static const SPEED_UP:String = "ItemPropertyUpgradeEventSpeedUp";
    public static const FLUSH_UPGRADES:String = "ItemPropertyUpgradeEventFlushUpgrades";

    private var timer:CountDownTimer;
    private var price:int;

    public function ItemPropertyUpgradeEvent(param1:String, param2:CountDownTimer = null, param3:int = 0) {
      super(param1,bubbles,cancelable);
      this.timer = param2;
      this.price = param3;
    }

    public function getTimer() : CountDownTimer {
      return this.timer;
    }

    public function getPrice() : int {
      return this.price;
    }
  }
}
