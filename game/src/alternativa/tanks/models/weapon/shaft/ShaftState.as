package alternativa.tanks.models.weapon.shaft {
  public class ShaftState {
    public static const IDLE:ShaftState = new ShaftState(1);
    public static const READY_TO_SHOOT:ShaftState = new ShaftState(2);
    public static const MANUAL_TARGETING_ACTIVATION:ShaftState = new ShaftState(3);
    public static const MANUAL_TARGETING:ShaftState = new ShaftState(4);

    private var value:int;

    public function ShaftState(param1:int) {
      super();
      this.value = param1;
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      return this.value.toString();
    }
  }
}
