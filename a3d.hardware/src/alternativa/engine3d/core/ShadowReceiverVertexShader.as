package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class ShadowReceiverVertexShader extends VertexShader {
    public function ShadowReceiverVertexShader(param1:Boolean) {
      super();
      dp4(vt0.x,va0,vc[11]);
      dp4(vt0.y,va0,vc[12]);
      dp4(vt0.z,va0,vc[13]);
      mov(vt0.w,va0);
      dp4(vt1,vt0,vc[15]);
      dp4(vt1.y,vt0,vc[16]);
      mul(vt1.xy,vt1,vc[19]);
      add(v0.xy,vt1,vc[20]);
      dp4(v0.zw,vt0,vc[17]);
      div(vt1.z,vc[14].w,vt0);
      add(vt1.z,vt1,vc[14]);
      mul(vt1.z,vt1,vc[14].x);
      sub(vt1.z,vt1,vc[14].y);
      div(vt1.z,vt1,vc[14].x);
      sub(vt1.z,vt1,vc[14]);
      div(vt1.z,vc[14].w,vt1);
      mov(vt2,vc[20]);
      nrm(vt2.xyz,vt0.xyz);
      sub(vt1.z,vt0,vt1);
      div(vt1.z,vt1,vt2);
      mul(vt2,vt2,vt1.z);
      sub(vt0,vt0,vt2);
      if(param1) {
        mul(vt0.xy,vt0,vc[18]);
        mul(vt1.xy,vc[18].zw,vt0.z);
        add(vt0.xy,vt0,vt1);
      }
      mov(op.xw,vt0.xz);
      neg(op.y,vt0);
      mul(vt0.z,vt0,vc[14]);
      add(op.z,vt0,vc[14].w);
    }
  }
}
