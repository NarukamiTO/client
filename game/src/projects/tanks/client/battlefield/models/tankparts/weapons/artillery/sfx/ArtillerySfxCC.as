package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class ArtillerySfxCC {
    private var _chargingSound:SoundResource;
    private var _explosionSound:SoundResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _farShotSound:SoundResource;
    private var _flameTexture:TextureResource;
    private var _flyBySound:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _markTexture:TextureResource;
    private var _reloadSound:SoundResource;
    private var _shot1Sound:SoundResource;
    private var _shot2Sound:SoundResource;
    private var _shot3Sound:SoundResource;
    private var _shot4Sound:SoundResource;
    private var _smokeTexture:MultiframeTextureResource;
    private var _streamTexture:TextureResource;
    private var _trailTexture:TextureResource;

    public function ArtillerySfxCC(param1:SoundResource = null, param2:SoundResource = null, param3:MultiframeTextureResource = null, param4:SoundResource = null, param5:TextureResource = null, param6:SoundResource = null, param7:LightingSFXEntity = null, param8:TextureResource = null, param9:SoundResource = null, param10:SoundResource = null, param11:SoundResource = null, param12:SoundResource = null, param13:SoundResource = null, param14:MultiframeTextureResource = null, param15:TextureResource = null, param16:TextureResource = null) {
      super();
      this._chargingSound = param1;
      this._explosionSound = param2;
      this._explosionTexture = param3;
      this._farShotSound = param4;
      this._flameTexture = param5;
      this._flyBySound = param6;
      this._lightingSFXEntity = param7;
      this._markTexture = param8;
      this._reloadSound = param9;
      this._shot1Sound = param10;
      this._shot2Sound = param11;
      this._shot3Sound = param12;
      this._shot4Sound = param13;
      this._smokeTexture = param14;
      this._streamTexture = param15;
      this._trailTexture = param16;
    }

    public function get chargingSound() : SoundResource {
      return this._chargingSound;
    }

    public function set chargingSound(param1:SoundResource) : void {
      this._chargingSound = param1;
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

    public function get farShotSound() : SoundResource {
      return this._farShotSound;
    }

    public function set farShotSound(param1:SoundResource) : void {
      this._farShotSound = param1;
    }

    public function get flameTexture() : TextureResource {
      return this._flameTexture;
    }

    public function set flameTexture(param1:TextureResource) : void {
      this._flameTexture = param1;
    }

    public function get flyBySound() : SoundResource {
      return this._flyBySound;
    }

    public function set flyBySound(param1:SoundResource) : void {
      this._flyBySound = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get markTexture() : TextureResource {
      return this._markTexture;
    }

    public function set markTexture(param1:TextureResource) : void {
      this._markTexture = param1;
    }

    public function get reloadSound() : SoundResource {
      return this._reloadSound;
    }

    public function set reloadSound(param1:SoundResource) : void {
      this._reloadSound = param1;
    }

    public function get shot1Sound() : SoundResource {
      return this._shot1Sound;
    }

    public function set shot1Sound(param1:SoundResource) : void {
      this._shot1Sound = param1;
    }

    public function get shot2Sound() : SoundResource {
      return this._shot2Sound;
    }

    public function set shot2Sound(param1:SoundResource) : void {
      this._shot2Sound = param1;
    }

    public function get shot3Sound() : SoundResource {
      return this._shot3Sound;
    }

    public function set shot3Sound(param1:SoundResource) : void {
      this._shot3Sound = param1;
    }

    public function get shot4Sound() : SoundResource {
      return this._shot4Sound;
    }

    public function set shot4Sound(param1:SoundResource) : void {
      this._shot4Sound = param1;
    }

    public function get smokeTexture() : MultiframeTextureResource {
      return this._smokeTexture;
    }

    public function set smokeTexture(param1:MultiframeTextureResource) : void {
      this._smokeTexture = param1;
    }

    public function get streamTexture() : TextureResource {
      return this._streamTexture;
    }

    public function set streamTexture(param1:TextureResource) : void {
      this._streamTexture = param1;
    }

    public function get trailTexture() : TextureResource {
      return this._trailTexture;
    }

    public function set trailTexture(param1:TextureResource) : void {
      this._trailTexture = param1;
    }

    public function toString() : String {
      var local1:String = "ArtillerySfxCC [";
      local1 += "chargingSound = " + this.chargingSound + " ";
      local1 += "explosionSound = " + this.explosionSound + " ";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "farShotSound = " + this.farShotSound + " ";
      local1 += "flameTexture = " + this.flameTexture + " ";
      local1 += "flyBySound = " + this.flyBySound + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "markTexture = " + this.markTexture + " ";
      local1 += "reloadSound = " + this.reloadSound + " ";
      local1 += "shot1Sound = " + this.shot1Sound + " ";
      local1 += "shot2Sound = " + this.shot2Sound + " ";
      local1 += "shot3Sound = " + this.shot3Sound + " ";
      local1 += "shot4Sound = " + this.shot4Sound + " ";
      local1 += "smokeTexture = " + this.smokeTexture + " ";
      local1 += "streamTexture = " + this.streamTexture + " ";
      local1 += "trailTexture = " + this.trailTexture + " ";
      return local1 + "]";
    }
  }
}
