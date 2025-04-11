package projects.tanks.client.battlefield.models.ultimate.effects.dictator {
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class DictatorUltimateCC {
    private var _activationSound:SoundResource;
    private var _beam:TextureResource;
    private var _beamScale:Number;
    private var _secondaryBeamScale:Number;
    private var _star:TextureResource;
    private var _wave:TextureResource;
    private var _waveSize:Number;

    public function DictatorUltimateCC(param1:SoundResource = null, param2:TextureResource = null, param3:Number = 0, param4:Number = 0, param5:TextureResource = null, param6:TextureResource = null, param7:Number = 0) {
      super();
      this._activationSound = param1;
      this._beam = param2;
      this._beamScale = param3;
      this._secondaryBeamScale = param4;
      this._star = param5;
      this._wave = param6;
      this._waveSize = param7;
    }

    public function get activationSound() : SoundResource {
      return this._activationSound;
    }

    public function set activationSound(param1:SoundResource) : void {
      this._activationSound = param1;
    }

    public function get beam() : TextureResource {
      return this._beam;
    }

    public function set beam(param1:TextureResource) : void {
      this._beam = param1;
    }

    public function get beamScale() : Number {
      return this._beamScale;
    }

    public function set beamScale(param1:Number) : void {
      this._beamScale = param1;
    }

    public function get secondaryBeamScale() : Number {
      return this._secondaryBeamScale;
    }

    public function set secondaryBeamScale(param1:Number) : void {
      this._secondaryBeamScale = param1;
    }

    public function get star() : TextureResource {
      return this._star;
    }

    public function set star(param1:TextureResource) : void {
      this._star = param1;
    }

    public function get wave() : TextureResource {
      return this._wave;
    }

    public function set wave(param1:TextureResource) : void {
      this._wave = param1;
    }

    public function get waveSize() : Number {
      return this._waveSize;
    }

    public function set waveSize(param1:Number) : void {
      this._waveSize = param1;
    }

    public function toString() : String {
      var local1:String = "DictatorUltimateCC [";
      local1 += "activationSound = " + this.activationSound + " ";
      local1 += "beam = " + this.beam + " ";
      local1 += "beamScale = " + this.beamScale + " ";
      local1 += "secondaryBeamScale = " + this.secondaryBeamScale + " ";
      local1 += "star = " + this.star + " ";
      local1 += "wave = " + this.wave + " ";
      local1 += "waveSize = " + this.waveSize + " ";
      return local1 + "]";
    }
  }
}
