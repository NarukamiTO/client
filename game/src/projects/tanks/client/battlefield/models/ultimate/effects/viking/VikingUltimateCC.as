package projects.tanks.client.battlefield.models.ultimate.effects.viking {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class VikingUltimateCC {
    private var _effectEnabled:Boolean;
    private var _effectEndSound:SoundResource;
    private var _effectSound:SoundResource;
    private var _effectStartSound:SoundResource;
    private var _flame:TextureResource;
    private var _smoke:TextureResource;

    public function VikingUltimateCC(param1:Boolean = false, param2:SoundResource = null, param3:SoundResource = null, param4:SoundResource = null, param5:TextureResource = null, param6:TextureResource = null) {
      super();
      this._effectEnabled = param1;
      this._effectEndSound = param2;
      this._effectSound = param3;
      this._effectStartSound = param4;
      this._flame = param5;
      this._smoke = param6;
    }

    public function get effectEnabled() : Boolean {
      return this._effectEnabled;
    }

    public function set effectEnabled(param1:Boolean) : void {
      this._effectEnabled = param1;
    }

    public function get effectEndSound() : SoundResource {
      return this._effectEndSound;
    }

    public function set effectEndSound(param1:SoundResource) : void {
      this._effectEndSound = param1;
    }

    public function get effectSound() : SoundResource {
      return this._effectSound;
    }

    public function set effectSound(param1:SoundResource) : void {
      this._effectSound = param1;
    }

    public function get effectStartSound() : SoundResource {
      return this._effectStartSound;
    }

    public function set effectStartSound(param1:SoundResource) : void {
      this._effectStartSound = param1;
    }

    public function get flame() : TextureResource {
      return this._flame;
    }

    public function set flame(param1:TextureResource) : void {
      this._flame = param1;
    }

    public function get smoke() : TextureResource {
      return this._smoke;
    }

    public function set smoke(param1:TextureResource) : void {
      this._smoke = param1;
    }

    public function toString() : String {
      var local1:String = "VikingUltimateCC [";
      local1 += "effectEnabled = " + this.effectEnabled + " ";
      local1 += "effectEndSound = " + this.effectEndSound + " ";
      local1 += "effectSound = " + this.effectSound + " ";
      local1 += "effectStartSound = " + this.effectStartSound + " ";
      local1 += "flame = " + this.flame + " ";
      local1 += "smoke = " + this.smoke + " ";
      return local1 + "]";
    }
  }
}
