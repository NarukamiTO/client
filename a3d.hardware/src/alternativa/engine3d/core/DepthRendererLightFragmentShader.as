package alternativa.engine3d.core {
  import alternativa.gfx.agal.FragmentShader;
  import alternativa.gfx.agal.SamplerDim;
  import alternativa.gfx.agal.SamplerFilter;
  import alternativa.gfx.agal.SamplerMipMap;
  import alternativa.gfx.agal.SamplerRepeat;

  public class DepthRendererLightFragmentShader extends FragmentShader {
    public function DepthRendererLightFragmentShader(param1:int) {
      super();
      div(ft4,v0,v0.z);
      mul(ft4,ft4,fc[4]);
      add(ft4,ft4,fc[4]);
      tex(ft0,ft4,fs0.dim(SamplerDim.D2).repeat(SamplerRepeat.CLAMP).filter(SamplerFilter.NEAREST).mipmap(SamplerMipMap.NONE));
      mul(ft0.zw,ft0,fc[6]);
      cos(ft1,ft0);
      sin(ft2,ft0);
      mul(ft1.x,ft1.w,ft1.z);
      mul(ft1.y,ft2.w,ft1.z);
      neg(ft1.z,ft2);
      dp3(ft2.z,ft0,fc[0]);
      mul(ft2.xy,ft4,fc[1]);
      sub(ft2.xy,ft2,fc[2]);
      mul(ft2.xy,ft2,ft2.z);
      mul(ft2.xy,ft2,fc[3]);
      if(param1 == 0) {
        sub(ft3,v1,ft2);
        dp3(ft3.w,ft3,ft3);
        sqt(ft3.w,ft3);
        div(ft3.xyz,ft3,ft3.w);
        sub(ft3.w,v1,ft3);
        mul(ft3.w,ft3,v2);
        sat(ft3.w,ft3);
        mul(ft3.w,ft3,ft3);
        dp3(ft2.w,ft3,ft1);
        max(ft2.w,ft2,fc[4]);
        mul(ft3.w,ft3,ft2);
        mul(ft0.xyz,v2,ft3.w);
      } else {
        if(param1 == 1) {
          sub(ft3,v1,ft2);
          dp3(ft3.w,ft3,ft3);
          sqt(ft3.w,ft3);
          div(ft3.xyz,ft3,ft3.w);
          sub(ft3.w,v3.x,ft3);
          mul(ft3.w,ft3,v3.y);
          sat(ft3.w,ft3);
          mul(ft3.w,ft3,ft3);
          dp3(ft4.w,ft3,ft1);
          max(ft4.w,ft4,fc[4]);
          mul(ft3.w,ft3,ft4);
          dp3(ft4.w,ft3,v2);
          neg(ft4.w,ft4);
          sub(ft4.w,ft4,v3.z);
          mul(ft4.w,ft4,v3);
          sat(ft4.w,ft4);
          mul(ft4.w,ft4,ft4);
          mul(ft3.w,ft3,ft4);
        } else if(param1 == 2) {
          sub(ft4,ft2,v1);
          dp3(ft4.w,ft4,v2);
          mul(ft4.xyz,v2,ft4.w);
          add(ft4.xyz,v1,ft4);
          abs(ft4.w,ft4);
          sub(ft4.w,v3.z,ft4);
          mul(ft4.w,ft4,v3);
          sat(ft4.w,ft4);
          mul(ft4.w,ft4,ft4);
          sub(ft3,ft4,ft2);
          dp3(ft3.w,ft3,ft3);
          sqt(ft3.w,ft3);
          div(ft3.xyz,ft3,ft3.w);
          sub(ft3.w,v3.x,ft3);
          mul(ft3.w,ft3,v3.y);
          sat(ft3.w,ft3);
          mul(ft3.w,ft3,ft3);
          mul(ft3.w,ft3,ft4);
          dp3(ft4.w,ft3,ft1);
          max(ft4.w,ft4,fc[4]);
          mul(ft3.w,ft3,ft4);
        }
        mul(ft0.xyz,v4,ft3.w);
      }
      mov(oc,ft0);
    }
  }
}
