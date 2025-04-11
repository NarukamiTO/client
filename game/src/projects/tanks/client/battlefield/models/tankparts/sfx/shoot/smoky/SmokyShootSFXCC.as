package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class SmokyShootSFXCC {
    private var _criticalHitSize:int;
    private var _criticalHitTexture:MultiframeTextureResource;
    private var _explosionMarkTexture:TextureResource;
    private var _explosionSize:int;
    private var _explosionSound:SoundResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _shotSound:SoundResource;
    private var _shotTexture:TextureResource;

    public function SmokyShootSFXCC(param1:int = 0, param2:MultiframeTextureResource = null, param3:TextureResource = null, param4:int = 0, param5:SoundResource = null, param6:MultiframeTextureResource = null, param7:LightingSFXEntity = null, param8:SoundResource = null, param9:TextureResource = null) {
      super();
      this._criticalHitSize = param1;
      this._criticalHitTexture = param2;
      this._explosionMarkTexture = param3;
      this._explosionSize = param4;
      this._explosionSound = param5;
      this._explosionTexture = param6;
      this._lightingSFXEntity = param7;
      this._shotSound = param8;
      this._shotTexture = param9;
    }

    public function get criticalHitSize() : int {
      return this._criticalHitSize;
    }

    public function set criticalHitSize(param1:int) : void {
      this._criticalHitSize = param1;
    }

    public function get criticalHitTexture() : MultiframeTextureResource {
      return this._criticalHitTexture;
    }

    public function set criticalHitTexture(param1:MultiframeTextureResource) : void {
      this._criticalHitTexture = param1;
    }

    public function get explosionMarkTexture() : TextureResource {
      return this._explosionMarkTexture;
    }

    public function set explosionMarkTexture(param1:TextureResource) : void {
      this._explosionMarkTexture = param1;
    }

    public function get explosionSize() : int {
      return this._explosionSize;
    }

    public function set explosionSize(param1:int) : void {
      this._explosionSize = param1;
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

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get shotSound() : SoundResource {
      return this._shotSound;
    }

    public function set shotSound(param1:SoundResource) : void {
      this._shotSound = param1;
    }

    public function get shotTexture() : TextureResource {
      return this._shotTexture;
    }

    public function set shotTexture(param1:TextureResource) : void {
      this._shotTexture = param1;
    }

    public function toString() : String {
      var local1:String = "SmokyShootSFXCC [";
      local1 += "criticalHitSize = " + this.criticalHitSize + " ";
      local1 += "criticalHitTexture = " + this.criticalHitTexture + " ";
      local1 += "explosionMarkTexture = " + this.explosionMarkTexture + " ";
      local1 += "explosionSize = " + this.explosionSize + " ";
      local1 += "explosionSound = " + this.explosionSound + " ";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "shotSound = " + this.shotSound + " ";
      local1 += "shotTexture = " + this.shotTexture + " ";
      return local1 + "]";
    }
  }
}
