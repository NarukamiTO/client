package alternativa.engine3d.core {
  import alternativa.gfx.agal.VertexShader;

  public class ShadowMapVertexShader extends VertexShader {
    public function ShadowMapVertexShader(param1:Boolean, param2:Boolean) {
      super();
      if(param2) {
        mov(vt0,cc.rel(va0.x,0));
        mov(v0,vt0);
        mul(vt0.z,vt0,vc[8]);
        mov(op,vt0);
        if(param1) {
          mov(vt0,vc[10]);
          mul(v1,cc.rel(va0.x,1),vt0);
        }
      } else {
        mov(vt0,vc[3]);
        dp4(vt0.x,va0,vc[0]);
        dp4(vt0.y,va0,vc[1]);
        dp4(vt0.z,va0,vc[2]);
        mov(v0,vt0);
        mul(vt0.z,vt0,vc[3]);
        mov(op,vt0);
        if(param1) {
          mul(v1,va1,vc[10]);
        }
      }
    }
  }
}
