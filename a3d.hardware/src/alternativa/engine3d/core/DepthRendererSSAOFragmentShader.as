package alternativa.engine3d.core {
  import alternativa.gfx.agal.FragmentShader;
  import alternativa.gfx.agal.SamplerDim;
  import alternativa.gfx.agal.SamplerFilter;
  import alternativa.gfx.agal.SamplerMipMap;
  import alternativa.gfx.agal.SamplerRepeat;

  public class DepthRendererSSAOFragmentShader extends FragmentShader {
    public function DepthRendererSSAOFragmentShader(param1:int) {
      super();
      tex(ft0,v0,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      mul(ft0.zw,ft0,fc[6]);
      cos(ft1,ft0);
      sin(ft2,ft0);
      mul(ft1.x,ft1.w,ft1.z);
      mul(ft1.y,ft2.w,ft1.z);
      neg(ft1.z,ft2);
      dp3(ft2.z,ft0,fc[0]);
      mul(ft2.xy,v2,ft2.z);
      tex(ft3,v1,fs1.dim(SamplerDim.D2).repeat(SamplerRepeat.WRAP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      mul(ft3.z,ft3,fc[1]);
      mul(ft3,ft3.z,ft3);
      var local2:int = 0;
      while(local2 < param1) {
        if(local2 > 0) {
          if(local2 % 2 > 0) {
            dp3(ft6,ft3,fc[4]);
            dp3(ft6.y,ft3,fc[5]);
          } else {
            dp3(ft3.x,ft6,fc[4]);
            dp3(ft3.y,ft6,fc[5]);
          }
        }
        if(local2 % 2 > 0) {
          div(ft4,ft6,fc[3]);
        } else {
          div(ft4,ft3,fc[3]);
        }
        div(ft4,ft4,ft2.z);
        div(ft4,ft4,fc[1]);
        add(ft4,v0,ft4);
        min(ft5,ft4,fc[6]);
        tex(ft5,ft5,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
        dp3(ft5.z,ft5,fc[0]);
        mul(ft5.xy,ft4,fc[1]);
        sub(ft5.xy,ft5,fc[2]);
        mul(ft5.xy,ft5,ft5.z);
        sub(ft5,ft5,ft2);
        mul(ft5,ft5,fc[3]);
        dp3(ft5.w,ft5,ft5);
        sqt(ft5.w,ft5);
        div(ft5.xyz,ft5,ft5.w);
        mul(ft5.w,ft5,fc[3]);
        sub(ft5.w,fc[1],ft5);
        max(ft5.w,ft5,fc[4]);
        dp3(ft5.z,ft5,ft1);
        sub(ft5.z,ft5,fc[2]);
        max(ft5.z,ft5,fc[0]);
        mul(ft5.w,ft5,ft5.z);
        if(local2 == 0) {
          mov(ft0.w,ft5);
        } else {
          add(ft0.w,ft0,ft5);
        }
        local2++;
      }
      mul(ft0.w,ft0,fc[2]);
      mov(oc,ft0);
    }
  }
}
