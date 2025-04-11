package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class ThunderShootSFXCC {
    private var _explosionMarkTexture:TextureResource;
    private var _explosionSize:Number;
    private var _explosionSound:SoundResource;
    private var _explosionTexture:MultiframeTextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _shotSound:SoundResource;
    private var _shotTexture:TextureResource;

    public function ThunderShootSFXCC(param1:TextureResource = null, param2:Number = 0, param3:SoundResource = null, param4:MultiframeTextureResource = null, param5:LightingSFXEntity = null, param6:SoundResource = null, param7:TextureResource = null) {
      super();
      this._explosionMarkTexture = param1;
      this._explosionSize = param2;
      this._explosionSound = param3;
      this._explosionTexture = param4;
      this._lightingSFXEntity = param5;
      this._shotSound = param6;
      this._shotTexture = param7;
    }

    public function get explosionMarkTexture() : TextureResource {
      return this._explosionMarkTexture;
    }

    public function set explosionMarkTexture(param1:TextureResource) : void {
      this._explosionMarkTexture = param1;
    }

    public function get explosionSize() : Number {
      return this._explosionSize;
    }

    public function set explosionSize(param1:Number) : void {
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
      var local1:String = "ThunderShootSFXCC [";
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
