package projects.tanks.client.battleselect.model.battleselect.create {
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;

  public class BattleCreateCC {
    private var _battleCreationDisabled:Boolean;
    private var _battlesLimits:Vector.<BattleLimits>;
    private var _defaultRange:Range;
    private var _maxRange:Range;
    private var _maxRangeLength:int;
    private var _ultimatesEnabled:Boolean;

    public function BattleCreateCC(param1:Boolean = false, param2:Vector.<BattleLimits> = null, param3:Range = null, param4:Range = null, param5:int = 0, param6:Boolean = false) {
      super();
      this._battleCreationDisabled = param1;
      this._battlesLimits = param2;
      this._defaultRange = param3;
      this._maxRange = param4;
      this._maxRangeLength = param5;
      this._ultimatesEnabled = param6;
    }

    public function get battleCreationDisabled() : Boolean {
      return this._battleCreationDisabled;
    }

    public function set battleCreationDisabled(param1:Boolean) : void {
      this._battleCreationDisabled = param1;
    }

    public function get battlesLimits() : Vector.<BattleLimits> {
      return this._battlesLimits;
    }

    public function set battlesLimits(param1:Vector.<BattleLimits>) : void {
      this._battlesLimits = param1;
    }

    public function get defaultRange() : Range {
      return this._defaultRange;
    }

    public function set defaultRange(param1:Range) : void {
      this._defaultRange = param1;
    }

    public function get maxRange() : Range {
      return this._maxRange;
    }

    public function set maxRange(param1:Range) : void {
      this._maxRange = param1;
    }

    public function get maxRangeLength() : int {
      return this._maxRangeLength;
    }

    public function set maxRangeLength(param1:int) : void {
      this._maxRangeLength = param1;
    }

    public function get ultimatesEnabled() : Boolean {
      return this._ultimatesEnabled;
    }

    public function set ultimatesEnabled(param1:Boolean) : void {
      this._ultimatesEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "BattleCreateCC [";
      local1 += "battleCreationDisabled = " + this.battleCreationDisabled + " ";
      local1 += "battlesLimits = " + this.battlesLimits + " ";
      local1 += "defaultRange = " + this.defaultRange + " ";
      local1 += "maxRange = " + this.maxRange + " ";
      local1 += "maxRangeLength = " + this.maxRangeLength + " ";
      local1 += "ultimatesEnabled = " + this.ultimatesEnabled + " ";
      return local1 + "]";
    }
  }
}
