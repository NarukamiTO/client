package projects.tanks.client.battlefield.models.bonus.battle.goldbonus {
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;

  public class GoldBonusCC {
    private var _regionsData:Vector.<BonusRegionData>;

    public function GoldBonusCC(param1:Vector.<BonusRegionData> = null) {
      super();
      this._regionsData = param1;
    }

    public function get regionsData() : Vector.<BonusRegionData> {
      return this._regionsData;
    }

    public function set regionsData(param1:Vector.<BonusRegionData>) : void {
      this._regionsData = param1;
    }

    public function toString() : String {
      var local1:String = "GoldBonusCC [";
      local1 += "regionsData = " + this.regionsData + " ";
      return local1 + "]";
    }
  }
}
