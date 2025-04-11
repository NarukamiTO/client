package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _00c3961a998da121dd1fef7aa674e2095bee87007976935d0dd2e4d0485d6e79_flash_display_Sprite extends Sprite {
    public function _00c3961a998da121dd1fef7aa674e2095bee87007976935d0dd2e4d0485d6e79_flash_display_Sprite() {
      super();
    }

    public function allowDomainInRSL(... rest) : void {
      Security.allowDomain(rest);
    }

    public function allowInsecureDomainInRSL(... rest) : void {
      Security.allowInsecureDomain(rest);
    }
  }
}
