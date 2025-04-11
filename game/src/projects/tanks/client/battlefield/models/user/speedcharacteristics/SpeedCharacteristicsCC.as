package projects.tanks.client.battlefield.models.user.speedcharacteristics {
  public class SpeedCharacteristicsCC {
    private var _baseAcceleration:Number;
    private var _baseSpeed:Number;
    private var _baseTurnSpeed:Number;
    private var _baseTurretRotationSpeed:Number;
    private var _currentAcceleration:Number;
    private var _currentSpeed:Number;
    private var _currentTurnSpeed:Number;
    private var _currentTurretRotationSpeed:Number;
    private var _reverseAcceleration:Number;
    private var _reverseTurnAcceleration:Number;
    private var _sideAcceleration:Number;
    private var _turnAcceleration:Number;
    private var _turnStabilizationAcceleration:Number;

    public function SpeedCharacteristicsCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0, param13:Number = 0) {
      super();
      this._baseAcceleration = param1;
      this._baseSpeed = param2;
      this._baseTurnSpeed = param3;
      this._baseTurretRotationSpeed = param4;
      this._currentAcceleration = param5;
      this._currentSpeed = param6;
      this._currentTurnSpeed = param7;
      this._currentTurretRotationSpeed = param8;
      this._reverseAcceleration = param9;
      this._reverseTurnAcceleration = param10;
      this._sideAcceleration = param11;
      this._turnAcceleration = param12;
      this._turnStabilizationAcceleration = param13;
    }

    public function get baseAcceleration() : Number {
      return this._baseAcceleration;
    }

    public function set baseAcceleration(param1:Number) : void {
      this._baseAcceleration = param1;
    }

    public function get baseSpeed() : Number {
      return this._baseSpeed;
    }

    public function set baseSpeed(param1:Number) : void {
      this._baseSpeed = param1;
    }

    public function get baseTurnSpeed() : Number {
      return this._baseTurnSpeed;
    }

    public function set baseTurnSpeed(param1:Number) : void {
      this._baseTurnSpeed = param1;
    }

    public function get baseTurretRotationSpeed() : Number {
      return this._baseTurretRotationSpeed;
    }

    public function set baseTurretRotationSpeed(param1:Number) : void {
      this._baseTurretRotationSpeed = param1;
    }

    public function get currentAcceleration() : Number {
      return this._currentAcceleration;
    }

    public function set currentAcceleration(param1:Number) : void {
      this._currentAcceleration = param1;
    }

    public function get currentSpeed() : Number {
      return this._currentSpeed;
    }

    public function set currentSpeed(param1:Number) : void {
      this._currentSpeed = param1;
    }

    public function get currentTurnSpeed() : Number {
      return this._currentTurnSpeed;
    }

    public function set currentTurnSpeed(param1:Number) : void {
      this._currentTurnSpeed = param1;
    }

    public function get currentTurretRotationSpeed() : Number {
      return this._currentTurretRotationSpeed;
    }

    public function set currentTurretRotationSpeed(param1:Number) : void {
      this._currentTurretRotationSpeed = param1;
    }

    public function get reverseAcceleration() : Number {
      return this._reverseAcceleration;
    }

    public function set reverseAcceleration(param1:Number) : void {
      this._reverseAcceleration = param1;
    }

    public function get reverseTurnAcceleration() : Number {
      return this._reverseTurnAcceleration;
    }

    public function set reverseTurnAcceleration(param1:Number) : void {
      this._reverseTurnAcceleration = param1;
    }

    public function get sideAcceleration() : Number {
      return this._sideAcceleration;
    }

    public function set sideAcceleration(param1:Number) : void {
      this._sideAcceleration = param1;
    }

    public function get turnAcceleration() : Number {
      return this._turnAcceleration;
    }

    public function set turnAcceleration(param1:Number) : void {
      this._turnAcceleration = param1;
    }

    public function get turnStabilizationAcceleration() : Number {
      return this._turnStabilizationAcceleration;
    }

    public function set turnStabilizationAcceleration(param1:Number) : void {
      this._turnStabilizationAcceleration = param1;
    }

    public function toString() : String {
      var local1:String = "SpeedCharacteristicsCC [";
      local1 += "baseAcceleration = " + this.baseAcceleration + " ";
      local1 += "baseSpeed = " + this.baseSpeed + " ";
      local1 += "baseTurnSpeed = " + this.baseTurnSpeed + " ";
      local1 += "baseTurretRotationSpeed = " + this.baseTurretRotationSpeed + " ";
      local1 += "currentAcceleration = " + this.currentAcceleration + " ";
      local1 += "currentSpeed = " + this.currentSpeed + " ";
      local1 += "currentTurnSpeed = " + this.currentTurnSpeed + " ";
      local1 += "currentTurretRotationSpeed = " + this.currentTurretRotationSpeed + " ";
      local1 += "reverseAcceleration = " + this.reverseAcceleration + " ";
      local1 += "reverseTurnAcceleration = " + this.reverseTurnAcceleration + " ";
      local1 += "sideAcceleration = " + this.sideAcceleration + " ";
      local1 += "turnAcceleration = " + this.turnAcceleration + " ";
      local1 += "turnStabilizationAcceleration = " + this.turnStabilizationAcceleration + " ";
      return local1 + "]";
    }
  }
}
