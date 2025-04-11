package alternativa.tanks.models.weapon.gauss {
  public class GaussEventType {
    public static const RESET:GaussEventType = new GaussEventType("RESET");
    public static const STUNNED:GaussEventType = new GaussEventType("STUNNED");
    public static const STUN_EXPIRED:GaussEventType = new GaussEventType("STUN_EXPIRED");
    public static const BUFFED:GaussEventType = new GaussEventType("BUFFED");
    public static const BUFF_EXPIRED:GaussEventType = new GaussEventType("BUFF_EXPIRED");
    public static const ACTIVATED:GaussEventType = new GaussEventType("ACTIVATION");
    public static const DEACTIVATED:GaussEventType = new GaussEventType("DEACTIVATION");
    public static const RELOAD_COMPLETED:GaussEventType = new GaussEventType("RELOAD_COMPLETED");
    public static const SIMPLE_SHOT:GaussEventType = new GaussEventType("SIMPLE_SHOT");
    public static const TARGET_SEARCH_STARTED:GaussEventType = new GaussEventType("TARGET_SEARCH_STARTED");
    public static const TARGET_LOCKED:GaussEventType = new GaussEventType("TARGET_LOCKED");
    public static const RELOAD:GaussEventType = new GaussEventType("RELOAD");

    private var value:String;

    public function GaussEventType(param1:String) {
      super();
      this.value = param1;
    }

    [Obfuscation(rename="false")]
    public function toString() : String {
      return this.value;
    }
  }
}
