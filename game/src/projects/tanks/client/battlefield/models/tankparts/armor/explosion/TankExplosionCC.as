package projects.tanks.client.battlefield.models.tankparts.armor.explosion {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;

  public class TankExplosionCC {
    private var _explosionTexture:MultiframeTextureResource;
    private var _shockWaveTexture:MultiframeTextureResource;
    private var _smokeTextureId:MultiframeTextureResource;

    public function TankExplosionCC(param1:MultiframeTextureResource = null, param2:MultiframeTextureResource = null, param3:MultiframeTextureResource = null) {
      super();
      this._explosionTexture = param1;
      this._shockWaveTexture = param2;
      this._smokeTextureId = param3;
    }

    public function get explosionTexture() : MultiframeTextureResource {
      return this._explosionTexture;
    }

    public function set explosionTexture(param1:MultiframeTextureResource) : void {
      this._explosionTexture = param1;
    }

    public function get shockWaveTexture() : MultiframeTextureResource {
      return this._shockWaveTexture;
    }

    public function set shockWaveTexture(param1:MultiframeTextureResource) : void {
      this._shockWaveTexture = param1;
    }

    public function get smokeTextureId() : MultiframeTextureResource {
      return this._smokeTextureId;
    }

    public function set smokeTextureId(param1:MultiframeTextureResource) : void {
      this._smokeTextureId = param1;
    }

    public function toString() : String {
      var local1:String = "TankExplosionCC [";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      local1 += "shockWaveTexture = " + this.shockWaveTexture + " ";
      local1 += "smokeTextureId = " + this.smokeTextureId + " ";
      return local1 + "]";
    }
  }
}
