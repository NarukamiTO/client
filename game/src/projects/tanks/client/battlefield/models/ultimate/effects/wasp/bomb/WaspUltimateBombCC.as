package projects.tanks.client.battlefield.models.ultimate.effects.wasp.bomb {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class WaspUltimateBombCC {
    private var _bombBeepSound:SoundResource;
    private var _bombPlacedSound:SoundResource;
    private var _countdown:MultiframeTextureResource;
    private var _craterDecal:TextureResource;
    private var _farCountdown:MultiframeTextureResource;
    private var _nuclearBangFlame:TextureResource;
    private var _nuclearBangLight:TextureResource;
    private var _nuclearBangSmoke:TextureResource;
    private var _nuclearBangSound:SoundResource;
    private var _nuclearBangWave:TextureResource;
    private var _timeLeft:int;

    public function WaspUltimateBombCC(param1:SoundResource = null, param2:SoundResource = null, param3:MultiframeTextureResource = null, param4:TextureResource = null, param5:MultiframeTextureResource = null, param6:TextureResource = null, param7:TextureResource = null, param8:TextureResource = null, param9:SoundResource = null, param10:TextureResource = null, param11:int = 0) {
      super();
      this._bombBeepSound = param1;
      this._bombPlacedSound = param2;
      this._countdown = param3;
      this._craterDecal = param4;
      this._farCountdown = param5;
      this._nuclearBangFlame = param6;
      this._nuclearBangLight = param7;
      this._nuclearBangSmoke = param8;
      this._nuclearBangSound = param9;
      this._nuclearBangWave = param10;
      this._timeLeft = param11;
    }

    public function get bombBeepSound() : SoundResource {
      return this._bombBeepSound;
    }

    public function set bombBeepSound(param1:SoundResource) : void {
      this._bombBeepSound = param1;
    }

    public function get bombPlacedSound() : SoundResource {
      return this._bombPlacedSound;
    }

    public function set bombPlacedSound(param1:SoundResource) : void {
      this._bombPlacedSound = param1;
    }

    public function get countdown() : MultiframeTextureResource {
      return this._countdown;
    }

    public function set countdown(param1:MultiframeTextureResource) : void {
      this._countdown = param1;
    }

    public function get craterDecal() : TextureResource {
      return this._craterDecal;
    }

    public function set craterDecal(param1:TextureResource) : void {
      this._craterDecal = param1;
    }

    public function get farCountdown() : MultiframeTextureResource {
      return this._farCountdown;
    }

    public function set farCountdown(param1:MultiframeTextureResource) : void {
      this._farCountdown = param1;
    }

    public function get nuclearBangFlame() : TextureResource {
      return this._nuclearBangFlame;
    }

    public function set nuclearBangFlame(param1:TextureResource) : void {
      this._nuclearBangFlame = param1;
    }

    public function get nuclearBangLight() : TextureResource {
      return this._nuclearBangLight;
    }

    public function set nuclearBangLight(param1:TextureResource) : void {
      this._nuclearBangLight = param1;
    }

    public function get nuclearBangSmoke() : TextureResource {
      return this._nuclearBangSmoke;
    }

    public function set nuclearBangSmoke(param1:TextureResource) : void {
      this._nuclearBangSmoke = param1;
    }

    public function get nuclearBangSound() : SoundResource {
      return this._nuclearBangSound;
    }

    public function set nuclearBangSound(param1:SoundResource) : void {
      this._nuclearBangSound = param1;
    }

    public function get nuclearBangWave() : TextureResource {
      return this._nuclearBangWave;
    }

    public function set nuclearBangWave(param1:TextureResource) : void {
      this._nuclearBangWave = param1;
    }

    public function get timeLeft() : int {
      return this._timeLeft;
    }

    public function set timeLeft(param1:int) : void {
      this._timeLeft = param1;
    }

    public function toString() : String {
      var local1:String = "WaspUltimateBombCC [";
      local1 += "bombBeepSound = " + this.bombBeepSound + " ";
      local1 += "bombPlacedSound = " + this.bombPlacedSound + " ";
      local1 += "countdown = " + this.countdown + " ";
      local1 += "craterDecal = " + this.craterDecal + " ";
      local1 += "farCountdown = " + this.farCountdown + " ";
      local1 += "nuclearBangFlame = " + this.nuclearBangFlame + " ";
      local1 += "nuclearBangLight = " + this.nuclearBangLight + " ";
      local1 += "nuclearBangSmoke = " + this.nuclearBangSmoke + " ";
      local1 += "nuclearBangSound = " + this.nuclearBangSound + " ";
      local1 += "nuclearBangWave = " + this.nuclearBangWave + " ";
      local1 += "timeLeft = " + this.timeLeft + " ";
      return local1 + "]";
    }
  }
}
