package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class ShotgunSFXCC {
    private var _explosionMarkTextures:Vector.<TextureResource>;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _magazineReloadSound:SoundResource;
    private var _pelletTrailTexture:TextureResource;
    private var _reloadSound:SoundResource;
    private var _shotAcrossTexture:MultiframeTextureResource;
    private var _shotAlongTexture:MultiframeTextureResource;
    private var _shotSound:SoundResource;
    private var _smokeTexture:MultiframeTextureResource;
    private var _sparkleTexture:TextureResource;

    public function ShotgunSFXCC(param1:Vector.<TextureResource> = null, param2:LightingSFXEntity = null, param3:SoundResource = null, param4:TextureResource = null, param5:SoundResource = null, param6:MultiframeTextureResource = null, param7:MultiframeTextureResource = null, param8:SoundResource = null, param9:MultiframeTextureResource = null, param10:TextureResource = null) {
      super();
      this._explosionMarkTextures = param1;
      this._lightingSFXEntity = param2;
      this._magazineReloadSound = param3;
      this._pelletTrailTexture = param4;
      this._reloadSound = param5;
      this._shotAcrossTexture = param6;
      this._shotAlongTexture = param7;
      this._shotSound = param8;
      this._smokeTexture = param9;
      this._sparkleTexture = param10;
    }

    public function get explosionMarkTextures() : Vector.<TextureResource> {
      return this._explosionMarkTextures;
    }

    public function set explosionMarkTextures(param1:Vector.<TextureResource>) : void {
      this._explosionMarkTextures = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get magazineReloadSound() : SoundResource {
      return this._magazineReloadSound;
    }

    public function set magazineReloadSound(param1:SoundResource) : void {
      this._magazineReloadSound = param1;
    }

    public function get pelletTrailTexture() : TextureResource {
      return this._pelletTrailTexture;
    }

    public function set pelletTrailTexture(param1:TextureResource) : void {
      this._pelletTrailTexture = param1;
    }

    public function get reloadSound() : SoundResource {
      return this._reloadSound;
    }

    public function set reloadSound(param1:SoundResource) : void {
      this._reloadSound = param1;
    }

    public function get shotAcrossTexture() : MultiframeTextureResource {
      return this._shotAcrossTexture;
    }

    public function set shotAcrossTexture(param1:MultiframeTextureResource) : void {
      this._shotAcrossTexture = param1;
    }

    public function get shotAlongTexture() : MultiframeTextureResource {
      return this._shotAlongTexture;
    }

    public function set shotAlongTexture(param1:MultiframeTextureResource) : void {
      this._shotAlongTexture = param1;
    }

    public function get shotSound() : SoundResource {
      return this._shotSound;
    }

    public function set shotSound(param1:SoundResource) : void {
      this._shotSound = param1;
    }

    public function get smokeTexture() : MultiframeTextureResource {
      return this._smokeTexture;
    }

    public function set smokeTexture(param1:MultiframeTextureResource) : void {
      this._smokeTexture = param1;
    }

    public function get sparkleTexture() : TextureResource {
      return this._sparkleTexture;
    }

    public function set sparkleTexture(param1:TextureResource) : void {
      this._sparkleTexture = param1;
    }

    public function toString() : String {
      var local1:String = "ShotgunSFXCC [";
      local1 += "explosionMarkTextures = " + this.explosionMarkTextures + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "magazineReloadSound = " + this.magazineReloadSound + " ";
      local1 += "pelletTrailTexture = " + this.pelletTrailTexture + " ";
      local1 += "reloadSound = " + this.reloadSound + " ";
      local1 += "shotAcrossTexture = " + this.shotAcrossTexture + " ";
      local1 += "shotAlongTexture = " + this.shotAlongTexture + " ";
      local1 += "shotSound = " + this.shotSound + " ";
      local1 += "smokeTexture = " + this.smokeTexture + " ";
      local1 += "sparkleTexture = " + this.sparkleTexture + " ";
      return local1 + "]";
    }
  }
}
