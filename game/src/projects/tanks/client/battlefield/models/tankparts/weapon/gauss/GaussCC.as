package projects.tanks.client.battlefield.models.tankparts.weapon.gauss {
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;

  public class GaussCC {
    private var _aimedShotImpact:Number;
    private var _aimedShotKickback:Number;
    private var _aimingGracePeriod:int;
    private var _aimingTime:int;
    private var _powerShotReloadDurationMs:int;
    private var _primaryShellRadius:Number;
    private var _primaryShellSpeed:Number;
    private var _secondarySplashParams:SplashCC;
    private var _shotRange:Number;

    public function GaussCC(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:Number = 0, param7:Number = 0, param8:SplashCC = null, param9:Number = 0) {
      super();
      this._aimedShotImpact = param1;
      this._aimedShotKickback = param2;
      this._aimingGracePeriod = param3;
      this._aimingTime = param4;
      this._powerShotReloadDurationMs = param5;
      this._primaryShellRadius = param6;
      this._primaryShellSpeed = param7;
      this._secondarySplashParams = param8;
      this._shotRange = param9;
    }

    public function get aimedShotImpact() : Number {
      return this._aimedShotImpact;
    }

    public function set aimedShotImpact(param1:Number) : void {
      this._aimedShotImpact = param1;
    }

    public function get aimedShotKickback() : Number {
      return this._aimedShotKickback;
    }

    public function set aimedShotKickback(param1:Number) : void {
      this._aimedShotKickback = param1;
    }

    public function get aimingGracePeriod() : int {
      return this._aimingGracePeriod;
    }

    public function set aimingGracePeriod(param1:int) : void {
      this._aimingGracePeriod = param1;
    }

    public function get aimingTime() : int {
      return this._aimingTime;
    }

    public function set aimingTime(param1:int) : void {
      this._aimingTime = param1;
    }

    public function get powerShotReloadDurationMs() : int {
      return this._powerShotReloadDurationMs;
    }

    public function set powerShotReloadDurationMs(param1:int) : void {
      this._powerShotReloadDurationMs = param1;
    }

    public function get primaryShellRadius() : Number {
      return this._primaryShellRadius;
    }

    public function set primaryShellRadius(param1:Number) : void {
      this._primaryShellRadius = param1;
    }

    public function get primaryShellSpeed() : Number {
      return this._primaryShellSpeed;
    }

    public function set primaryShellSpeed(param1:Number) : void {
      this._primaryShellSpeed = param1;
    }

    public function get secondarySplashParams() : SplashCC {
      return this._secondarySplashParams;
    }

    public function set secondarySplashParams(param1:SplashCC) : void {
      this._secondarySplashParams = param1;
    }

    public function get shotRange() : Number {
      return this._shotRange;
    }

    public function set shotRange(param1:Number) : void {
      this._shotRange = param1;
    }

    public function toString() : String {
      var local1:String = "GaussCC [";
      local1 += "aimedShotImpact = " + this.aimedShotImpact + " ";
      local1 += "aimedShotKickback = " + this.aimedShotKickback + " ";
      local1 += "aimingGracePeriod = " + this.aimingGracePeriod + " ";
      local1 += "aimingTime = " + this.aimingTime + " ";
      local1 += "powerShotReloadDurationMs = " + this.powerShotReloadDurationMs + " ";
      local1 += "primaryShellRadius = " + this.primaryShellRadius + " ";
      local1 += "primaryShellSpeed = " + this.primaryShellSpeed + " ";
      local1 += "secondarySplashParams = " + this.secondarySplashParams + " ";
      local1 += "shotRange = " + this.shotRange + " ";
      return local1 + "]";
    }
  }
}
