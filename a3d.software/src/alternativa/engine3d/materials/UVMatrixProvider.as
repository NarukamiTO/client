package alternativa.engine3d.materials {
  import flash.geom.Matrix;

  public class UVMatrixProvider {
    private var matrix:Matrix = new Matrix();

    public function UVMatrixProvider() {
      super();
    }

    public function getMatrix() : Matrix {
      return this.matrix;
    }
  }
}
