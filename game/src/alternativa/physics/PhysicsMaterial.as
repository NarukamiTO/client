package alternativa.physics {
  public class PhysicsMaterial {
    public static const DEFAULT_MATERIAL:PhysicsMaterial = new PhysicsMaterial();

    public var restitution:Number;
    public var friction:Number;

    public function PhysicsMaterial(param1:Number = 0, param2:Number = 0.3) {
      super();
      this.restitution = param1;
      this.friction = param2;
    }
  }
}
