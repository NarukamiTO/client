package alternativa.gfx.agal {
  public class SamplerType extends SamplerOption {
    private static const SAMPLER_TYPE_SHIFT:uint = 8;

    public static const RGBA:SamplerType = new SamplerType(0);
    public static const DXT1:SamplerType = new SamplerType(1);
    public static const DXT5:SamplerType = new SamplerType(2);
    public static const VIDEO:SamplerType = new SamplerType(3);

    public function SamplerType(param1:int) {
      super(param1,SAMPLER_TYPE_SHIFT);
    }
  }
}
