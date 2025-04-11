package alternativa.physics {
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;

  public class BodyState {
    public var velocity:Vector3 = new Vector3();
    public var orientation:Quaternion = new Quaternion();
    public var angularVelocity:Vector3 = new Vector3();
    public var position:Vector3 = new Vector3();

    public function BodyState() {
      super();
    }

    public function copy(param1:BodyState) : void {
      this.position.copy(param1.position);
      this.orientation.copy(param1.orientation);
      this.velocity.copy(param1.velocity);
      this.angularVelocity.copy(param1.angularVelocity);
    }

    public function isValid() : Boolean {
      return this.velocity.isFiniteVector() && this.angularVelocity.isFiniteVector() && this.position.isFiniteVector() && this.orientation.isFiniteQuaternion();
    }

    public function toString() : String {
      return "BodyState{velocity=" + String(this.velocity) + ",position=" + String(this.position) + "}";
    }
  }
}
