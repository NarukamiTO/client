package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class ShaftShootSFXCC {
    private var _explosionSound:SoundResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _hitMarkTexture:TextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _muzzleFlashTexture:MultiframeTextureResource;
    private var _shotSound:SoundResource;
    private var _targetingSound:SoundResource;
    private var _trailTexture:TextureResource;
    private var _zoomModeSound:SoundResource;

    public function ShaftShootSFXCC(param1:SoundResource = null, param2:MultiframeTextureResource = null, param3:TextureResource = null, param4:LightingSFXEntity = null, param5:MultiframeTextureResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:TextureResource = null, param9:SoundResource = null) {
      super();
      this._explosionSound = param1;
      this._explosionTexture = param2;
      this._hitMarkTexture = param3;
      this._lightingSFXEntity = param4;
      this._muzzleFlashTexture = param5;
      this._shotSound = param6;
      this._targetingSound = param7;
      this._trailTexture = param8;
      this._zoomModeSound = param9;
    }

    public function get explosionSound() : SoundResource {
      return this._explosionSound;
    }

    public function set explosionSound(param1:SoundResource) : void {
      this._explosionSound = param1;
    }

    public function get explosionTexture() : MultiframeTextureResource {
      return this._explosionTexture;
    }

    public function set explosionTexture(param1:MultiframeTextureResource) : void {
      this._explosionTexture = param1;
    }

    public function get hitMarkTexture() : TextureResource {
      return this._hitMarkTexture;
    }

    public function set hitMarkTexture(param1:TextureResource) : void {
      this._hitMarkTexture = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get muzzleFlashTexture() : MultiframeTextureResource {
      return this._muzzleFlashTexture;
    }

    public function set muzzleFlashTexture(param1:MultiframeTextureResource) : void {
      this._muzzleFlashTexture = param1;
    }

    public function get shotSound() : SoundResource {
      return this._shotSound;
    }

    public function set shotSound(param1:SoundResource) : void {
      this._shotSound = param1;
    }

    public function get targetingSound() : SoundResource {
      return this._targetingSound;
    }

    public function set targetingSound(param1:SoundResource) : void {
      this._targetingSound = param1;
    }

    public function get trailTexture() : TextureResource {
      return this._trailTexture;
    }

    public function set trailTexture(param1:TextureResource) : void {
      this._trailTexture = param1;
    }

    public function get zoomModeSound() : SoundResource {
      return this._zoomModeSound;
    }

    public function set zoomModeSound(param1:SoundResource) : void {
      this._zoomModeSound = param1;
    }

    public function toString() : String {
      var local1:String = "ShaftShootSFXCC [";
      local1 += "explosionSound = " + this.explosionSound + " ";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "hitMarkTexture = " + this.hitMarkTexture + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "muzzleFlashTexture = " + this.muzzleFlashTexture + " ";
      local1 += "shotSound = " + this.shotSound + " ";
      local1 += "targetingSound = " + this.targetingSound + " ";
      local1 += "trailTexture = " + this.trailTexture + " ";
      local1 += "zoomModeSound = " + this.zoomModeSound + " ";
      return local1 + "]";
    }
  }
}
