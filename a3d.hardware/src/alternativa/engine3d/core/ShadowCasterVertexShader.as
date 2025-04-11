package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class ShadowCasterVertexShader extends VertexShader {
    public function ShadowCasterVertexShader() {
      super();
      dp4(vt0.x,va0,vc[0]);
      dp4(vt0.y,va0,vc[1]);
      dp4(vt0.zw,va0,vc[2]);
      mul(vt0.xy,vt0,vc[3]);
      add(vt0.xy,vt0,vc[4]);
      mov(op.xyz,vt0);
      mov(op.w,vc[3]);
      mov(v0,vt0);
    }
  }
}
