package projects.tanks.client.battlefield.models.bonus.battle.bonusregions {
  public class BonusRegionsCC {
    private var _bonusRegionResources:Vector.<BonusRegionResource>;
    private var _bonusRegions:Vector.<BonusRegionData>;

    public function BonusRegionsCC(param1:Vector.<BonusRegionResource> = null, param2:Vector.<BonusRegionData> = null) {
      super();
      this._bonusRegionResources = param1;
      this._bonusRegions = param2;
    }

    public function get bonusRegionResources() : Vector.<BonusRegionResource> {
      return this._bonusRegionResources;
    }

    public function set bonusRegionResources(param1:Vector.<BonusRegionResource>) : void {
      this._bonusRegionResources = param1;
    }

    public function get bonusRegions() : Vector.<BonusRegionData> {
      return this._bonusRegions;
    }

    public function set bonusRegions(param1:Vector.<BonusRegionData>) : void {
      this._bonusRegions = param1;
    }

    public function toString() : String {
      var local1:String = "BonusRegionsCC [";
      local1 += "bonusRegionResources = " + this.bonusRegionResources + " ";
      local1 += "bonusRegions = " + this.bonusRegions + " ";
      return local1 + "]";
    }
  }
}
