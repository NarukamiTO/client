package projects.tanks.client.tanksservices.types.battle {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;

  public class BattleInfoData {
    private var _battleId:Long;
    private var _inGroup:Boolean;
    private var _mapName:String;
    private var _mode:BattleMode;
    private var _privateBattle:Boolean;
    private var _proBattle:Boolean;
    private var _range:Range;

    public function BattleInfoData(param1:Long = null, param2:Boolean = false, param3:String = null, param4:BattleMode = null, param5:Boolean = false, param6:Boolean = false, param7:Range = null) {
      super();
      this._battleId = param1;
      this._inGroup = param2;
      this._mapName = param3;
      this._mode = param4;
      this._privateBattle = param5;
      this._proBattle = param6;
      this._range = param7;
    }

    public function get battleId() : Long {
      return this._battleId;
    }

    public function set battleId(param1:Long) : void {
      this._battleId = param1;
    }

    public function get inGroup() : Boolean {
      return this._inGroup;
    }

    public function set inGroup(param1:Boolean) : void {
      this._inGroup = param1;
    }

    public function get mapName() : String {
      return this._mapName;
    }

    public function set mapName(param1:String) : void {
      this._mapName = param1;
    }

    public function get mode() : BattleMode {
      return this._mode;
    }

    public function set mode(param1:BattleMode) : void {
      this._mode = param1;
    }

    public function get privateBattle() : Boolean {
      return this._privateBattle;
    }

    public function set privateBattle(param1:Boolean) : void {
      this._privateBattle = param1;
    }

    public function get proBattle() : Boolean {
      return this._proBattle;
    }

    public function set proBattle(param1:Boolean) : void {
      this._proBattle = param1;
    }

    public function get range() : Range {
      return this._range;
    }

    public function set range(param1:Range) : void {
      this._range = param1;
    }

    public function toString() : String {
      var local1:String = "BattleInfoData [";
      local1 += "battleId = " + this.battleId + " ";
      local1 += "inGroup = " + this.inGroup + " ";
      local1 += "mapName = " + this.mapName + " ";
      local1 += "mode = " + this.mode + " ";
      local1 += "privateBattle = " + this.privateBattle + " ";
      local1 += "proBattle = " + this.proBattle + " ";
      local1 += "range = " + this.range + " ";
      return local1 + "]";
    }
  }
}
