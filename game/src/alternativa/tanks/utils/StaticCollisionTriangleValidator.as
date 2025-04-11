package alternativa.tanks.utils {
  import alternativa.physics.collision.primitives.CollisionTriangle;

  public class StaticCollisionTriangleValidator extends StaticCollisionPrimitiveValidator {
    private var vertexValidator0:Vector3Validator;
    private var vertexValidator1:Vector3Validator;
    private var vertexValidator2:Vector3Validator;

    public function StaticCollisionTriangleValidator(param1:CollisionTriangle) {
      super(param1);
      this.vertexValidator0 = new Vector3Validator(param1.v0);
      this.vertexValidator1 = new Vector3Validator(param1.v1);
      this.vertexValidator2 = new Vector3Validator(param1.v2);
    }

    override public function hasIncorrectData() : Boolean {
      return super.hasIncorrectData() || this.vertexValidator0.isInvalid() || this.vertexValidator1.isInvalid() || this.vertexValidator2.isInvalid();
    }
  }
}
