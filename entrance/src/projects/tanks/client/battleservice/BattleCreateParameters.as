package projects.tanks.client.battleservice {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;
  import projects.tanks.client.battleservice.model.map.params.MapTheme;

  public class BattleCreateParameters {
    private var _autoBalance:Boolean;
    private var _battleMode:BattleMode;
    private var _clanBattle:Boolean;
    private var _dependentCooldownEnabled:Boolean;
    private var _equipmentConstraintsMode:String;
    private var _friendlyFire:Boolean;
    private var _goldBoxesEnabled:Boolean;
    private var _limits:BattleLimits;
    private var _mapId:Long;
    private var _maxPeopleCount:int;
    private var _name:String;
    private var _parkourMode:Boolean;
    private var _privateBattle:Boolean;
    private var _proBattle:Boolean;
    private var _rankRange:Range;
    private var _reArmorEnabled:Boolean;
    private var _theme:MapTheme;
    private var _ultimatesEnabled:Boolean;
    private var _uniqueUsersBattle:Boolean;
    private var _withoutBonuses:Boolean;
    private var _withoutDevices:Boolean;
    private var _withoutDrones:Boolean;
    private var _withoutSupplies:Boolean;
    private var _withoutUpgrades:Boolean;

    public function BattleCreateParameters(param1:Boolean = false, param2:BattleMode = null, param3:Boolean = false, param4:Boolean = false, param5:String = null, param6:Boolean = false, param7:Boolean = false, param8:BattleLimits = null, param9:Long = null, param10:int = 0, param11:String = null, param12:Boolean = false, param13:Boolean = false, param14:Boolean = false, param15:Range = null, param16:Boolean = false, param17:MapTheme = null, param18:Boolean = false, param19:Boolean = false, param20:Boolean = false, param21:Boolean = false, param22:Boolean = false, param23:Boolean = false, param24:Boolean = false) {
      super();
      this._autoBalance = param1;
      this._battleMode = param2;
      this._clanBattle = param3;
      this._dependentCooldownEnabled = param4;
      this._equipmentConstraintsMode = param5;
      this._friendlyFire = param6;
      this._goldBoxesEnabled = param7;
      this._limits = param8;
      this._mapId = param9;
      this._maxPeopleCount = param10;
      this._name = param11;
      this._parkourMode = param12;
      this._privateBattle = param13;
      this._proBattle = param14;
      this._rankRange = param15;
      this._reArmorEnabled = param16;
      this._theme = param17;
      this._ultimatesEnabled = param18;
      this._uniqueUsersBattle = param19;
      this._withoutBonuses = param20;
      this._withoutDevices = param21;
      this._withoutDrones = param22;
      this._withoutSupplies = param23;
      this._withoutUpgrades = param24;
    }

    public function get autoBalance() : Boolean {
      return this._autoBalance;
    }

    public function set autoBalance(param1:Boolean) : void {
      this._autoBalance = param1;
    }

    public function get battleMode() : BattleMode {
      return this._battleMode;
    }

    public function set battleMode(param1:BattleMode) : void {
      this._battleMode = param1;
    }

    public function get clanBattle() : Boolean {
      return this._clanBattle;
    }

    public function set clanBattle(param1:Boolean) : void {
      this._clanBattle = param1;
    }

    public function get dependentCooldownEnabled() : Boolean {
      return this._dependentCooldownEnabled;
    }

    public function set dependentCooldownEnabled(param1:Boolean) : void {
      this._dependentCooldownEnabled = param1;
    }

    public function get equipmentConstraintsMode() : String {
      return this._equipmentConstraintsMode;
    }

    public function set equipmentConstraintsMode(param1:String) : void {
      this._equipmentConstraintsMode = param1;
    }

    public function get friendlyFire() : Boolean {
      return this._friendlyFire;
    }

    public function set friendlyFire(param1:Boolean) : void {
      this._friendlyFire = param1;
    }

    public function get goldBoxesEnabled() : Boolean {
      return this._goldBoxesEnabled;
    }

    public function set goldBoxesEnabled(param1:Boolean) : void {
      this._goldBoxesEnabled = param1;
    }

    public function get limits() : BattleLimits {
      return this._limits;
    }

    public function set limits(param1:BattleLimits) : void {
      this._limits = param1;
    }

    public function get mapId() : Long {
      return this._mapId;
    }

    public function set mapId(param1:Long) : void {
      this._mapId = param1;
    }

    public function get maxPeopleCount() : int {
      return this._maxPeopleCount;
    }

    public function set maxPeopleCount(param1:int) : void {
      this._maxPeopleCount = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get parkourMode() : Boolean {
      return this._parkourMode;
    }

    public function set parkourMode(param1:Boolean) : void {
      this._parkourMode = param1;
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

    public function get rankRange() : Range {
      return this._rankRange;
    }

    public function set rankRange(param1:Range) : void {
      this._rankRange = param1;
    }

    public function get reArmorEnabled() : Boolean {
      return this._reArmorEnabled;
    }

    public function set reArmorEnabled(param1:Boolean) : void {
      this._reArmorEnabled = param1;
    }

    public function get theme() : MapTheme {
      return this._theme;
    }

    public function set theme(param1:MapTheme) : void {
      this._theme = param1;
    }

    public function get ultimatesEnabled() : Boolean {
      return this._ultimatesEnabled;
    }

    public function set ultimatesEnabled(param1:Boolean) : void {
      this._ultimatesEnabled = param1;
    }

    public function get uniqueUsersBattle() : Boolean {
      return this._uniqueUsersBattle;
    }

    public function set uniqueUsersBattle(param1:Boolean) : void {
      this._uniqueUsersBattle = param1;
    }

    public function get withoutBonuses() : Boolean {
      return this._withoutBonuses;
    }

    public function set withoutBonuses(param1:Boolean) : void {
      this._withoutBonuses = param1;
    }

    public function get withoutDevices() : Boolean {
      return this._withoutDevices;
    }

    public function set withoutDevices(param1:Boolean) : void {
      this._withoutDevices = param1;
    }

    public function get withoutDrones() : Boolean {
      return this._withoutDrones;
    }

    public function set withoutDrones(param1:Boolean) : void {
      this._withoutDrones = param1;
    }

    public function get withoutSupplies() : Boolean {
      return this._withoutSupplies;
    }

    public function set withoutSupplies(param1:Boolean) : void {
      this._withoutSupplies = param1;
    }

    public function get withoutUpgrades() : Boolean {
      return this._withoutUpgrades;
    }

    public function set withoutUpgrades(param1:Boolean) : void {
      this._withoutUpgrades = param1;
    }

    public function toString() : String {
      var local1:String = "BattleCreateParameters [";
      local1 += "autoBalance = " + this.autoBalance + " ";
      local1 += "battleMode = " + this.battleMode + " ";
      local1 += "clanBattle = " + this.clanBattle + " ";
      local1 += "dependentCooldownEnabled = " + this.dependentCooldownEnabled + " ";
      local1 += "equipmentConstraintsMode = " + this.equipmentConstraintsMode + " ";
      local1 += "friendlyFire = " + this.friendlyFire + " ";
      local1 += "goldBoxesEnabled = " + this.goldBoxesEnabled + " ";
      local1 += "limits = " + this.limits + " ";
      local1 += "mapId = " + this.mapId + " ";
      local1 += "maxPeopleCount = " + this.maxPeopleCount + " ";
      local1 += "name = " + this.name + " ";
      local1 += "parkourMode = " + this.parkourMode + " ";
      local1 += "privateBattle = " + this.privateBattle + " ";
      local1 += "proBattle = " + this.proBattle + " ";
      local1 += "rankRange = " + this.rankRange + " ";
      local1 += "reArmorEnabled = " + this.reArmorEnabled + " ";
      local1 += "theme = " + this.theme + " ";
      local1 += "ultimatesEnabled = " + this.ultimatesEnabled + " ";
      local1 += "uniqueUsersBattle = " + this.uniqueUsersBattle + " ";
      local1 += "withoutBonuses = " + this.withoutBonuses + " ";
      local1 += "withoutDevices = " + this.withoutDevices + " ";
      local1 += "withoutDrones = " + this.withoutDrones + " ";
      local1 += "withoutSupplies = " + this.withoutSupplies + " ";
      local1 += "withoutUpgrades = " + this.withoutUpgrades + " ";
      return local1 + "]";
    }
  }
}
