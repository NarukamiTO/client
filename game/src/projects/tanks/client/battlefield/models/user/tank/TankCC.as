package projects.tanks.client.battlefield.models.user.tank {
  import projects.tanks.client.battlefield.types.TankState;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TankCC {
    private var _health:int;
    private var _local:Boolean;
    private var _logicState:TankLogicState;
    private var _movementDistanceBorderUntilTankCorrection:int;
    private var _movementTimeoutUntilTankCorrection:int;
    private var _tankState:TankState;
    private var _team:BattleTeam;

    public function TankCC(param1:int = 0, param2:Boolean = false, param3:TankLogicState = null, param4:int = 0, param5:int = 0, param6:TankState = null, param7:BattleTeam = null) {
      super();
      this._health = param1;
      this._local = param2;
      this._logicState = param3;
      this._movementDistanceBorderUntilTankCorrection = param4;
      this._movementTimeoutUntilTankCorrection = param5;
      this._tankState = param6;
      this._team = param7;
    }

    public function get health() : int {
      return this._health;
    }

    public function set health(param1:int) : void {
      this._health = param1;
    }

    public function get local() : Boolean {
      return this._local;
    }

    public function set local(param1:Boolean) : void {
      this._local = param1;
    }

    public function get logicState() : TankLogicState {
      return this._logicState;
    }

    public function set logicState(param1:TankLogicState) : void {
      this._logicState = param1;
    }

    public function get movementDistanceBorderUntilTankCorrection() : int {
      return this._movementDistanceBorderUntilTankCorrection;
    }

    public function set movementDistanceBorderUntilTankCorrection(param1:int) : void {
      this._movementDistanceBorderUntilTankCorrection = param1;
    }

    public function get movementTimeoutUntilTankCorrection() : int {
      return this._movementTimeoutUntilTankCorrection;
    }

    public function set movementTimeoutUntilTankCorrection(param1:int) : void {
      this._movementTimeoutUntilTankCorrection = param1;
    }

    public function get tankState() : TankState {
      return this._tankState;
    }

    public function set tankState(param1:TankState) : void {
      this._tankState = param1;
    }

    public function get team() : BattleTeam {
      return this._team;
    }

    public function set team(param1:BattleTeam) : void {
      this._team = param1;
    }

    public function toString() : String {
      var local1:String = "TankCC [";
      local1 += "health = " + this.health + " ";
      local1 += "local = " + this.local + " ";
      local1 += "logicState = " + this.logicState + " ";
      local1 += "movementDistanceBorderUntilTankCorrection = " + this.movementDistanceBorderUntilTankCorrection + " ";
      local1 += "movementTimeoutUntilTankCorrection = " + this.movementTimeoutUntilTankCorrection + " ";
      local1 += "tankState = " + this.tankState + " ";
      local1 += "team = " + this.team + " ";
      return local1 + "]";
    }
  }
}
