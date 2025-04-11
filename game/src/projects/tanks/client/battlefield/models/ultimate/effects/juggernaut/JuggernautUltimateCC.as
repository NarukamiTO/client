package projects.tanks.client.battlefield.models.ultimate.effects.juggernaut {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class JuggernautUltimateCC {
    private var _activateSound:SoundResource;
    private var _negativeColorTransform:String;
    private var _positiveColorTransform:String;
    private var _sparkImage:TextureResource;

    public function JuggernautUltimateCC(param1:SoundResource = null, param2:String = null, param3:String = null, param4:TextureResource = null) {
      super();
      this._activateSound = param1;
      this._negativeColorTransform = param2;
      this._positiveColorTransform = param3;
      this._sparkImage = param4;
    }

    public function get activateSound() : SoundResource {
      return this._activateSound;
    }

    public function set activateSound(param1:SoundResource) : void {
      this._activateSound = param1;
    }

    public function get negativeColorTransform() : String {
      return this._negativeColorTransform;
    }

    public function set negativeColorTransform(param1:String) : void {
      this._negativeColorTransform = param1;
    }

    public function get positiveColorTransform() : String {
      return this._positiveColorTransform;
    }

    public function set positiveColorTransform(param1:String) : void {
      this._positiveColorTransform = param1;
    }

    public function get sparkImage() : TextureResource {
      return this._sparkImage;
    }

    public function set sparkImage(param1:TextureResource) : void {
      this._sparkImage = param1;
    }

    public function toString() : String {
      var local1:String = "JuggernautUltimateCC [";
      local1 += "activateSound = " + this.activateSound + " ";
      local1 += "negativeColorTransform = " + this.negativeColorTransform + " ";
      local1 += "positiveColorTransform = " + this.positiveColorTransform + " ";
      local1 += "sparkImage = " + this.sparkImage + " ";
      return local1 + "]";
    }
  }
}
