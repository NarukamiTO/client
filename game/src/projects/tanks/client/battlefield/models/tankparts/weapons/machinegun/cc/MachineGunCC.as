package projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc {
  public class MachineGunCC {
    private var _spinDownTime:int;
    private var _spinUpTime:int;
    private var _started:Boolean;
    private var _state:Number;
    private var _temperatureHittingTime:int;
    private var _weaponTurnDecelerationCoeff:Number;

    public function MachineGunCC(param1:int = 0, param2:int = 0, param3:Boolean = false, param4:Number = 0, param5:int = 0, param6:Number = 0) {
      super();
      this._spinDownTime = param1;
      this._spinUpTime = param2;
      this._started = param3;
      this._state = param4;
      this._temperatureHittingTime = param5;
      this._weaponTurnDecelerationCoeff = param6;
    }

    public function get spinDownTime() : int {
      return this._spinDownTime;
    }

    public function set spinDownTime(param1:int) : void {
      this._spinDownTime = param1;
    }

    public function get spinUpTime() : int {
      return this._spinUpTime;
    }

    public function set spinUpTime(param1:int) : void {
      this._spinUpTime = param1;
    }

    public function get started() : Boolean {
      return this._started;
    }

    public function set started(param1:Boolean) : void {
      this._started = param1;
    }

    public function get state() : Number {
      return this._state;
    }

    public function set state(param1:Number) : void {
      this._state = param1;
    }

    public function get temperatureHittingTime() : int {
      return this._temperatureHittingTime;
    }

    public function set temperatureHittingTime(param1:int) : void {
      this._temperatureHittingTime = param1;
    }

    public function get weaponTurnDecelerationCoeff() : Number {
      return this._weaponTurnDecelerationCoeff;
    }

    public function set weaponTurnDecelerationCoeff(param1:Number) : void {
      this._weaponTurnDecelerationCoeff = param1;
    }

    public function toString() : String {
      var local1:String = "MachineGunCC [";
      local1 += "spinDownTime = " + this.spinDownTime + " ";
      local1 += "spinUpTime = " + this.spinUpTime + " ";
      local1 += "started = " + this.started + " ";
      local1 += "state = " + this.state + " ";
      local1 += "temperatureHittingTime = " + this.temperatureHittingTime + " ";
      local1 += "weaponTurnDecelerationCoeff = " + this.weaponTurnDecelerationCoeff + " ";
      return local1 + "]";
    }
  }
}
