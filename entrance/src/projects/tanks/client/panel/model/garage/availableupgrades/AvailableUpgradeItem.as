package projects.tanks.client.panel.model.garage.availableupgrades {
  import alternativa.types.Long;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class AvailableUpgradeItem {
    private var _available:Boolean;
    private var _category:ItemViewCategoryEnum;
    private var _timeToEndUpgradeInSec:Long;

    public function AvailableUpgradeItem(param1:Boolean = false, param2:ItemViewCategoryEnum = null, param3:Long = null) {
      super();
      this._available = param1;
      this._category = param2;
      this._timeToEndUpgradeInSec = param3;
    }

    public function get available() : Boolean {
      return this._available;
    }

    public function set available(param1:Boolean) : void {
      this._available = param1;
    }

    public function get category() : ItemViewCategoryEnum {
      return this._category;
    }

    public function set category(param1:ItemViewCategoryEnum) : void {
      this._category = param1;
    }

    public function get timeToEndUpgradeInSec() : Long {
      return this._timeToEndUpgradeInSec;
    }

    public function set timeToEndUpgradeInSec(param1:Long) : void {
      this._timeToEndUpgradeInSec = param1;
    }

    public function toString() : String {
      var local1:String = "AvailableUpgradeItem [";
      local1 += "available = " + this.available + " ";
      local1 += "category = " + this.category + " ";
      local1 += "timeToEndUpgradeInSec = " + this.timeToEndUpgradeInSec + " ";
      return local1 + "]";
    }
  }
}
