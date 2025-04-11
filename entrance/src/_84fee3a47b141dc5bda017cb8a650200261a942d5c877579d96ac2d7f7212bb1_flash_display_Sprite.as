package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _84fee3a47b141dc5bda017cb8a650200261a942d5c877579d96ac2d7f7212bb1_flash_display_Sprite extends Sprite {
    public function _84fee3a47b141dc5bda017cb8a650200261a942d5c877579d96ac2d7f7212bb1_flash_display_Sprite() {
      super();
    }

    public function allowDomainInRSL(... rest) : void {
      Security.allowDomain.apply(null,rest);
    }

    public function allowInsecureDomainInRSL(... rest) : void {
      Security.allowInsecureDomain.apply(null,rest);
    }
  }
}
