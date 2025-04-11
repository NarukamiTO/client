package alternativa.tanks.models.weapon.shaft {
  public class ShaftEventType {
    public static const TRIGGER_PULL:ShaftEventType = new ShaftEventType("TRIGGER_PULL");
    public static const TRIGGER_RELEASE:ShaftEventType = new ShaftEventType("TRIGGER_RELEASE");
    public static const STOP:ShaftEventType = new ShaftEventType("STOP");
    public static const READY_TO_SHOOT:ShaftEventType = new ShaftEventType("READY_TO_SHOOT");
    public static const SWITCH:ShaftEventType = new ShaftEventType("SWITCH");
    public static const EXIT:ShaftEventType = new ShaftEventType("EXIT");

    private var value:String;

    public function ShaftEventType(param1:String) {
      super();
      this.value = param1;
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      return this.value;
    }
  }
}
