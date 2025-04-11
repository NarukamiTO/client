package alternativa.tanks.models.weapon.gauss.state {
  public class GaussState {
    public static const IDLE:GaussState = new GaussState("IDLE");
    public static const RELOAD:GaussState = new GaussState("RELOAD");
    public static const STUNNED:GaussState = new GaussState("STUNNED");
    public static const POWER_SHOT:GaussState = new GaussState("POWER_SHOT");
    public static const SIMPLE_SHOT:GaussState = new GaussState("SIMPLE_SHOT");
    public static const RELOAD_PAUSE:GaussState = new GaussState("RELOAD_PAUSE");
    public static const MODE_SELECTION:GaussState = new GaussState("MODE_SELECTION");
    public static const TARGET_SELECTION:GaussState = new GaussState("TARGET_SELECTION");

    private var value:String;

    public function GaussState(param1:String) {
      super();
      this.value = param1;
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      return this.value;
    }
  }
}
