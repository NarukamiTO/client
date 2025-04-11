package projects.tanks.client.battlefield.models.tankparts.weapon.shaft {
  import platform.client.fp10.core.resource.types.TextureResource;

  public class ShaftCC {
    private var _afterShotPause:int;
    private var _aimingImpact:Number;
    private var _chargeRate:Number;
    private var _dischargeRate:Number;
    private var _fastShotEnergy:Number;
    private var _horizontalTargetingSpeed:Number;
    private var _initialFOV:Number;
    private var _maxEnergy:Number;
    private var _minAimedShotEnergy:Number;
    private var _minimumFOV:Number;
    private var _reticleImage:TextureResource;
    private var _rotationCoeffKmin:Number;
    private var _rotationCoeffT1:Number;
    private var _rotationCoeffT2:Number;
    private var _shrubsHidingRadiusMax:Number;
    private var _shrubsHidingRadiusMin:Number;
    private var _targetingAcceleration:Number;
    private var _targetingTransitionTime:int;
    private var _verticalTargetingSpeed:Number;

    public function ShaftCC(param1:int = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:TextureResource = null, param12:Number = 0, param13:Number = 0, param14:Number = 0, param15:Number = 0, param16:Number = 0, param17:Number = 0, param18:int = 0, param19:Number = 0) {
      super();
      this._afterShotPause = param1;
      this._aimingImpact = param2;
      this._chargeRate = param3;
      this._dischargeRate = param4;
      this._fastShotEnergy = param5;
      this._horizontalTargetingSpeed = param6;
      this._initialFOV = param7;
      this._maxEnergy = param8;
      this._minAimedShotEnergy = param9;
      this._minimumFOV = param10;
      this._reticleImage = param11;
      this._rotationCoeffKmin = param12;
      this._rotationCoeffT1 = param13;
      this._rotationCoeffT2 = param14;
      this._shrubsHidingRadiusMax = param15;
      this._shrubsHidingRadiusMin = param16;
      this._targetingAcceleration = param17;
      this._targetingTransitionTime = param18;
      this._verticalTargetingSpeed = param19;
    }

    public function get afterShotPause() : int {
      return this._afterShotPause;
    }

    public function set afterShotPause(param1:int) : void {
      this._afterShotPause = param1;
    }

    public function get aimingImpact() : Number {
      return this._aimingImpact;
    }

    public function set aimingImpact(param1:Number) : void {
      this._aimingImpact = param1;
    }

    public function get chargeRate() : Number {
      return this._chargeRate;
    }

    public function set chargeRate(param1:Number) : void {
      this._chargeRate = param1;
    }

    public function get dischargeRate() : Number {
      return this._dischargeRate;
    }

    public function set dischargeRate(param1:Number) : void {
      this._dischargeRate = param1;
    }

    public function get fastShotEnergy() : Number {
      return this._fastShotEnergy;
    }

    public function set fastShotEnergy(param1:Number) : void {
      this._fastShotEnergy = param1;
    }

    public function get horizontalTargetingSpeed() : Number {
      return this._horizontalTargetingSpeed;
    }

    public function set horizontalTargetingSpeed(param1:Number) : void {
      this._horizontalTargetingSpeed = param1;
    }

    public function get initialFOV() : Number {
      return this._initialFOV;
    }

    public function set initialFOV(param1:Number) : void {
      this._initialFOV = param1;
    }

    public function get maxEnergy() : Number {
      return this._maxEnergy;
    }

    public function set maxEnergy(param1:Number) : void {
      this._maxEnergy = param1;
    }

    public function get minAimedShotEnergy() : Number {
      return this._minAimedShotEnergy;
    }

    public function set minAimedShotEnergy(param1:Number) : void {
      this._minAimedShotEnergy = param1;
    }

    public function get minimumFOV() : Number {
      return this._minimumFOV;
    }

    public function set minimumFOV(param1:Number) : void {
      this._minimumFOV = param1;
    }

    public function get reticleImage() : TextureResource {
      return this._reticleImage;
    }

    public function set reticleImage(param1:TextureResource) : void {
      this._reticleImage = param1;
    }

    public function get rotationCoeffKmin() : Number {
      return this._rotationCoeffKmin;
    }

    public function set rotationCoeffKmin(param1:Number) : void {
      this._rotationCoeffKmin = param1;
    }

    public function get rotationCoeffT1() : Number {
      return this._rotationCoeffT1;
    }

    public function set rotationCoeffT1(param1:Number) : void {
      this._rotationCoeffT1 = param1;
    }

    public function get rotationCoeffT2() : Number {
      return this._rotationCoeffT2;
    }

    public function set rotationCoeffT2(param1:Number) : void {
      this._rotationCoeffT2 = param1;
    }

    public function get shrubsHidingRadiusMax() : Number {
      return this._shrubsHidingRadiusMax;
    }

    public function set shrubsHidingRadiusMax(param1:Number) : void {
      this._shrubsHidingRadiusMax = param1;
    }

    public function get shrubsHidingRadiusMin() : Number {
      return this._shrubsHidingRadiusMin;
    }

    public function set shrubsHidingRadiusMin(param1:Number) : void {
      this._shrubsHidingRadiusMin = param1;
    }

    public function get targetingAcceleration() : Number {
      return this._targetingAcceleration;
    }

    public function set targetingAcceleration(param1:Number) : void {
      this._targetingAcceleration = param1;
    }

    public function get targetingTransitionTime() : int {
      return this._targetingTransitionTime;
    }

    public function set targetingTransitionTime(param1:int) : void {
      this._targetingTransitionTime = param1;
    }

    public function get verticalTargetingSpeed() : Number {
      return this._verticalTargetingSpeed;
    }

    public function set verticalTargetingSpeed(param1:Number) : void {
      this._verticalTargetingSpeed = param1;
    }

    public function toString() : String {
      var local1:String = "ShaftCC [";
      local1 += "afterShotPause = " + this.afterShotPause + " ";
      local1 += "aimingImpact = " + this.aimingImpact + " ";
      local1 += "chargeRate = " + this.chargeRate + " ";
      local1 += "dischargeRate = " + this.dischargeRate + " ";
      local1 += "fastShotEnergy = " + this.fastShotEnergy + " ";
      local1 += "horizontalTargetingSpeed = " + this.horizontalTargetingSpeed + " ";
      local1 += "initialFOV = " + this.initialFOV + " ";
      local1 += "maxEnergy = " + this.maxEnergy + " ";
      local1 += "minAimedShotEnergy = " + this.minAimedShotEnergy + " ";
      local1 += "minimumFOV = " + this.minimumFOV + " ";
      local1 += "reticleImage = " + this.reticleImage + " ";
      local1 += "rotationCoeffKmin = " + this.rotationCoeffKmin + " ";
      local1 += "rotationCoeffT1 = " + this.rotationCoeffT1 + " ";
      local1 += "rotationCoeffT2 = " + this.rotationCoeffT2 + " ";
      local1 += "shrubsHidingRadiusMax = " + this.shrubsHidingRadiusMax + " ";
      local1 += "shrubsHidingRadiusMin = " + this.shrubsHidingRadiusMin + " ";
      local1 += "targetingAcceleration = " + this.targetingAcceleration + " ";
      local1 += "targetingTransitionTime = " + this.targetingTransitionTime + " ";
      local1 += "verticalTargetingSpeed = " + this.verticalTargetingSpeed + " ";
      return local1 + "]";
    }
  }
}
