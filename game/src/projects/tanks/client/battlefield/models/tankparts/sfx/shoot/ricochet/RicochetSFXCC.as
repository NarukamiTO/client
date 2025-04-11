package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class RicochetSFXCC {
    private var _bumpFlashTexture:MultiframeTextureResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _explostinSound:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _ricochetSound:SoundResource;
    private var _shotFlashTexture:TextureResource;
    private var _shotSound:SoundResource;
    private var _shotTexture:MultiframeTextureResource;
    private var _tailTrailTexutre:TextureResource;

    public function RicochetSFXCC(param1:MultiframeTextureResource = null, param2:MultiframeTextureResource = null, param3:SoundResource = null, param4:LightingSFXEntity = null, param5:SoundResource = null, param6:TextureResource = null, param7:SoundResource = null, param8:MultiframeTextureResource = null, param9:TextureResource = null) {
      super();
      this._bumpFlashTexture = param1;
      this._explosionTexture = param2;
      this._explostinSound = param3;
      this._lightingSFXEntity = param4;
      this._ricochetSound = param5;
      this._shotFlashTexture = param6;
      this._shotSound = param7;
      this._shotTexture = param8;
      this._tailTrailTexutre = param9;
    }

    public function get bumpFlashTexture() : MultiframeTextureResource {
      return this._bumpFlashTexture;
    }

    public function set bumpFlashTexture(param1:MultiframeTextureResource) : void {
      this._bumpFlashTexture = param1;
    }

    public function get explosionTexture() : MultiframeTextureResource {
      return this._explosionTexture;
    }

    public function set explosionTexture(param1:MultiframeTextureResource) : void {
      this._explosionTexture = param1;
    }

    public function get explostinSound() : SoundResource {
      return this._explostinSound;
    }

    public function set explostinSound(param1:SoundResource) : void {
      this._explostinSound = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get ricochetSound() : SoundResource {
      return this._ricochetSound;
    }

    public function set ricochetSound(param1:SoundResource) : void {
      this._ricochetSound = param1;
    }

    public function get shotFlashTexture() : TextureResource {
      return this._shotFlashTexture;
    }

    public function set shotFlashTexture(param1:TextureResource) : void {
      this._shotFlashTexture = param1;
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

    public function get tailTrailTexutre() : TextureResource {
      return this._tailTrailTexutre;
    }

    public function set tailTrailTexutre(param1:TextureResource) : void {
      this._tailTrailTexutre = param1;
    }

    public function toString() : String {
      var local1:String = "RicochetSFXCC [";
      local1 += "bumpFlashTexture = " + this.bumpFlashTexture + " ";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "explostinSound = " + this.explostinSound + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "ricochetSound = " + this.ricochetSound + " ";
      local1 += "shotFlashTexture = " + this.shotFlashTexture + " ";
      local1 += "shotSound = " + this.shotSound + " ";
      local1 += "shotTexture = " + this.shotTexture + " ";
      local1 += "tailTrailTexutre = " + this.tailTrailTexutre + " ";
      return local1 + "]";
    }
  }
}
