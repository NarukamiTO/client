package projects.tanks.client.garage.models.item.delaymount {
  public class DelayMountCategoryCC {
    private var _delayMountArmorInSec:int;
    private var _delayMountDroneInSec:int;
    private var _delayMountResistanceInSec:int;
    private var _delayMountWeaponInSec:int;

    public function DelayMountCategoryCC(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) {
      super();
      this._delayMountArmorInSec = param1;
      this._delayMountDroneInSec = param2;
      this._delayMountResistanceInSec = param3;
      this._delayMountWeaponInSec = param4;
    }

    public function get delayMountArmorInSec() : int {
      return this._delayMountArmorInSec;
    }

    public function set delayMountArmorInSec(param1:int) : void {
      this._delayMountArmorInSec = param1;
    }

    public function get delayMountDroneInSec() : int {
      return this._delayMountDroneInSec;
    }

    public function set delayMountDroneInSec(param1:int) : void {
      this._delayMountDroneInSec = param1;
    }

    public function get delayMountResistanceInSec() : int {
      return this._delayMountResistanceInSec;
    }

    public function set delayMountResistanceInSec(param1:int) : void {
      this._delayMountResistanceInSec = param1;
    }

    public function get delayMountWeaponInSec() : int {
      return this._delayMountWeaponInSec;
    }

    public function set delayMountWeaponInSec(param1:int) : void {
      this._delayMountWeaponInSec = param1;
    }

    public function toString() : String {
      var local1:String = "DelayMountCategoryCC [";
      local1 += "delayMountArmorInSec = " + this.delayMountArmorInSec + " ";
      local1 += "delayMountDroneInSec = " + this.delayMountDroneInSec + " ";
      local1 += "delayMountResistanceInSec = " + this.delayMountResistanceInSec + " ";
      local1 += "delayMountWeaponInSec = " + this.delayMountWeaponInSec + " ";
      return local1 + "]";
    }
  }
}
