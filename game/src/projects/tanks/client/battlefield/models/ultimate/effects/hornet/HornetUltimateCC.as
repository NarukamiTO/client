package projects.tanks.client.battlefield.models.ultimate.effects.hornet {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class HornetUltimateCC {
    private var _effectEnabled:Boolean;
    private var _effectStartSound:SoundResource;
    private var _ring:TextureResource;
    private var _sonarSound:SoundResource;

    public function HornetUltimateCC(param1:Boolean = false, param2:SoundResource = null, param3:TextureResource = null, param4:SoundResource = null) {
      super();
      this._effectEnabled = param1;
      this._effectStartSound = param2;
      this._ring = param3;
      this._sonarSound = param4;
    }

    public function get effectEnabled() : Boolean {
      return this._effectEnabled;
    }

    public function set effectEnabled(param1:Boolean) : void {
      this._effectEnabled = param1;
    }

    public function get effectStartSound() : SoundResource {
      return this._effectStartSound;
    }

    public function set effectStartSound(param1:SoundResource) : void {
      this._effectStartSound = param1;
    }

    public function get ring() : TextureResource {
      return this._ring;
    }

    public function set ring(param1:TextureResource) : void {
      this._ring = param1;
    }

    public function get sonarSound() : SoundResource {
      return this._sonarSound;
    }

    public function set sonarSound(param1:SoundResource) : void {
      this._sonarSound = param1;
    }

    public function toString() : String {
      var local1:String = "HornetUltimateCC [";
      local1 += "effectEnabled = " + this.effectEnabled + " ";
      local1 += "effectStartSound = " + this.effectStartSound + " ";
      local1 += "ring = " + this.ring + " ";
      local1 += "sonarSound = " + this.sonarSound + " ";
      return local1 + "]";
    }
  }
}
