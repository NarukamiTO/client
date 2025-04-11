package alternativa.engine3d.core {
  import alternativa.gfx.agal.FragmentShader;
  import alternativa.gfx.agal.SamplerDim;
  import alternativa.gfx.agal.SamplerFilter;
  import alternativa.gfx.agal.SamplerMipMap;
  import alternativa.gfx.agal.SamplerRepeat;

  public class DepthRendererBlurFragmentShader extends FragmentShader {
    public function DepthRendererBlurFragmentShader() {
      super();
      mov(ft1,v0);
      tex(ft0,ft1,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      sub(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      sub(ft1.x,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.x,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.x,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.x,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      sub(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      sub(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      sub(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      sub(ft1.x,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      add(ft1.y,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      sub(ft1.x,ft1,fc[0]);
      min(ft2,ft1,fc[1]);
      tex(ft2,ft2,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      add(ft0.w,ft0,ft2);
      mul(ft0.w,ft0,fc[0]);
      mov(oc,ft0);
    }
  }
}
