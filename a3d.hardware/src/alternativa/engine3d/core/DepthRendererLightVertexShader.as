package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class DepthRendererLightVertexShader extends VertexShader {
    public function DepthRendererLightVertexShader(param1:int) {
      super();
      if(param1 == 0) {
        mov(vt1,cc.rel(va1.x,0));
        mov(v1,vt1);
        mov(v2,cc.rel(va1.x,1));
        mul(vt0,va0,vt1.w);
        add(vt0,vt0,vt1);
        div(vt0.xy,vt0,vc[3]);
      } else {
        mov(vt2,cc.rel(va1.y,0));
        mov(vt3,cc.rel(va1.y,1));
        mov(vt4,cc.rel(va1.y,2));
        mov(vt5,cc.rel(va1.y,3));
        mov(vt6,cc.rel(va1.y,4));
        if(param1 == 1) {
          mul(v1.x,vt2.w,vc[3]);
          mul(v1.y,vt3.w,vc[3]);
          mov(v1.zw,vt4.w);
          mul(v2.x,vt2.z,vc[3]);
          mul(v2.y,vt3.z,vc[3]);
          mov(v2.zw,vt4.z);
          mov(v3,vt5);
          mov(v4,vt6);
          mul(vt0,va0,vt6.w);
          mul(vt0.z,va0,vt5.x);
          add(vt0.z,vt0,vt5.x);
          mul(vt0.z,vt0,vc[3].w);
        } else if(param1 == 2) {
          mul(vt0.x,vt2.z,vc[3]);
          mul(vt0.y,vt3.z,vc[3]);
          mov(vt0.zw,vt4.z);
          mov(v2,vt0);
          mul(vt1.x,vt2.w,vc[3]);
          mul(vt1.y,vt3.w,vc[3]);
          mov(vt1.zw,vt4.w);
          mul(vt0,vt0,vt6.w);
          add(v1,vt1,vt0);
          mov(v3,vt5);
          mov(v4,vt6);
          mul(vt0.xy,va0,vt5.x);
          mul(vt0.z,va0,vt5);
          add(vt0.z,vt0,vt6.w);
        }
        mov(vt0.w,vc[1]);
        dp4(vt1.x,vt0,vt2);
        dp4(vt1.y,vt0,vt3);
        dp4(vt1.z,vt0,vt4);
        mov(vt0.xyz,vt1.xyz);
      }
      mul(vt0.xy,vt0,vc[1]);
      mul(vt1,vc[2],vt0.z);
      sub(vt0.xy,vt0,vt1);
      mov(v0,vt0);
      mov(op.xw,vt0.xz);
      neg(op.y,vt0);
      mul(vt0.z,vt0,vc[0]);
      add(op.z,vt0,vc[0].w);
    }
  }
}
