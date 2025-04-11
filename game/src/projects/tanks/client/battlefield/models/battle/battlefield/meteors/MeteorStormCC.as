package projects.tanks.client.battlefield.models.battle.battlefield.meteors {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class MeteorStormCC {
    private var _bigSplashRadius:Number;
    private var _craterDecal:TextureResource;
    private var _currentMeteors:Vector.<MeteorDescriptor>;
    private var _impactSoundTimelabel:int;
    private var _meteorArrivingSound:SoundResource;
    private var _meteorDistantSound:SoundResource;
    private var _meteorFlyDistance:Number;
    private var _meteorModel:Tanks3DSResource;
    private var _meteorSpeed:Number;
    private var _nuclearBangFlame:TextureResource;
    private var _nuclearBangLight:TextureResource;
    private var _nuclearBangSmoke:TextureResource;
    private var _nuclearBangSound:SoundResource;
    private var _nuclearBangWave:TextureResource;
    private var _preferredFallAngle:Number;
    private var _smallSplashRadius:Number;
    private var _splashDamageImpact:Number;
    private var _splashDamageMinPercent:Number;
    private var _tailFlame:TextureResource;
    private var _tailLight:Vector.<LightEffectItem>;
    private var _tailSmoke:TextureResource;

    public function MeteorStormCC(param1:Number = 0, param2:TextureResource = null, param3:Vector.<MeteorDescriptor> = null, param4:int = 0, param5:SoundResource = null, param6:SoundResource = null, param7:Number = 0, param8:Tanks3DSResource = null, param9:Number = 0, param10:TextureResource = null, param11:TextureResource = null, param12:TextureResource = null, param13:SoundResource = null, param14:TextureResource = null, param15:Number = 0, param16:Number = 0, param17:Number = 0, param18:Number = 0, param19:TextureResource = null, param20:Vector.<LightEffectItem> = null, param21:TextureResource = null) {
      super();
      this._bigSplashRadius = param1;
      this._craterDecal = param2;
      this._currentMeteors = param3;
      this._impactSoundTimelabel = param4;
      this._meteorArrivingSound = param5;
      this._meteorDistantSound = param6;
      this._meteorFlyDistance = param7;
      this._meteorModel = param8;
      this._meteorSpeed = param9;
      this._nuclearBangFlame = param10;
      this._nuclearBangLight = param11;
      this._nuclearBangSmoke = param12;
      this._nuclearBangSound = param13;
      this._nuclearBangWave = param14;
      this._preferredFallAngle = param15;
      this._smallSplashRadius = param16;
      this._splashDamageImpact = param17;
      this._splashDamageMinPercent = param18;
      this._tailFlame = param19;
      this._tailLight = param20;
      this._tailSmoke = param21;
    }

    public function get bigSplashRadius() : Number {
      return this._bigSplashRadius;
    }

    public function set bigSplashRadius(param1:Number) : void {
      this._bigSplashRadius = param1;
    }

    public function get craterDecal() : TextureResource {
      return this._craterDecal;
    }

    public function set craterDecal(param1:TextureResource) : void {
      this._craterDecal = param1;
    }

    public function get currentMeteors() : Vector.<MeteorDescriptor> {
      return this._currentMeteors;
    }

    public function set currentMeteors(param1:Vector.<MeteorDescriptor>) : void {
      this._currentMeteors = param1;
    }

    public function get impactSoundTimelabel() : int {
      return this._impactSoundTimelabel;
    }

    public function set impactSoundTimelabel(param1:int) : void {
      this._impactSoundTimelabel = param1;
    }

    public function get meteorArrivingSound() : SoundResource {
      return this._meteorArrivingSound;
    }

    public function set meteorArrivingSound(param1:SoundResource) : void {
      this._meteorArrivingSound = param1;
    }

    public function get meteorDistantSound() : SoundResource {
      return this._meteorDistantSound;
    }

    public function set meteorDistantSound(param1:SoundResource) : void {
      this._meteorDistantSound = param1;
    }

    public function get meteorFlyDistance() : Number {
      return this._meteorFlyDistance;
    }

    public function set meteorFlyDistance(param1:Number) : void {
      this._meteorFlyDistance = param1;
    }

    public function get meteorModel() : Tanks3DSResource {
      return this._meteorModel;
    }

    public function set meteorModel(param1:Tanks3DSResource) : void {
      this._meteorModel = param1;
    }

    public function get meteorSpeed() : Number {
      return this._meteorSpeed;
    }

    public function set meteorSpeed(param1:Number) : void {
      this._meteorSpeed = param1;
    }

    public function get nuclearBangFlame() : TextureResource {
      return this._nuclearBangFlame;
    }

    public function set nuclearBangFlame(param1:TextureResource) : void {
      this._nuclearBangFlame = param1;
    }

    public function get nuclearBangLight() : TextureResource {
      return this._nuclearBangLight;
    }

    public function set nuclearBangLight(param1:TextureResource) : void {
      this._nuclearBangLight = param1;
    }

    public function get nuclearBangSmoke() : TextureResource {
      return this._nuclearBangSmoke;
    }

    public function set nuclearBangSmoke(param1:TextureResource) : void {
      this._nuclearBangSmoke = param1;
    }

    public function get nuclearBangSound() : SoundResource {
      return this._nuclearBangSound;
    }

    public function set nuclearBangSound(param1:SoundResource) : void {
      this._nuclearBangSound = param1;
    }

    public function get nuclearBangWave() : TextureResource {
      return this._nuclearBangWave;
    }

    public function set nuclearBangWave(param1:TextureResource) : void {
      this._nuclearBangWave = param1;
    }

    public function get preferredFallAngle() : Number {
      return this._preferredFallAngle;
    }

    public function set preferredFallAngle(param1:Number) : void {
      this._preferredFallAngle = param1;
    }

    public function get smallSplashRadius() : Number {
      return this._smallSplashRadius;
    }

    public function set smallSplashRadius(param1:Number) : void {
      this._smallSplashRadius = param1;
    }

    public function get splashDamageImpact() : Number {
      return this._splashDamageImpact;
    }

    public function set splashDamageImpact(param1:Number) : void {
      this._splashDamageImpact = param1;
    }

    public function get splashDamageMinPercent() : Number {
      return this._splashDamageMinPercent;
    }

    public function set splashDamageMinPercent(param1:Number) : void {
      this._splashDamageMinPercent = param1;
    }

    public function get tailFlame() : TextureResource {
      return this._tailFlame;
    }

    public function set tailFlame(param1:TextureResource) : void {
      this._tailFlame = param1;
    }

    public function get tailLight() : Vector.<LightEffectItem> {
      return this._tailLight;
    }

    public function set tailLight(param1:Vector.<LightEffectItem>) : void {
      this._tailLight = param1;
    }

    public function get tailSmoke() : TextureResource {
      return this._tailSmoke;
    }

    public function set tailSmoke(param1:TextureResource) : void {
      this._tailSmoke = param1;
    }

    public function toString() : String {
      var local1:String = "MeteorStormCC [";
      local1 += "bigSplashRadius = " + this.bigSplashRadius + " ";
      local1 += "craterDecal = " + this.craterDecal + " ";
      local1 += "currentMeteors = " + this.currentMeteors + " ";
      local1 += "impactSoundTimelabel = " + this.impactSoundTimelabel + " ";
      local1 += "meteorArrivingSound = " + this.meteorArrivingSound + " ";
      local1 += "meteorDistantSound = " + this.meteorDistantSound + " ";
      local1 += "meteorFlyDistance = " + this.meteorFlyDistance + " ";
      local1 += "meteorModel = " + this.meteorModel + " ";
      local1 += "meteorSpeed = " + this.meteorSpeed + " ";
      local1 += "nuclearBangFlame = " + this.nuclearBangFlame + " ";
      local1 += "nuclearBangLight = " + this.nuclearBangLight + " ";
      local1 += "nuclearBangSmoke = " + this.nuclearBangSmoke + " ";
      local1 += "nuclearBangSound = " + this.nuclearBangSound + " ";
      local1 += "nuclearBangWave = " + this.nuclearBangWave + " ";
      local1 += "preferredFallAngle = " + this.preferredFallAngle + " ";
      local1 += "smallSplashRadius = " + this.smallSplashRadius + " ";
      local1 += "splashDamageImpact = " + this.splashDamageImpact + " ";
      local1 += "splashDamageMinPercent = " + this.splashDamageMinPercent + " ";
      local1 += "tailFlame = " + this.tailFlame + " ";
      local1 += "tailLight = " + this.tailLight + " ";
      local1 += "tailSmoke = " + this.tailSmoke + " ";
      return local1 + "]";
    }
  }
}
