package alternativa.tanks.bonuses {
  public class BonusConst {
    public static const BONUS_HALF_SIZE:Number = 75;
    public static const COS_ONE_DEGREE:Number = Math.cos(Math.PI / 180);
    public static const PARACHUTE_OFFSET_Z:Number = 50;
    public static const BONUS_OFFSET_Z:Number = 450;
    public static const ANGULAR_SPEED_Z:Number = 0.1;
    public static const BOUND_SPHERE_RADIUS:Number = Math.sqrt(2) * BONUS_HALF_SIZE * 1.6;

    public function BonusConst() {
      super();
    }
  }
}
