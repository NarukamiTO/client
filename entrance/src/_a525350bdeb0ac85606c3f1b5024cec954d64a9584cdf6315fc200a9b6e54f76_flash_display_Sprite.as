package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _a525350bdeb0ac85606c3f1b5024cec954d64a9584cdf6315fc200a9b6e54f76_flash_display_Sprite extends Sprite {
    public function _a525350bdeb0ac85606c3f1b5024cec954d64a9584cdf6315fc200a9b6e54f76_flash_display_Sprite() {
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
