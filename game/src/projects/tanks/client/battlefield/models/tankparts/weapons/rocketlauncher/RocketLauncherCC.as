package projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher {
  public class RocketLauncherCC {
    private var _angularVelocity:Number;
    private var _boostPhaseDuration:int;
    private var _maxSpeed:Number;
    private var _minSpeed:Number;
    private var _salvoAimingGracePeriod:int;
    private var _salvoAimingTime:int;
    private var _salvoReloadTime:int;
    private var _salvoSize:int;
    private var _shellRadius:Number;
    private var _shotRange:Number;
    private var _timeBetweenShotsOfSalvo:int;

    public function RocketLauncherCC(param1:Number = 0, param2:int = 0, param3:Number = 0, param4:Number = 0, param5:int = 0, param6:int = 0, param7:int = 0, param8:int = 0, param9:Number = 0, param10:Number = 0, param11:int = 0) {
      super();
      this._angularVelocity = param1;
      this._boostPhaseDuration = param2;
      this._maxSpeed = param3;
      this._minSpeed = param4;
      this._salvoAimingGracePeriod = param5;
      this._salvoAimingTime = param6;
      this._salvoReloadTime = param7;
      this._salvoSize = param8;
      this._shellRadius = param9;
      this._shotRange = param10;
      this._timeBetweenShotsOfSalvo = param11;
    }

    public function get angularVelocity() : Number {
      return this._angularVelocity;
    }

    public function set angularVelocity(param1:Number) : void {
      this._angularVelocity = param1;
    }

    public function get boostPhaseDuration() : int {
      return this._boostPhaseDuration;
    }

    public function set boostPhaseDuration(param1:int) : void {
      this._boostPhaseDuration = param1;
    }

    public function get maxSpeed() : Number {
      return this._maxSpeed;
    }

    public function set maxSpeed(param1:Number) : void {
      this._maxSpeed = param1;
    }

    public function get minSpeed() : Number {
      return this._minSpeed;
    }

    public function set minSpeed(param1:Number) : void {
      this._minSpeed = param1;
    }

    public function get salvoAimingGracePeriod() : int {
      return this._salvoAimingGracePeriod;
    }

    public function set salvoAimingGracePeriod(param1:int) : void {
      this._salvoAimingGracePeriod = param1;
    }

    public function get salvoAimingTime() : int {
      return this._salvoAimingTime;
    }

    public function set salvoAimingTime(param1:int) : void {
      this._salvoAimingTime = param1;
    }

    public function get salvoReloadTime() : int {
      return this._salvoReloadTime;
    }

    public function set salvoReloadTime(param1:int) : void {
      this._salvoReloadTime = param1;
    }

    public function get salvoSize() : int {
      return this._salvoSize;
    }

    public function set salvoSize(param1:int) : void {
      this._salvoSize = param1;
    }

    public function get shellRadius() : Number {
      return this._shellRadius;
    }

    public function set shellRadius(param1:Number) : void {
      this._shellRadius = param1;
    }

    public function get shotRange() : Number {
      return this._shotRange;
    }

    public function set shotRange(param1:Number) : void {
      this._shotRange = param1;
    }

    public function get timeBetweenShotsOfSalvo() : int {
      return this._timeBetweenShotsOfSalvo;
    }

    public function set timeBetweenShotsOfSalvo(param1:int) : void {
      this._timeBetweenShotsOfSalvo = param1;
    }

    public function toString() : String {
      var local1:String = "RocketLauncherCC [";
      local1 += "angularVelocity = " + this.angularVelocity + " ";
      local1 += "boostPhaseDuration = " + this.boostPhaseDuration + " ";
      local1 += "maxSpeed = " + this.maxSpeed + " ";
      local1 += "minSpeed = " + this.minSpeed + " ";
      local1 += "salvoAimingGracePeriod = " + this.salvoAimingGracePeriod + " ";
      local1 += "salvoAimingTime = " + this.salvoAimingTime + " ";
      local1 += "salvoReloadTime = " + this.salvoReloadTime + " ";
      local1 += "salvoSize = " + this.salvoSize + " ";
      local1 += "shellRadius = " + this.shellRadius + " ";
      local1 += "shotRange = " + this.shotRange + " ";
      local1 += "timeBetweenShotsOfSalvo = " + this.timeBetweenShotsOfSalvo + " ";
      return local1 + "]";
    }
  }
}
