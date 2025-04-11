package projects.tanks.client.garage.models.item.mobilelootbox.deliverylootbox {
  public class MobileLootBoxDeliveryCC {
    private var _periodOfGiveLootBoxInMin:int;
    private var _remainingTimeToGiveLootBoxInSec:int;

    public function MobileLootBoxDeliveryCC(param1:int = 0, param2:int = 0) {
      super();
      this._periodOfGiveLootBoxInMin = param1;
      this._remainingTimeToGiveLootBoxInSec = param2;
    }

    public function get periodOfGiveLootBoxInMin() : int {
      return this._periodOfGiveLootBoxInMin;
    }

    public function set periodOfGiveLootBoxInMin(param1:int) : void {
      this._periodOfGiveLootBoxInMin = param1;
    }

    public function get remainingTimeToGiveLootBoxInSec() : int {
      return this._remainingTimeToGiveLootBoxInSec;
    }

    public function set remainingTimeToGiveLootBoxInSec(param1:int) : void {
      this._remainingTimeToGiveLootBoxInSec = param1;
    }

    public function toString() : String {
      var local1:String = "MobileLootBoxDeliveryCC [";
      local1 += "periodOfGiveLootBoxInMin = " + this.periodOfGiveLootBoxInMin + " ";
      local1 += "remainingTimeToGiveLootBoxInSec = " + this.remainingTimeToGiveLootBoxInSec + " ";
      return local1 + "]";
    }
  }
}
