package alternativa.engine3d.core {
  import alternativa.gfx.agal.FragmentShader;
  import alternativa.gfx.agal.SamplerDim;
  import alternativa.gfx.agal.SamplerFilter;
  import alternativa.gfx.agal.SamplerMipMap;
  import alternativa.gfx.agal.SamplerRepeat;
  import alternativa.gfx.agal.SamplerType;

  public class DepthRendererDepthFragmentShader extends FragmentShader {
    public function DepthRendererDepthFragmentShader(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) {
      var local6:SamplerRepeat = null;
      var local7:SamplerFilter = null;
      var local8:SamplerMipMap = null;
      var local9:SamplerType = null;
      super();
      if(param2) {
        local6 = param4 ? SamplerRepeat.WRAP : SamplerRepeat.CLAMP;
        local7 = param3 ? SamplerFilter.LINEAR : SamplerFilter.NEAREST;
        local8 = param5 ? (param3 ? SamplerMipMap.LINEAR : SamplerMipMap.NEAREST) : SamplerMipMap.NONE;
        local9 = SamplerType.RGBA;
        tex(ft0,v1,fs1.dim(SamplerDim.D2).repeat(local6).filter(local7).mipmap(local8).type(local9));
        sub(ft0.w,ft0,v1);
        kil(ft0.w);
      }
      frc(ft0,v0.z);
      sub(ft0.x,v0.z,ft0);
      mul(ft0.x,ft0,fc[0]);
      if(param1) {
        mov(ft1.zw,fc[0]);
        mov(ft1.xy,v0);
        nrm(ft1.xyz,ft1.xyz);
        mul(ft1.xy,ft1,fc[1]);
        add(ft1.xy,ft1,fc[1]);
        tex(ft2,ft1,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
        mov(ft0.w,ft2.z);
        mul(ft1.xy,v0,v0);
        add(ft1.x,ft1,ft1.y);
        sqt(ft1.x,ft1);
        neg(ft1.y,v0.w);
        mul(ft1.xy,ft1,fc[1]);
        add(ft1.xy,ft1,fc[1]);
        tex(ft2,ft1,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
        mov(ft0.z,ft2.z);
      }
      mov(oc,ft0);
    }
  }
}
