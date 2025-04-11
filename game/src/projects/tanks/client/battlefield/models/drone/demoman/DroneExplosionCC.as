package projects.tanks.client.battlefield.models.drone.demoman {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;

  public class DroneExplosionCC {
    private var _explosionTexture:MultiframeTextureResource;

    public function DroneExplosionCC(param1:MultiframeTextureResource = null) {
      super();
      this._explosionTexture = param1;
    }

    public function get explosionTexture() : MultiframeTextureResource {
      return this._explosionTexture;
    }

    public function set explosionTexture(param1:MultiframeTextureResource) : void {
      this._explosionTexture = param1;
    }

    public function toString() : String {
      var local1:String = "DroneExplosionCC [";
      local1 += "explosionTexture = " + this.explosionTexture + " ";
      return local1 + "]";
    }
  }
}
