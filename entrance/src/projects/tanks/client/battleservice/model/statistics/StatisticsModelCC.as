package projects.tanks.client.battleservice.model.statistics {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.createparams.BattleLimits;

  public class StatisticsModelCC {
    private var _battleName:String;
    private var _equipmentConstraintsMode:String;
    private var _fund:int;
    private var _limits:BattleLimits;
    private var _mapName:String;
    private var _matchBattle:Boolean;
    private var _maxPeopleCount:int;
    private var _modeName:String;
    private var _parkourMode:Boolean;
    private var _running:Boolean;
    private var _spectator:Boolean;
    private var _suspiciousUserIds:Vector.<Long>;
    private var _timeLeft:int;
    private var _valuableRound:Boolean;

    public function StatisticsModelCC(param1:String = null, param2:String = null, param3:int = 0, param4:BattleLimits = null, param5:String = null, param6:Boolean = false, param7:int = 0, param8:String = null, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Vector.<Long> = null, param13:int = 0, param14:Boolean = false) {
      super();
      this._battleName = param1;
      this._equipmentConstraintsMode = param2;
      this._fund = param3;
      this._limits = param4;
      this._mapName = param5;
      this._matchBattle = param6;
      this._maxPeopleCount = param7;
      this._modeName = param8;
      this._parkourMode = param9;
      this._running = param10;
      this._spectator = param11;
      this._suspiciousUserIds = param12;
      this._timeLeft = param13;
      this._valuableRound = param14;
    }

    public function get battleName() : String {
      return this._battleName;
    }

    public function set battleName(param1:String) : void {
      this._battleName = param1;
    }

    public function get equipmentConstraintsMode() : String {
      return this._equipmentConstraintsMode;
    }

    public function set equipmentConstraintsMode(param1:String) : void {
      this._equipmentConstraintsMode = param1;
    }

    public function get fund() : int {
      return this._fund;
    }

    public function set fund(param1:int) : void {
      this._fund = param1;
    }

    public function get limits() : BattleLimits {
      return this._limits;
    }

    public function set limits(param1:BattleLimits) : void {
      this._limits = param1;
    }

    public function get mapName() : String {
      return this._mapName;
    }

    public function set mapName(param1:String) : void {
      this._mapName = param1;
    }

    public function get matchBattle() : Boolean {
      return this._matchBattle;
    }

    public function set matchBattle(param1:Boolean) : void {
      this._matchBattle = param1;
    }

    public function get maxPeopleCount() : int {
      return this._maxPeopleCount;
    }

    public function set maxPeopleCount(param1:int) : void {
      this._maxPeopleCount = param1;
    }

    public function get modeName() : String {
      return this._modeName;
    }

    public function set modeName(param1:String) : void {
      this._modeName = param1;
    }

    public function get parkourMode() : Boolean {
      return this._parkourMode;
    }

    public function set parkourMode(param1:Boolean) : void {
      this._parkourMode = param1;
    }

    public function get running() : Boolean {
      return this._running;
    }

    public function set running(param1:Boolean) : void {
      this._running = param1;
    }

    public function get spectator() : Boolean {
      return this._spectator;
    }

    public function set spectator(param1:Boolean) : void {
      this._spectator = param1;
    }

    public function get suspiciousUserIds() : Vector.<Long> {
      return this._suspiciousUserIds;
    }

    public function set suspiciousUserIds(param1:Vector.<Long>) : void {
      this._suspiciousUserIds = param1;
    }

    public function get timeLeft() : int {
      return this._timeLeft;
    }

    public function set timeLeft(param1:int) : void {
      this._timeLeft = param1;
    }

    public function get valuableRound() : Boolean {
      return this._valuableRound;
    }

    public function set valuableRound(param1:Boolean) : void {
      this._valuableRound = param1;
    }

    public function toString() : String {
      var local1:String = "StatisticsModelCC [";
      local1 += "battleName = " + this.battleName + " ";
      local1 += "equipmentConstraintsMode = " + this.equipmentConstraintsMode + " ";
      local1 += "fund = " + this.fund + " ";
      local1 += "limits = " + this.limits + " ";
      local1 += "mapName = " + this.mapName + " ";
      local1 += "matchBattle = " + this.matchBattle + " ";
      local1 += "maxPeopleCount = " + this.maxPeopleCount + " ";
      local1 += "modeName = " + this.modeName + " ";
      local1 += "parkourMode = " + this.parkourMode + " ";
      local1 += "running = " + this.running + " ";
      local1 += "spectator = " + this.spectator + " ";
      local1 += "suspiciousUserIds = " + this.suspiciousUserIds + " ";
      local1 += "timeLeft = " + this.timeLeft + " ";
      local1 += "valuableRound = " + this.valuableRound + " ";
      return local1 + "]";
    }
  }
}
