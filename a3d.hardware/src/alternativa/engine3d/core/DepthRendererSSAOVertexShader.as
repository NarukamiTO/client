package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class DepthRendererSSAOVertexShader extends VertexShader {
    public function DepthRendererSSAOVertexShader() {
      super();
      mov(op,va0);
      mov(v0,va1);
      mul(v1,va1,vc[0]);
      mul(vt1,va1,vc[1]);
      sub(v2,vt1,vc[2]);
    }
  }
}
