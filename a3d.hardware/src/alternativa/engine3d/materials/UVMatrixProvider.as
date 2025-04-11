package alternativa.engine3d.materials {
  import flash.geom.Matrix;

  public class UVMatrixProvider {
    private var matrixValues:Vector.<Number> = new Vector.<Number>(8);
    private var matrix:Matrix = new Matrix();

    public function UVMatrixProvider() {
      super();
    }

    public function getMatrix() : Matrix {
      return this.matrix;
    }

    public function getValues() : Vector.<Number> {
      var local1:Matrix = this.getMatrix();
      this.matrixValues[0] = local1.a;
      this.matrixValues[1] = local1.b;
      this.matrixValues[2] = local1.tx;
      this.matrixValues[3] = 0;
      this.matrixValues[4] = local1.c;
      this.matrixValues[5] = local1.d;
      this.matrixValues[6] = local1.ty;
      this.matrixValues[7] = 0;
      return this.matrixValues;
    }
  }
}
