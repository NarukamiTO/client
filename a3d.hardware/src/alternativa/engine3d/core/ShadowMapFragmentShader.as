package alternativa.engine3d.core {
  import alternativa.gfx.agal.FragmentShader;
  import alternativa.gfx.agal.SamplerDim;
  import alternativa.gfx.agal.SamplerFilter;
  import alternativa.gfx.agal.SamplerMipMap;
  import alternativa.gfx.agal.SamplerRepeat;

  public class ShadowMapFragmentShader extends FragmentShader {
    public function ShadowMapFragmentShader(param1:Boolean) {
      super();
      if(param1) {
        tex(ft0,v1,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.LINEAR).mipmap(SamplerMipMap.NONE));
        sub(ft0.w,ft0,v1);
        kil(ft0.w);
      }
      frc(ft0,v0.z);
      sub(ft0.x,v0.z,ft0);
      mul(ft0.x,ft0,fc[0]);
      mov(ft0.zw,fc[0]);
      mov(oc,ft0);
    }
  }
}
