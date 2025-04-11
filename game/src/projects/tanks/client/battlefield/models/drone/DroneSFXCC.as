package projects.tanks.client.battlefield.models.drone {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class DroneSFXCC {
    private var _activationSound:SoundResource;

    public function DroneSFXCC(param1:SoundResource = null) {
      super();
      this._activationSound = param1;
    }

    public function get activationSound() : SoundResource {
      return this._activationSound;
    }

    public function set activationSound(param1:SoundResource) : void {
      this._activationSound = param1;
    }

    public function toString() : String {
      var local1:String = "DroneSFXCC [";
      local1 += "activationSound = " + this.activationSound + " ";
      return local1 + "]";
    }
  }
}
