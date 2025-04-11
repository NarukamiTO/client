package alternativa.tanks.battle.scene3d {
  public class CameraFovCalculator {
    private static const NARROW_SCREEN:Number = 12;
    private static const WIDE_SCREEN:Number = 16;
    private static const DIVIDER:Number = 9;
    private static const DEFAULT_FOV:Number = Math.PI / 2;

    public function CameraFovCalculator() {
      super();
    }

    public static function getCameraFov(param1:Number, param2:Number) : Number {
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local3:Number = param2 / DIVIDER;
      var local4:Number = param1 / local3;
      if(local4 <= NARROW_SCREEN) {
        return DEFAULT_FOV;
      }
      local5 = local4 - (WIDE_SCREEN - NARROW_SCREEN);
      if(local5 < NARROW_SCREEN) {
        local5 = NARROW_SCREEN;
      }
      local6 = local5 * local3;
      local7 = Math.sqrt(local6 * local6 + param2 * param2) * 0.5 / Math.tan(DEFAULT_FOV * 0.5);
      return Math.atan(Math.sqrt(param1 * param1 + param2 * param2) * 0.5 / local7) * 2;
    }
  }
}
