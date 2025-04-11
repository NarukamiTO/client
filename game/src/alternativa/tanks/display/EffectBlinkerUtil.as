package alternativa.tanks.display {
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.sfx.Blinker;

  public class EffectBlinkerUtil {
    public static const EFFECT_WARNING_PERIOD:int = 3000;
    public static const FIRST_AID_WARNING_PERIOD:int = 100000;
    public static const INITIAL_BLINK_INTERVAL:int = 300;
    public static const MIN_INTERVAL:int = 20;
    public static const BLINK_INTERVAL_DECREMENT:int = 30;
    public static const FIRST_AID_BLINK_INTERVAL_DECREMENT:int = 0;
    public static const MIN_VALUE:Number = 0.2;
    public static const MAX_VALUE:Number = 1;
    public static const SPEED_COEFF:Number = 10;

    public function EffectBlinkerUtil() {
      super();
    }

    public static function createBlinker(param1:int) : Blinker {
      var local7:int = 0;
      var local2:int = EffectBlinkerUtil.INITIAL_BLINK_INTERVAL;
      var local3:int = EffectBlinkerUtil.MIN_INTERVAL;
      var local4:Number = EffectBlinkerUtil.MIN_VALUE;
      var local5:Number = EffectBlinkerUtil.MAX_VALUE;
      var local6:Number = EffectBlinkerUtil.SPEED_COEFF;
      if(param1 == InventoryItemType.FIRST_AID) {
        local7 = EffectBlinkerUtil.FIRST_AID_BLINK_INTERVAL_DECREMENT;
      } else {
        local7 = EffectBlinkerUtil.BLINK_INTERVAL_DECREMENT;
      }
      return new Blinker(local2,local3,local7,local4,local5,local6);
    }

    public static function getBlinkingPeriod(param1:int) : int {
      if(param1 == InventoryItemType.FIRST_AID) {
        return EffectBlinkerUtil.FIRST_AID_WARNING_PERIOD;
      }
      return EffectBlinkerUtil.EFFECT_WARNING_PERIOD;
    }
  }
}
