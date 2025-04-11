package projects.tanks.client.panel.model.garage.availableupgrades {
  public class AvailableUpgradesCC {
    private var _availableUpgradeItems:Vector.<AvailableUpgradeItem>;

    public function AvailableUpgradesCC(param1:Vector.<AvailableUpgradeItem> = null) {
      super();
      this._availableUpgradeItems = param1;
    }

    public function get availableUpgradeItems() : Vector.<AvailableUpgradeItem> {
      return this._availableUpgradeItems;
    }

    public function set availableUpgradeItems(param1:Vector.<AvailableUpgradeItem>) : void {
      this._availableUpgradeItems = param1;
    }

    public function toString() : String {
      var local1:String = "AvailableUpgradesCC [";
      local1 += "availableUpgradeItems = " + this.availableUpgradeItems + " ";
      return local1 + "]";
    }
  }
}
