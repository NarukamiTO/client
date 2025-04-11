package projects.tanks.client.battlefield.models.ultimate.effects.mammoth {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class MammothUltimateCC {
    private var _active:Boolean;
    private var _effectLoopSound:SoundResource;
    private var _effectRadius:Number;
    private var _effectSparks1Sound:SoundResource;
    private var _effectSparks2Sound:SoundResource;
    private var _effectSparks3Sound:SoundResource;
    private var _effectSparks4Sound:SoundResource;
    private var _effectStartSound:SoundResource;
    private var _effectStopSound:SoundResource;
    private var _heart:TextureResource;
    private var _shine:TextureResource;
    private var _sparkles:TextureResource;

    public function MammothUltimateCC(param1:Boolean = false, param2:SoundResource = null, param3:Number = 0, param4:SoundResource = null, param5:SoundResource = null, param6:SoundResource = null, param7:SoundResource = null, param8:SoundResource = null, param9:SoundResource = null, param10:TextureResource = null, param11:TextureResource = null, param12:TextureResource = null) {
      super();
      this._active = param1;
      this._effectLoopSound = param2;
      this._effectRadius = param3;
      this._effectSparks1Sound = param4;
      this._effectSparks2Sound = param5;
      this._effectSparks3Sound = param6;
      this._effectSparks4Sound = param7;
      this._effectStartSound = param8;
      this._effectStopSound = param9;
      this._heart = param10;
      this._shine = param11;
      this._sparkles = param12;
    }

    public function get active() : Boolean {
      return this._active;
    }

    public function set active(param1:Boolean) : void {
      this._active = param1;
    }

    public function get effectLoopSound() : SoundResource {
      return this._effectLoopSound;
    }

    public function set effectLoopSound(param1:SoundResource) : void {
      this._effectLoopSound = param1;
    }

    public function get effectRadius() : Number {
      return this._effectRadius;
    }

    public function set effectRadius(param1:Number) : void {
      this._effectRadius = param1;
    }

    public function get effectSparks1Sound() : SoundResource {
      return this._effectSparks1Sound;
    }

    public function set effectSparks1Sound(param1:SoundResource) : void {
      this._effectSparks1Sound = param1;
    }

    public function get effectSparks2Sound() : SoundResource {
      return this._effectSparks2Sound;
    }

    public function set effectSparks2Sound(param1:SoundResource) : void {
      this._effectSparks2Sound = param1;
    }

    public function get effectSparks3Sound() : SoundResource {
      return this._effectSparks3Sound;
    }

    public function set effectSparks3Sound(param1:SoundResource) : void {
      this._effectSparks3Sound = param1;
    }

    public function get effectSparks4Sound() : SoundResource {
      return this._effectSparks4Sound;
    }

    public function set effectSparks4Sound(param1:SoundResource) : void {
      this._effectSparks4Sound = param1;
    }

    public function get effectStartSound() : SoundResource {
      return this._effectStartSound;
    }

    public function set effectStartSound(param1:SoundResource) : void {
      this._effectStartSound = param1;
    }

    public function get effectStopSound() : SoundResource {
      return this._effectStopSound;
    }

    public function set effectStopSound(param1:SoundResource) : void {
      this._effectStopSound = param1;
    }

    public function get heart() : TextureResource {
      return this._heart;
    }

    public function set heart(param1:TextureResource) : void {
      this._heart = param1;
    }

    public function get shine() : TextureResource {
      return this._shine;
    }

    public function set shine(param1:TextureResource) : void {
      this._shine = param1;
    }

    public function get sparkles() : TextureResource {
      return this._sparkles;
    }

    public function set sparkles(param1:TextureResource) : void {
      this._sparkles = param1;
    }

    public function toString() : String {
      var local1:String = "MammothUltimateCC [";
      local1 += "active = " + this.active + " ";
      local1 += "effectLoopSound = " + this.effectLoopSound + " ";
      local1 += "effectRadius = " + this.effectRadius + " ";
      local1 += "effectSparks1Sound = " + this.effectSparks1Sound + " ";
      local1 += "effectSparks2Sound = " + this.effectSparks2Sound + " ";
      local1 += "effectSparks3Sound = " + this.effectSparks3Sound + " ";
      local1 += "effectSparks4Sound = " + this.effectSparks4Sound + " ";
      local1 += "effectStartSound = " + this.effectStartSound + " ";
      local1 += "effectStopSound = " + this.effectStopSound + " ";
      local1 += "heart = " + this.heart + " ";
      local1 += "shine = " + this.shine + " ";
      local1 += "sparkles = " + this.sparkles + " ";
      return local1 + "]";
    }
  }
}
