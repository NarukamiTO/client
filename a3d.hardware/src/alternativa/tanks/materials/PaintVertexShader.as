package alternativa.tanks.materials {
  import alternativa.gfx.agal.VertexShader;

  public class PaintVertexShader extends VertexShader {
    public function PaintVertexShader(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) {
      super();
      mov(vt0,vc[4]);
      if(param1) {
        dp4(vt0.x,va0,vc[0]);
        dp4(vt0.y,va0,vc[1]);
        dp4(vt0.z,va0,vc[2]);
        mul(v0,va1,vc[4]);
        mov(vt1,vc[4]);
        dp3(vt1.x,va1,vc[14]);
        dp3(vt1.y,va1,vc[15]);
        add(vt1.x,vt1.x,vc[14].z);
        add(vt1.y,vt1.y,vc[15].z);
        mov(v6,vt1);
      } else {
        mov(vt0.xyz,cc.rel(va0.x,0));
        mov(vt1,cc.rel(va0.x,1));
        mul(v0,vt1,vc[4]);
        mov(vt2,vc[4]);
        dp3(vt2.x,vt1,vc[14]);
        dp3(vt2.y,vt1,vc[15]);
        add(vt2.x,vt2.x,vc[14].z);
        add(vt2.y,vt2.y,vc[15].z);
        mov(v6,vt2);
      }
      if(param2 || param3) {
        mov(v1,vt0);
      }
      if(param3) {
        if(param1) {
          if(param4) {
            mul(vt1,va2,vc[11]);
            nrm(vt1.xyz,vt1.xyz);
            div(vt1,vt1,vc[11]);
          } else {
            mov(vt1,vc[4]);
            dp3(vt1.x,va2,vc[0]);
            dp3(vt1.y,va2,vc[1]);
            dp3(vt1.z,va2,vc[2]);
          }
        } else {
          mov(vt2,vc[4]);
          mov(vt2.x,cc.rel(va0.x,0).w);
          mov(vt2.y,cc.rel(va0.x,1).z);
          mov(vt2.z,cc.rel(va0.x,1).w);
          if(param4) {
            mul(vt1,vt2,vc[11]);
            nrm(vt1.xyz,vt1.xyz);
            div(vt1,vt1,vc[11]);
          } else {
            mov(vt1,vc[4]);
            dp3(vt1.x,vt2,vc[0]);
            dp3(vt1.y,vt2,vc[1]);
            dp3(vt1.z,vt2,vc[2]);
          }
        }
        dp3(vt1.w,vt1,vc[10]);
        if(param4) {
          sub(vt1.w,vc[4],vt1);
          mul(v1.w,vt1,vc[11]);
        } else {
          sub(v1.w,vc[4],vt1);
        }
      } else if(param5 || param6 || param9 || param10) {
        mov(vt1,vc[4]);
      }
      if(param5) {
        dp4(v2.x,vt0,vc[6]);
        dp4(v2.y,vt0,vc[7]);
        dp4(v2.z,vt0,vc[8]);
        sub(vt1.w,vt0.z,vc[9].x);
        div(vt1.w,vt1,vc[9].y);
        sub(v2.w,vc[4],vt1);
      }
      if(param6) {
        sub(vt1.w,vt0.z,vc[5].z);
        div(v0.w,vt1,vc[5]);
      }
      if(param8) {
        mov(vt1,vt0);
        mul(vt1.x,vt1,vc[11].w);
        mul(vt1.y,vt1,vc[12].w);
        sub(vt1,vt1,vc[11]);
        dp3(v0.z,vt1,vc[12]);
      }
      if(param7) {
        mul(vt0.xyz,vt0,vc[11]);
      }
      if(param9) {
        div(vt1.z,vc[3].w,vt0);
        add(vt1.z,vt1,vc[3]);
        mul(vt1.z,vt1,vc[3].x);
        sub(vt1.z,vt1,vc[3].y);
        div(vt1.z,vt1,vc[3].x);
        sub(vt1.z,vt1,vc[3]);
        div(vt1.z,vc[3].w,vt1);
        mov(vt2,vc[4]);
        nrm(vt2.xyz,vt0.xyz);
        sub(vt1.z,vt0,vt1);
        div(vt1.z,vt1,vt2);
        mul(vt2,vt2,vt1.z);
        sub(vt0,vt0,vt2);
      }
      if(param10) {
        mul(vt0.xy,vt0,vc[13]);
        mul(vt1.xy,vc[13].zw,vt0.z);
        add(vt0.xy,vt0,vt1);
      }
      mov(op.xw,vt0.xz);
      neg(op.y,vt0);
      mul(vt0.z,vt0,vc[3]);
      add(op.z,vt0,vc[3].w);
    }
  }
}
