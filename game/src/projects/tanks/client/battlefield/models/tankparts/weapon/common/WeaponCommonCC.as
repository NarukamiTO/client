package projects.tanks.client.battlefield.models.tankparts.weapon.common {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class WeaponCommonCC {
    private var _buffShotCooldownMs:int;
    private var _buffed:Boolean;
    private var _highlightingDistance:Number;
    private var _impactForce:Number;
    private var _kickback:Number;
    private var _turretRotationAcceleration:Number;
    private var _turretRotationSound:SoundResource;
    private var _turretRotationSpeed:Number;

    public function WeaponCommonCC(param1:int = 0, param2:Boolean = false, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:SoundResource = null, param8:Number = 0) {
      super();
      this._buffShotCooldownMs = param1;
      this._buffed = param2;
      this._highlightingDistance = param3;
      this._impactForce = param4;
      this._kickback = param5;
      this._turretRotationAcceleration = param6;
      this._turretRotationSound = param7;
      this._turretRotationSpeed = param8;
    }

    public function get buffShotCooldownMs() : int {
      return this._buffShotCooldownMs;
    }

    public function set buffShotCooldownMs(param1:int) : void {
      this._buffShotCooldownMs = param1;
    }

    public function get buffed() : Boolean {
      return this._buffed;
    }

    public function set buffed(param1:Boolean) : void {
      this._buffed = param1;
    }

    public function get highlightingDistance() : Number {
      return this._highlightingDistance;
    }

    public function set highlightingDistance(param1:Number) : void {
      this._highlightingDistance = param1;
    }

    public function get impactForce() : Number {
      return this._impactForce;
    }

    public function set impactForce(param1:Number) : void {
      this._impactForce = param1;
    }

    public function get kickback() : Number {
      return this._kickback;
    }

    public function set kickback(param1:Number) : void {
      this._kickback = param1;
    }

    public function get turretRotationAcceleration() : Number {
      return this._turretRotationAcceleration;
    }

    public function set turretRotationAcceleration(param1:Number) : void {
      this._turretRotationAcceleration = param1;
    }

    public function get turretRotationSound() : SoundResource {
      return this._turretRotationSound;
    }

    public function set turretRotationSound(param1:SoundResource) : void {
      this._turretRotationSound = param1;
    }

    public function get turretRotationSpeed() : Number {
      return this._turretRotationSpeed;
    }

    public function set turretRotationSpeed(param1:Number) : void {
      this._turretRotationSpeed = param1;
    }

    public function toString() : String {
      var local1:String = "WeaponCommonCC [";
      local1 += "buffShotCooldownMs = " + this.buffShotCooldownMs + " ";
      local1 += "buffed = " + this.buffed + " ";
      local1 += "highlightingDistance = " + this.highlightingDistance + " ";
      local1 += "impactForce = " + this.impactForce + " ";
      local1 += "kickback = " + this.kickback + " ";
      local1 += "turretRotationAcceleration = " + this.turretRotationAcceleration + " ";
      local1 += "turretRotationSound = " + this.turretRotationSound + " ";
      local1 += "turretRotationSpeed = " + this.turretRotationSpeed + " ";
      return local1 + "]";
    }
  }
}
