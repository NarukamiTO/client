package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _b586ca323260c087df6ad1069221fd3ed2014a9e5a2637f97a93c0588f0a9046_flash_display_Sprite extends Sprite {
    public function _b586ca323260c087df6ad1069221fd3ed2014a9e5a2637f97a93c0588f0a9046_flash_display_Sprite() {
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
