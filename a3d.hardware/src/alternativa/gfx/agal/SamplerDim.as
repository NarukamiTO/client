package alternativa.gfx.agal {
  public class SamplerDim extends SamplerOption {
    private static const SAMPLER_TEXTURE_TYPE_SHIFT:int = 12;

    public static const D2:SamplerDim = new SamplerDim(0);
    public static const CUBE:SamplerDim = new SamplerDim(1);
    public static const D3:SamplerDim = new SamplerDim(2);

    public function SamplerDim(param1:uint) {
      super(param1,SAMPLER_TEXTURE_TYPE_SHIFT);
    }
  }
}
