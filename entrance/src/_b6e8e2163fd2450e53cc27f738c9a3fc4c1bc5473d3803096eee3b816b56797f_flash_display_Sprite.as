package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _b6e8e2163fd2450e53cc27f738c9a3fc4c1bc5473d3803096eee3b816b56797f_flash_display_Sprite extends Sprite {
    public function _b6e8e2163fd2450e53cc27f738c9a3fc4c1bc5473d3803096eee3b816b56797f_flash_display_Sprite() {
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
