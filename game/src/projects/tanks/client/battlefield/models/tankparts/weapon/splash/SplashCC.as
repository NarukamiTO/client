package projects.tanks.client.battlefield.models.tankparts.weapon.splash {
  public class SplashCC {
    private var _impactForce:Number;
    private var _minSplashDamagePercent:Number;
    private var _radiusOfMaxSplashDamage:Number;
    private var _splashDamageRadius:Number;

    public function SplashCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) {
      super();
      this._impactForce = param1;
      this._minSplashDamagePercent = param2;
      this._radiusOfMaxSplashDamage = param3;
      this._splashDamageRadius = param4;
    }

    public function get impactForce() : Number {
      return this._impactForce;
    }

    public function set impactForce(param1:Number) : void {
      this._impactForce = param1;
    }

    public function get minSplashDamagePercent() : Number {
      return this._minSplashDamagePercent;
    }

    public function set minSplashDamagePercent(param1:Number) : void {
      this._minSplashDamagePercent = param1;
    }

    public function get radiusOfMaxSplashDamage() : Number {
      return this._radiusOfMaxSplashDamage;
    }

    public function set radiusOfMaxSplashDamage(param1:Number) : void {
      this._radiusOfMaxSplashDamage = param1;
    }

    public function get splashDamageRadius() : Number {
      return this._splashDamageRadius;
    }

    public function set splashDamageRadius(param1:Number) : void {
      this._splashDamageRadius = param1;
    }

    public function toString() : String {
      var local1:String = "SplashCC [";
      local1 += "impactForce = " + this.impactForce + " ";
      local1 += "minSplashDamagePercent = " + this.minSplashDamagePercent + " ";
      local1 += "radiusOfMaxSplashDamage = " + this.radiusOfMaxSplashDamage + " ";
      local1 += "splashDamageRadius = " + this.splashDamageRadius + " ";
      return local1 + "]";
    }
  }
}
