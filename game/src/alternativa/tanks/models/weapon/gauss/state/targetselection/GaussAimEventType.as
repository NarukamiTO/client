package alternativa.tanks.models.weapon.gauss.state.targetselection {
  public class GaussAimEventType {
    public static const RESET:GaussAimEventType = new GaussAimEventType("RESET");
    public static const DEACTIVATED:GaussAimEventType = new GaussAimEventType("DEACTIVATED");
    public static const TARGET_LOCKED:GaussAimEventType = new GaussAimEventType("TARGET_LOCKED");
    public static const TARGET_FOUND:GaussAimEventType = new GaussAimEventType("TARGET_FOUND");
    public static const TARGET_LOCK_FAILED:GaussAimEventType = new GaussAimEventType("TARGET_LOCK_FAILED");
    public static const TARGET_LOCK_LOST:GaussAimEventType = new GaussAimEventType("TARGET_LOCK_LOST");

    private var value:String;

    public function GaussAimEventType(param1:String) {
      super();
      this.value = param1;
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      return this.value;
    }
  }
}
