package alternativa.tanks.model.garage.upgrade {
  import flash.utils.clearTimeout;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.type.IGameObject;

  public class DelayUpgrades {
    private const MAX_DELAY_MS:int = 20000;
    private const DELAY_MS:int = 2000;

    private var numLevels:int;
    private var updradeStarted:Boolean;
    private var startUpgradePrice:int;
    private var upgradeTime:int;
    private var totalPrice:int;
    private var time:int;
    private var flush:FlushUpgrades;
    private var timeoutId:int;
    private var item:IGameObject;

    public function DelayUpgrades(param1:FlushUpgrades) {
      super();
      this.flush = param1;
      this.clear();
    }

    private function clear() : void {
      this.item = null;
      this.numLevels = 0;
      this.updradeStarted = false;
      this.totalPrice = 0;
      this.timeoutId = -1;
    }

    public function startUpgrade(param1:IGameObject, param2:int, param3:int) : void {
      if(!this.isDelayedItem(param1) || this.updradeStarted) {
        if(this.isDelayed()) {
          this.flushToServer();
        }
        this.item = param1;
        this.time = getTimer();
      }
      this.startUpgradePrice = param2;
      this.updradeStarted = true;
      this.upgradeTime = param3;
      this.delay();
    }

    public function speedUp(param1:int) : void {
      this.totalPrice += param1 + this.startUpgradePrice;
      ++this.numLevels;
      this.updradeStarted = false;
      this.delay();
    }

    private function delay() : void {
      var local1:int = getTimer();
      if(this.timeoutId != -1) {
        clearTimeout(this.timeoutId);
        this.timeoutId = -1;
      }
      if(local1 - this.time + this.DELAY_MS > this.MAX_DELAY_MS) {
        this.flushToServer();
      } else {
        this.timeoutId = setTimeout(this.flushToServer,this.DELAY_MS);
      }
    }

    public function flushToServer() : void {
      if(this.timeoutId != -1) {
        clearTimeout(this.timeoutId);
        this.timeoutId = -1;
      }
      this.flush.flushToServer(this,this.item);
      this.clear();
    }

    public function isDelayed() : Boolean {
      return this.item != null;
    }

    public function isDelayedItem(param1:IGameObject) : Boolean {
      return this.item == param1;
    }

    public function getNumLevels() : int {
      return this.numLevels;
    }

    public function getPrice() : int {
      return this.totalPrice;
    }

    public function isUpgradeStarted() : Boolean {
      return this.updradeStarted;
    }

    public function getStartUpgradePrice() : int {
      return this.startUpgradePrice;
    }

    public function getUpgradeTime() : int {
      return this.upgradeTime;
    }
  }
}
