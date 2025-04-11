package alternativa.gfx.agal {
  public class SamplerSpecial extends SamplerOption {
    private static const SAMPLER_SPECIAL_SHIFT:uint = 16;

    public static const CENTROID:SamplerSpecial = new SamplerSpecial(1);
    public static const SINGLE:SamplerSpecial = new SamplerSpecial(2);
    public static const IGNORESAMPLER:SamplerSpecial = new SamplerSpecial(4);

    public function SamplerSpecial(param1:int) {
      super(param1,SAMPLER_SPECIAL_SHIFT);
    }

    override public function apply(param1:int) : int {
      return param1 | uint(mask) << uint(flag);
    }
  }
}
