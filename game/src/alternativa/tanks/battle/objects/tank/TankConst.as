package alternativa.tanks.battle.objects.tank {
  public class TankConst {
    public static const RAY_OFFSET:Number = 10;
    public static const NUM_RAYS_PER_TRACK:int = 5;
    public static const MAX_SLOPE_ANGLE:Number = Math.PI / 3;
    public static const MAX_SLOPE_ANGLE_COS:Number = Math.cos(MAX_SLOPE_ANGLE);

    public function TankConst() {
      super();
    }
  }
}
