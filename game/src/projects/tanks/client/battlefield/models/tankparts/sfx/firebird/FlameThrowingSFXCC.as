package projects.tanks.client.battlefield.models.tankparts.sfx.firebird {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class FlameThrowingSFXCC {
    private var _buffedFireSparksTexture:TextureResource;
    private var _fireTexture:MultiframeTextureResource;
    private var _flameSound:SoundResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _muzzlePlaneTexture:MultiframeTextureResource;

    public function FlameThrowingSFXCC(param1:TextureResource = null, param2:MultiframeTextureResource = null, param3:SoundResource = null, param4:LightingSFXEntity = null, param5:MultiframeTextureResource = null) {
      super();
      this._buffedFireSparksTexture = param1;
      this._fireTexture = param2;
      this._flameSound = param3;
      this._lightingSFXEntity = param4;
      this._muzzlePlaneTexture = param5;
    }

    public function get buffedFireSparksTexture() : TextureResource {
      return this._buffedFireSparksTexture;
    }

    public function set buffedFireSparksTexture(param1:TextureResource) : void {
      this._buffedFireSparksTexture = param1;
    }

    public function get fireTexture() : MultiframeTextureResource {
      return this._fireTexture;
    }

    public function set fireTexture(param1:MultiframeTextureResource) : void {
      this._fireTexture = param1;
    }

    public function get flameSound() : SoundResource {
      return this._flameSound;
    }

    public function set flameSound(param1:SoundResource) : void {
      this._flameSound = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get muzzlePlaneTexture() : MultiframeTextureResource {
      return this._muzzlePlaneTexture;
    }

    public function set muzzlePlaneTexture(param1:MultiframeTextureResource) : void {
      this._muzzlePlaneTexture = param1;
    }

    public function toString() : String {
      var local1:String = "FlameThrowingSFXCC [";
      local1 += "buffedFireSparksTexture = " + this.buffedFireSparksTexture + " ";
      local1 += "fireTexture = " + this.fireTexture + " ";
      local1 += "flameSound = " + this.flameSound + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "muzzlePlaneTexture = " + this.muzzlePlaneTexture + " ";
      return local1 + "]";
    }
  }
}
