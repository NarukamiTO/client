package alternativa.tanks.utils {
  import alternativa.physics.collision.primitives.CollisionBox;

  public class StaticCollisionBoxValidator extends StaticCollisionPrimitiveValidator {
    private var vectorValidator:Vector3Validator;

    public function StaticCollisionBoxValidator(param1:CollisionBox) {
      super(param1);
      this.vectorValidator = new Vector3Validator(param1.hs);
    }

    override public function hasIncorrectData() : Boolean {
      return super.hasIncorrectData() || this.vectorValidator.isInvalid();
    }
  }
}
