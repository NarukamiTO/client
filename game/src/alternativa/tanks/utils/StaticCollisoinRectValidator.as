package alternativa.tanks.utils {
  import alternativa.physics.collision.primitives.CollisionRect;

  public class StaticCollisoinRectValidator extends StaticCollisionPrimitiveValidator {
    private var vectorValidator:Vector3Validator;

    public function StaticCollisoinRectValidator(param1:CollisionRect) {
      super(param1);
      this.vectorValidator = new Vector3Validator(param1.hs);
    }

    override public function hasIncorrectData() : Boolean {
      return super.hasIncorrectData() || this.vectorValidator.isInvalid();
    }
  }
}
