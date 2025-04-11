package projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class RailgunShootSFXCC {
    private var _chargingPart1:TextureResource;
    private var _chargingPart2:TextureResource;
    private var _chargingPart3:TextureResource;
    private var _hitMarkTexture:TextureResource;
    private var _lightingSFXEntity:LightingSFXEntity;
    private var _powTexture:MultiframeTextureResource;
    private var _ringsTexture:MultiframeTextureResource;
    private var _shotSound:SoundResource;
    private var _smokeImage:TextureResource;
    private var _sphereTexture:MultiframeTextureResource;
    private var _trailImage:TextureResource;

    public function RailgunShootSFXCC(param1:TextureResource = null, param2:TextureResource = null, param3:TextureResource = null, param4:TextureResource = null, param5:LightingSFXEntity = null, param6:MultiframeTextureResource = null, param7:MultiframeTextureResource = null, param8:SoundResource = null, param9:TextureResource = null, param10:MultiframeTextureResource = null, param11:TextureResource = null) {
      super();
      this._chargingPart1 = param1;
      this._chargingPart2 = param2;
      this._chargingPart3 = param3;
      this._hitMarkTexture = param4;
      this._lightingSFXEntity = param5;
      this._powTexture = param6;
      this._ringsTexture = param7;
      this._shotSound = param8;
      this._smokeImage = param9;
      this._sphereTexture = param10;
      this._trailImage = param11;
    }

    public function get chargingPart1() : TextureResource {
      return this._chargingPart1;
    }

    public function set chargingPart1(param1:TextureResource) : void {
      this._chargingPart1 = param1;
    }

    public function get chargingPart2() : TextureResource {
      return this._chargingPart2;
    }

    public function set chargingPart2(param1:TextureResource) : void {
      this._chargingPart2 = param1;
    }

    public function get chargingPart3() : TextureResource {
      return this._chargingPart3;
    }

    public function set chargingPart3(param1:TextureResource) : void {
      this._chargingPart3 = param1;
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

    public function get powTexture() : MultiframeTextureResource {
      return this._powTexture;
    }

    public function set powTexture(param1:MultiframeTextureResource) : void {
      this._powTexture = param1;
    }

    public function get ringsTexture() : MultiframeTextureResource {
      return this._ringsTexture;
    }

    public function set ringsTexture(param1:MultiframeTextureResource) : void {
      this._ringsTexture = param1;
    }

    public function get shotSound() : SoundResource {
      return this._shotSound;
    }

    public function set shotSound(param1:SoundResource) : void {
      this._shotSound = param1;
    }

    public function get smokeImage() : TextureResource {
      return this._smokeImage;
    }

    public function set smokeImage(param1:TextureResource) : void {
      this._smokeImage = param1;
    }

    public function get sphereTexture() : MultiframeTextureResource {
      return this._sphereTexture;
    }

    public function set sphereTexture(param1:MultiframeTextureResource) : void {
      this._sphereTexture = param1;
    }

    public function get trailImage() : TextureResource {
      return this._trailImage;
    }

    public function set trailImage(param1:TextureResource) : void {
      this._trailImage = param1;
    }

    public function toString() : String {
      var local1:String = "RailgunShootSFXCC [";
      local1 += "chargingPart1 = " + this.chargingPart1 + " ";
      local1 += "chargingPart2 = " + this.chargingPart2 + " ";
      local1 += "chargingPart3 = " + this.chargingPart3 + " ";
      local1 += "hitMarkTexture = " + this.hitMarkTexture + " ";
      local1 += "lightingSFXEntity = " + this.lightingSFXEntity + " ";
      local1 += "powTexture = " + this.powTexture + " ";
      local1 += "ringsTexture = " + this.ringsTexture + " ";
      local1 += "shotSound = " + this.shotSound + " ";
      local1 += "smokeImage = " + this.smokeImage + " ";
      local1 += "sphereTexture = " + this.sphereTexture + " ";
      local1 += "trailImage = " + this.trailImage + " ";
      return local1 + "]";
    }
  }
}
