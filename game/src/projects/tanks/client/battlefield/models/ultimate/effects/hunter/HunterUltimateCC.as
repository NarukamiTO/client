package projects.tanks.client.battlefield.models.ultimate.effects.hunter {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class HunterUltimateCC {
    private var _chargingTimeMillis:int;
    private var _effectStartSound:SoundResource;
    private var _energy:TextureResource;
    private var _failSound:SoundResource;
    private var _hitSound:SoundResource;
    private var _lightning:TextureResource;
    private var _originPointZOffset:Number;
    private var _preparing:Boolean;

    public function HunterUltimateCC(param1:int = 0, param2:SoundResource = null, param3:TextureResource = null, param4:SoundResource = null, param5:SoundResource = null, param6:TextureResource = null, param7:Number = 0, param8:Boolean = false) {
      super();
      this._chargingTimeMillis = param1;
      this._effectStartSound = param2;
      this._energy = param3;
      this._failSound = param4;
      this._hitSound = param5;
      this._lightning = param6;
      this._originPointZOffset = param7;
      this._preparing = param8;
    }

    public function get chargingTimeMillis() : int {
      return this._chargingTimeMillis;
    }

    public function set chargingTimeMillis(param1:int) : void {
      this._chargingTimeMillis = param1;
    }

    public function get effectStartSound() : SoundResource {
      return this._effectStartSound;
    }

    public function set effectStartSound(param1:SoundResource) : void {
      this._effectStartSound = param1;
    }

    public function get energy() : TextureResource {
      return this._energy;
    }

    public function set energy(param1:TextureResource) : void {
      this._energy = param1;
    }

    public function get failSound() : SoundResource {
      return this._failSound;
    }

    public function set failSound(param1:SoundResource) : void {
      this._failSound = param1;
    }

    public function get hitSound() : SoundResource {
      return this._hitSound;
    }

    public function set hitSound(param1:SoundResource) : void {
      this._hitSound = param1;
    }

    public function get lightning() : TextureResource {
      return this._lightning;
    }

    public function set lightning(param1:TextureResource) : void {
      this._lightning = param1;
    }

    public function get originPointZOffset() : Number {
      return this._originPointZOffset;
    }

    public function set originPointZOffset(param1:Number) : void {
      this._originPointZOffset = param1;
    }

    public function get preparing() : Boolean {
      return this._preparing;
    }

    public function set preparing(param1:Boolean) : void {
      this._preparing = param1;
    }

    public function toString() : String {
      var local1:String = "HunterUltimateCC [";
      local1 += "chargingTimeMillis = " + this.chargingTimeMillis + " ";
      local1 += "effectStartSound = " + this.effectStartSound + " ";
      local1 += "energy = " + this.energy + " ";
      local1 += "failSound = " + this.failSound + " ";
      local1 += "hitSound = " + this.hitSound + " ";
      local1 += "lightning = " + this.lightning + " ";
      local1 += "originPointZOffset = " + this.originPointZOffset + " ";
      local1 += "preparing = " + this.preparing + " ";
      return local1 + "]";
    }
  }
}
