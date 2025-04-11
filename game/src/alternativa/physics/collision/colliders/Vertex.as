package alternativa.physics.collision.colliders {
  import alternativa.math.Vector3;

  public class Vertex {
    public const local:Vector3 = new Vector3();
    public const global:Vector3 = new Vector3();
    public const transformed:Vector3 = new Vector3();

    public function Vertex() {
      super();
    }
  }
}
