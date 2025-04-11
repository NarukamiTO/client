package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _f3b35188059f43bd61a48d98d997dccf3bfc6b0156e2e3f922ca9ae54ca44023_flash_display_Sprite extends Sprite {
    public function _f3b35188059f43bd61a48d98d997dccf3bfc6b0156e2e3f922ca9ae54ca44023_flash_display_Sprite() {
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
