package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _fdfea708716e61412b5eb06a2b47e0d0ff96589e1b683dee5d4bba149e1024cb_flash_display_Sprite extends Sprite {
    public function _fdfea708716e61412b5eb06a2b47e0d0ff96589e1b683dee5d4bba149e1024cb_flash_display_Sprite() {
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
