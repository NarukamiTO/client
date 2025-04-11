package projects.tanks.client.battlefield.models.tankparts.weapon.gauss.sfx {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class GaussSFXCC {
    private var _antennaDownSound:SoundResource;
    private var _antennaUpSound:SoundResource;
    private var _electroTexture:TextureResource;
    private var _explosionElectroTexture:MultiframeTextureResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _fireTexture:TextureResource;
    private var _flameTexture:TextureResource;
    private var _hitMarkerTexture:TextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _lightningTexture:TextureResource;
    private var _powerShotFarSound1:SoundResource;
    private var _powerShotFarSound2:SoundResource;
    private var _powerShotFarSound3:SoundResource;
    private var _primaryHitSound:SoundResource;
    private var _primaryShellFlightSound:SoundResource;
    private var _primaryShotSound:SoundResource;
    private var _secondaryHitSound:SoundResource;
    private var _secondaryShotSound:SoundResource;
    private var _shell:Tanks3DSResource;
    private var _shellTexture:TextureResource;
    private var _smokeTexture:TextureResource;
    private var _startAimingSound:SoundResource;
    private var _targetLockSound:SoundResource;
    private var _targetLostSound:SoundResource;
    private var _tracerTexture:TextureResource;
    private var _trailTexture:TextureResource;

    public function GaussSFXCC(param1:SoundResource = null, param2:SoundResource = null, param3:TextureResource = null, param4:MultiframeTextureResource = null, param5:MultiframeTextureResource = null, param6:TextureResource = null, param7:TextureResource = null, param8:TextureResource = null, param9:LightingSFXEntity = null, param10:TextureResource = null, param11:SoundResource = null, param12:SoundResource = null, param13:SoundResource = null, param14:SoundResource = null, param15:SoundResource = null, param16:SoundResource = null, param17:SoundResource = null, param18:SoundResource = null, param19:Tanks3DSResource = null, param20:TextureResource = null, param21:TextureResource = null, param22:SoundResource = null, param23:SoundResource = null, param24:SoundResource = null, param25:TextureResource = null, param26:TextureResource = null) {
      super();
      this._antennaDownSound = param1;
      this._antennaUpSound = param2;
      this._electroTexture = param3;
      this._explosionElectroTexture = param4;
      this._explosionTexture = param5;
      this._fireTexture = param6;
      this._flameTexture = param7;
      this._hitMarkerTexture = param8;
      this._lightingSFXEntity = param9;
      this._lightningTexture = param10;
      this._powerShotFarSound1 = param11;
      this._powerShotFarSound2 = param12;
      this._powerShotFarSound3 = param13;
      this._primaryHitSound = param14;
      this._primaryShellFlightSound = param15;
      this._primaryShotSound = param16;
      this._secondaryHitSound = param17;
      this._secondaryShotSound = param18;
      this._shell = param19;
      this._shellTexture = param20;
      this._smokeTexture = param21;
      this._startAimingSound = param22;
      this._targetLockSound = param23;
      this._targetLostSound = param24;
      this._tracerTexture = param25;
      this._trailTexture = param26;
    }

    public function get antennaDownSound() : SoundResource {
      return this._antennaDownSound;
    }

    public function set antennaDownSound(param1:SoundResource) : void {
      this._antennaDownSound = param1;
    }

    public function get antennaUpSound() : SoundResource {
      return this._antennaUpSound;
    }

    public function set antennaUpSound(param1:SoundResource) : void {
      this._antennaUpSound = param1;
    }

    public function get electroTexture() : TextureResource {
      return this._electroTexture;
    }

    public function set electroTexture(param1:TextureResource) : void {
      this._electroTexture = param1;
    }

    public function get explosionElectroTexture() : MultiframeTextureResource {
      return this._explosionElectroTexture;
    }

    public function set explosionElectroTexture(param1:MultiframeTextureResource) : void {
      this._explosionElectroTexture = param1;
    }

    public function get explosionTexture() : MultiframeTextureResource {
      return this._explosionTexture;
    }

    public function set explosionTexture(param1:MultiframeTextureResource) : void {
      this._explosionTexture = param1;
    }

    public function get fireTexture() : TextureResource {
      return this._fireTexture;
    }

    public function set fireTexture(param1:TextureResource) : void {
      this._fireTexture = param1;
    }

    public function get flameTexture() : TextureResource {
      return this._flameTexture;
    }

    public function set flameTexture(param1:TextureResource) : void {
      this._flameTexture = param1;
    }

    public function get hitMarkerTexture() : TextureResource {
      return this._hitMarkerTexture;
    }

    public function set hitMarkerTexture(param1:TextureResource) : void {
      this._hitMarkerTexture = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get lightningTexture() : TextureResource {
      return this._lightningTexture;
    }

    public function set lightningTexture(param1:TextureResource) : void {
      this._lightningTexture = param1;
    }

    public function get powerShotFarSound1() : SoundResource {
      return this._powerShotFarSound1;
    }

    public function set powerShotFarSound1(param1:SoundResource) : void {
      this._powerShotFarSound1 = param1;
    }

    public function get powerShotFarSound2() : SoundResource {
      return this._powerShotFarSound2;
    }

    public function set powerShotFarSound2(param1:SoundResource) : void {
      this._powerShotFarSound2 = param1;
    }

    public function get powerShotFarSound3() : SoundResource {
      return this._powerShotFarSound3;
    }

    public function set powerShotFarSound3(param1:SoundResource) : void {
      this._powerShotFarSound3 = param1;
    }

    public function get primaryHitSound() : SoundResource {
      return this._primaryHitSound;
    }

    public function set primaryHitSound(param1:SoundResource) : void {
      this._primaryHitSound = param1;
    }

    public function get primaryShellFlightSound() : SoundResource {
      return this._primaryShellFlightSound;
    }

    public function set primaryShellFlightSound(param1:SoundResource) : void {
      this._primaryShellFlightSound = param1;
    }

    public function get primaryShotSound() : SoundResource {
      return this._primaryShotSound;
    }

    public function set primaryShotSound(param1:SoundResource) : void {
      this._primaryShotSound = param1;
    }

    public function get secondaryHitSound() : SoundResource {
      return this._secondaryHitSound;
    }

    public function set secondaryHitSound(param1:SoundResource) : void {
      this._secondaryHitSound = param1;
    }

    public function get secondaryShotSound() : SoundResource {
      return this._secondaryShotSound;
    }

    public function set secondaryShotSound(param1:SoundResource) : void {
      this._secondaryShotSound = param1;
    }

    public function get shell() : Tanks3DSResource {
      return this._shell;
    }

    public function set shell(param1:Tanks3DSResource) : void {
      this._shell = param1;
    }

    public function get shellTexture() : TextureResource {
      return this._shellTexture;
    }

    public function set shellTexture(param1:TextureResource) : void {
      this._shellTexture = param1;
    }

    public function get smokeTexture() : TextureResource {
      return this._smokeTexture;
    }

    public function set smokeTexture(param1:TextureResource) : void {
      this._smokeTexture = param1;
    }

    public function get startAimingSound() : SoundResource {
      return this._startAimingSound;
    }

    public function set startAimingSound(param1:SoundResource) : void {
      this._startAimingSound = param1;
    }

    public function get targetLockSound() : SoundResource {
      return this._targetLockSound;
    }

    public function set targetLockSound(param1:SoundResource) : void {
      this._targetLockSound = param1;
    }

    public function get targetLostSound() : SoundResource {
      return this._targetLostSound;
    }

    public function set targetLostSound(param1:SoundResource) : void {
      this._targetLostSound = param1;
    }

    public function get tracerTexture() : TextureResource {
      return this._tracerTexture;
    }

    public function set tracerTexture(param1:TextureResource) : void {
      this._tracerTexture = param1;
    }

    public function get trailTexture() : TextureResource {
      return this._trailTexture;
    }

    public function set trailTexture(param1:TextureResource) : void {
      this._trailTexture = param1;
    }

    public function toString() : String {
      var local1:String = "GaussSFXCC [";
      local1 += "antennaDownSound = " + this.antennaDownSound + " ";
      local1 += "antennaUpSound = " + this.antennaUpSound + " ";
      local1 += "electroTexture = " + this.electroTexture + " ";
      local1 += "explosionElectroTexture = " + this.explosionElectroTexture + " ";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "fireTexture = " + this.fireTexture + " ";
      local1 += "flameTexture = " + this.flameTexture + " ";
      local1 += "hitMarkerTexture = " + this.hitMarkerTexture + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "lightningTexture = " + this.lightningTexture + " ";
      local1 += "powerShotFarSound1 = " + this.powerShotFarSound1 + " ";
      local1 += "powerShotFarSound2 = " + this.powerShotFarSound2 + " ";
      local1 += "powerShotFarSound3 = " + this.powerShotFarSound3 + " ";
      local1 += "primaryHitSound = " + this.primaryHitSound + " ";
      local1 += "primaryShellFlightSound = " + this.primaryShellFlightSound + " ";
      local1 += "primaryShotSound = " + this.primaryShotSound + " ";
      local1 += "secondaryHitSound = " + this.secondaryHitSound + " ";
      local1 += "secondaryShotSound = " + this.secondaryShotSound + " ";
      local1 += "shell = " + this.shell + " ";
      local1 += "shellTexture = " + this.shellTexture + " ";
      local1 += "smokeTexture = " + this.smokeTexture + " ";
      local1 += "startAimingSound = " + this.startAimingSound + " ";
      local1 += "targetLockSound = " + this.targetLockSound + " ";
      local1 += "targetLostSound = " + this.targetLostSound + " ";
      local1 += "tracerTexture = " + this.tracerTexture + " ";
      local1 += "trailTexture = " + this.trailTexture + " ";
      return local1 + "]";
    }
  }
}
