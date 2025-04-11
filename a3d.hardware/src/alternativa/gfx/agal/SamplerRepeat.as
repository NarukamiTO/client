package alternativa.gfx.agal {
  public class SamplerRepeat extends SamplerOption {
    private static const SAMPLER_REPEAT_SHIFT:uint = 20;

    public static const CLAMP:SamplerRepeat = new SamplerRepeat(0);
    public static const REPEAT:SamplerRepeat = new SamplerRepeat(1);
    public static const WRAP:SamplerRepeat = REPEAT;

    public function SamplerRepeat(param1:uint) {
      super(param1,SAMPLER_REPEAT_SHIFT);
    }
  }
}
