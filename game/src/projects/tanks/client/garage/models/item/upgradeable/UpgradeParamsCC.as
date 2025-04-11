package projects.tanks.client.garage.models.item.upgradeable {
  import projects.tanks.client.garage.models.item.upgradeable.types.UpgradeParamsData;

  public class UpgradeParamsCC {
    private var _currentLevel:int;
    private var _itemData:UpgradeParamsData;
    private var _remainingTimeInMS:int;
    private var _speedUpDiscount:int;
    private var _timeDiscount:int;
    private var _upgradeDiscount:int;

    public function UpgradeParamsCC(param1:int = 0, param2:UpgradeParamsData = null, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0) {
      super();
      this._currentLevel = param1;
      this._itemData = param2;
      this._remainingTimeInMS = param3;
      this._speedUpDiscount = param4;
      this._timeDiscount = param5;
      this._upgradeDiscount = param6;
    }

    public function get currentLevel() : int {
      return this._currentLevel;
    }

    public function set currentLevel(param1:int) : void {
      this._currentLevel = param1;
    }

    public function get itemData() : UpgradeParamsData {
      return this._itemData;
    }

    public function set itemData(param1:UpgradeParamsData) : void {
      this._itemData = param1;
    }

    public function get remainingTimeInMS() : int {
      return this._remainingTimeInMS;
    }

    public function set remainingTimeInMS(param1:int) : void {
      this._remainingTimeInMS = param1;
    }

    public function get speedUpDiscount() : int {
      return this._speedUpDiscount;
    }

    public function set speedUpDiscount(param1:int) : void {
      this._speedUpDiscount = param1;
    }

    public function get timeDiscount() : int {
      return this._timeDiscount;
    }

    public function set timeDiscount(param1:int) : void {
      this._timeDiscount = param1;
    }

    public function get upgradeDiscount() : int {
      return this._upgradeDiscount;
    }

    public function set upgradeDiscount(param1:int) : void {
      this._upgradeDiscount = param1;
    }

    public function toString() : String {
      var local1:String = "UpgradeParamsCC [";
      local1 += "currentLevel = " + this.currentLevel + " ";
      local1 += "itemData = " + this.itemData + " ";
      local1 += "remainingTimeInMS = " + this.remainingTimeInMS + " ";
      local1 += "speedUpDiscount = " + this.speedUpDiscount + " ";
      local1 += "timeDiscount = " + this.timeDiscount + " ";
      local1 += "upgradeDiscount = " + this.upgradeDiscount + " ";
      return local1 + "]";
    }
  }
}
