package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class ShadowAtlasVertexShader extends VertexShader {
    public function ShadowAtlasVertexShader() {
      super();
      mov(op,va0);
      mov(v0,va1);
    }
  }
}
