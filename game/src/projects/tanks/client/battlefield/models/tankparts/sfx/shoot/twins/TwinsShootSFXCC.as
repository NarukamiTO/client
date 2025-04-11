package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class TwinsShootSFXCC {
    private var _explosionTexture:MultiframeTextureResource;
    private var _hitMarkTexture:TextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _muzzleFlashTexture:TextureResource;
    private var _shotSound:SoundResource;
    private var _shotTexture:MultiframeTextureResource;

    public function TwinsShootSFXCC(param1:MultiframeTextureResource = null, param2:TextureResource = null, param3:LightingSFXEntity = null, param4:TextureResource = null, param5:SoundResource = null, param6:MultiframeTextureResource = null) {
      super();
      this._explosionTexture = param1;
      this._hitMarkTexture = param2;
      this._lightingSFXEntity = param3;
      this._muzzleFlashTexture = param4;
      this._shotSound = param5;
      this._shotTexture = param6;
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

    public function get muzzleFlashTexture() : TextureResource {
      return this._muzzleFlashTexture;
    }

    public function set muzzleFlashTexture(param1:TextureResource) : void {
      this._muzzleFlashTexture = param1;
    }

    public function get shotSound() : SoundResource {
      return this._shotSound;
    }

    public function set shotSound(param1:SoundResource) : void {
      this._shotSound = param1;
    }

    public function get shotTexture() : MultiframeTextureResource {
      return this._shotTexture;
    }

    public function set shotTexture(param1:MultiframeTextureResource) : void {
      this._shotTexture = param1;
    }

    public function toString() : String {
      var local1:String = "TwinsShootSFXCC [";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "hitMarkTexture = " + this.hitMarkTexture + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "muzzleFlashTexture = " + this.muzzleFlashTexture + " ";
      local1 += "shotSound = " + this.shotSound + " ";
      local1 += "shotTexture = " + this.shotTexture + " ";
      return local1 + "]";
    }
  }
}
