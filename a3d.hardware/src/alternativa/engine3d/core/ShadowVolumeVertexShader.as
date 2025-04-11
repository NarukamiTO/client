package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class ShadowVolumeVertexShader extends VertexShader {
    public function ShadowVolumeVertexShader() {
      super();
      mul(vt1,va0,vc[14]);
      add(vt1.xyz,vt1,vc[15]);
      dp4(vt0.x,vt1,vc[11]);
      dp4(vt0.y,vt1,vc[12]);
      dp4(vt0.z,vt1,vc[13]);
      mov(vt0.w,vt1);
      mul(vt0.xy,vt0,vc[17]);
      mul(vt1.xy,vc[17].zw,vt0.z);
      add(vt0.xy,vt0,vt1);
      mov(op.xw,vt0.xz);
      neg(op.y,vt0);
      mul(vt0.z,vt0,vc[16]);
      add(op.z,vt0,vc[16].w);
    }
  }
}
