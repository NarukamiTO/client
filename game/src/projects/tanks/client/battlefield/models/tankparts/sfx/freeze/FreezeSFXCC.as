package projects.tanks.client.battlefield.models.tankparts.sfx.freeze {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class FreezeSFXCC {
    private var _buffedShardsTextureResource:TextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _particleSpeed:Number;
    private var _particleTextureResource:MultiframeTextureResource;
    private var _planeTextureResource:MultiframeTextureResource;
    private var _shotSoundResource:SoundResource;

    public function FreezeSFXCC(param1:TextureResource = null, param2:LightingSFXEntity = null, param3:Number = 0, param4:MultiframeTextureResource = null, param5:MultiframeTextureResource = null, param6:SoundResource = null) {
      super();
      this._buffedShardsTextureResource = param1;
      this._lightingSFXEntity = param2;
      this._particleSpeed = param3;
      this._particleTextureResource = param4;
      this._planeTextureResource = param5;
      this._shotSoundResource = param6;
    }

    public function get buffedShardsTextureResource() : TextureResource {
      return this._buffedShardsTextureResource;
    }

    public function set buffedShardsTextureResource(param1:TextureResource) : void {
      this._buffedShardsTextureResource = param1;
    }

    public function get lightingSFXEntity() : LightingSFXEntity {
      return this._lightingSFXEntity;
    }

    public function set lightingSFXEntity(param1:LightingSFXEntity) : void {
      this._lightingSFXEntity = param1;
    }

    public function get particleSpeed() : Number {
      return this._particleSpeed;
    }

    public function set particleSpeed(param1:Number) : void {
      this._particleSpeed = param1;
    }

    public function get particleTextureResource() : MultiframeTextureResource {
      return this._particleTextureResource;
    }

    public function set particleTextureResource(param1:MultiframeTextureResource) : void {
      this._particleTextureResource = param1;
    }

    public function get planeTextureResource() : MultiframeTextureResource {
      return this._planeTextureResource;
    }

    public function set planeTextureResource(param1:MultiframeTextureResource) : void {
      this._planeTextureResource = param1;
    }

    public function get shotSoundResource() : SoundResource {
      return this._shotSoundResource;
    }

    public function set shotSoundResource(param1:SoundResource) : void {
      this._shotSoundResource = param1;
    }

    public function toString() : String {
      var local1:String = "FreezeSFXCC [";
      local1 += "buffedShardsTextureResource = " + this.buffedShardsTextureResource + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "particleSpeed = " + this.particleSpeed + " ";
      local1 += "particleTextureResource = " + this.particleTextureResource + " ";
      local1 += "planeTextureResource = " + this.planeTextureResource + " ";
      local1 += "shotSoundResource = " + this.shotSoundResource + " ";
      return local1 + "]";
    }
  }
}
