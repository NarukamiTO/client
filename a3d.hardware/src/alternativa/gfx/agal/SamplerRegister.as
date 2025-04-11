package alternativa.gfx.agal {
  import flash.utils.ByteArray;

  public class SamplerRegister extends Register {
    protected var samplerbits:int = 5;

    public function SamplerRegister(param1:int) {
      super();
      this.index = param1;
    }

    public function dim(param1:SamplerDim) : SamplerRegister {
      this.addSamplerOption(param1);
      return this;
    }

    public function type(param1:SamplerType) : SamplerRegister {
      this.addSamplerOption(param1);
      return this;
    }

    public function special(param1:SamplerSpecial) : SamplerRegister {
      this.addSamplerOption(param1);
      return this;
    }

    public function repeat(param1:SamplerRepeat) : SamplerRegister {
      this.addSamplerOption(param1);
      return this;
    }

    public function mipmap(param1:SamplerMipMap) : SamplerRegister {
      this.addSamplerOption(param1);
      return this;
    }

    public function filter(param1:SamplerFilter) : SamplerRegister {
      this.addSamplerOption(param1);
      return this;
    }

    private function addSamplerOption(param1:SamplerOption) : void {
      this.samplerbits = param1.apply(this.samplerbits);
    }

    override public function writeSource(param1:ByteArray) : void {
      param1.writeShort(index);
      param1.writeShort(0);
      param1.writeUnsignedInt(this.samplerbits);
      this.samplerbits = 5;
    }
  }
}
