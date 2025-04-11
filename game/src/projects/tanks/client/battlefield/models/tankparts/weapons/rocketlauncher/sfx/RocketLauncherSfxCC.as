package projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class RocketLauncherSfxCC {
    private var _aimingCompleteSound:SoundResource;
    private var _aimingSound:SoundResource;
    private var _explosionMarkTexture:TextureResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _leftHitSounds:SoundResource;
    private var _leftShotSounds:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _rightHitSounds:SoundResource;
    private var _rightShotSounds:SoundResource;
    private var _rocketFlameTexture:TextureResource;
    private var _rocketFlightSound:SoundResource;
    private var _rocketSmokeTexture:TextureResource;
    private var _rocketTexture:TextureResource;
    private var _targetLostSound:SoundResource;

    public function RocketLauncherSfxCC(param1:SoundResource = null, param2:SoundResource = null, param3:TextureResource = null, param4:MultiframeTextureResource = null, param5:SoundResource = null, param6:SoundResource = null, param7:LightingSFXEntity = null, param8:SoundResource = null, param9:SoundResource = null, param10:TextureResource = null, param11:SoundResource = null, param12:TextureResource = null, param13:TextureResource = null, param14:SoundResource = null) {
      super();
      this._aimingCompleteSound = param1;
      this._aimingSound = param2;
      this._explosionMarkTexture = param3;
      this._explosionTexture = param4;
      this._leftHitSounds = param5;
      this._leftShotSounds = param6;
      this._lightingSFXEntity = param7;
      this._rightHitSounds = param8;
      this._rightShotSounds = param9;
      this._rocketFlameTexture = param10;
      this._rocketFlightSound = param11;
      this._rocketSmokeTexture = param12;
      this._rocketTexture = param13;
      this._targetLostSound = param14;
    }

    public function get aimingCompleteSound() : SoundResource {
      return this._aimingCompleteSound;
    }

    public function set aimingCompleteSound(param1:SoundResource) : void {
      this._aimingCompleteSound = param1;
    }

    public function get aimingSound() : SoundResource {
      return this._aimingSound;
    }

    public function set aimingSound(param1:SoundResource) : void {
      this._aimingSound = param1;
    }

    public function get explosionMarkTexture() : TextureResource {
      return this._explosionMarkTexture;
    }

    public function set explosionMarkTexture(param1:TextureResource) : void {
      this._explosionMarkTexture = param1;
    }

    public function get explosionTexture() : MultiframeTextureResource {
      return this._explosionTexture;
    }

    public function set explosionTexture(param1:MultiframeTextureResource) : void {
      this._explosionTexture = param1;
    }

    public function get leftHitSounds() : SoundResource {
      return this._leftHitSounds;
    }

    public function set leftHitSounds(param1:SoundResource) : void {
      this._leftHitSounds = param1;
    }

    public function get leftShotSounds() : SoundResource {
      return this._leftShotSounds;
    }

    public function set leftShotSounds(param1:SoundResource) : void {
      this._leftShotSounds = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get rightHitSounds() : SoundResource {
      return this._rightHitSounds;
    }

    public function set rightHitSounds(param1:SoundResource) : void {
      this._rightHitSounds = param1;
    }

    public function get rightShotSounds() : SoundResource {
      return this._rightShotSounds;
    }

    public function set rightShotSounds(param1:SoundResource) : void {
      this._rightShotSounds = param1;
    }

    public function get rocketFlameTexture() : TextureResource {
      return this._rocketFlameTexture;
    }

    public function set rocketFlameTexture(param1:TextureResource) : void {
      this._rocketFlameTexture = param1;
    }

    public function get rocketFlightSound() : SoundResource {
      return this._rocketFlightSound;
    }

    public function set rocketFlightSound(param1:SoundResource) : void {
      this._rocketFlightSound = param1;
    }

    public function get rocketSmokeTexture() : TextureResource {
      return this._rocketSmokeTexture;
    }

    public function set rocketSmokeTexture(param1:TextureResource) : void {
      this._rocketSmokeTexture = param1;
    }

    public function get rocketTexture() : TextureResource {
      return this._rocketTexture;
    }

    public function set rocketTexture(param1:TextureResource) : void {
      this._rocketTexture = param1;
    }

    public function get targetLostSound() : SoundResource {
      return this._targetLostSound;
    }

    public function set targetLostSound(param1:SoundResource) : void {
      this._targetLostSound = param1;
    }

    public function toString() : String {
      var local1:String = "RocketLauncherSfxCC [";
      local1 += "aimingCompleteSound = " + this.aimingCompleteSound + " ";
      local1 += "aimingSound = " + this.aimingSound + " ";
      local1 += "explosionMarkTexture = " + this.explosionMarkTexture + " ";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "leftHitSounds = " + this.leftHitSounds + " ";
      local1 += "leftShotSounds = " + this.leftShotSounds + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "rightHitSounds = " + this.rightHitSounds + " ";
      local1 += "rightShotSounds = " + this.rightShotSounds + " ";
      local1 += "rocketFlameTexture = " + this.rocketFlameTexture + " ";
      local1 += "rocketFlightSound = " + this.rocketFlightSound + " ";
      local1 += "rocketSmokeTexture = " + this.rocketSmokeTexture + " ";
      local1 += "rocketTexture = " + this.rocketTexture + " ";
      local1 += "targetLostSound = " + this.targetLostSound + " ";
      return local1 + "]";
    }
  }
}
