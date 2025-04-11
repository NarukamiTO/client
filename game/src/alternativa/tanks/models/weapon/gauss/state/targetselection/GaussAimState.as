package alternativa.tanks.models.weapon.gauss.state.targetselection {
  public class GaussAimState {
    public static const LOCKING:GaussAimState = new GaussAimState("LOCKING");
    public static const CANCELLED:GaussAimState = new GaussAimState("CANCELLED");
    public static const REGAIN_LOCK:GaussAimState = new GaussAimState("REGAIN_LOCK");
    public static const TARET_LOCKED:GaussAimState = new GaussAimState("TARET_LOCKED");
    public static const TARGET_SEARCH:GaussAimState = new GaussAimState("TARGET_SEARCH");

    private var value:String;

    public function GaussAimState(param1:String) {
      super();
      this.value = param1;
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      return this.value;
    }
  }
}
