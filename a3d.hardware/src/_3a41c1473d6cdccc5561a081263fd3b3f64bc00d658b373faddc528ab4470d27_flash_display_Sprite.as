package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _3a41c1473d6cdccc5561a081263fd3b3f64bc00d658b373faddc528ab4470d27_flash_display_Sprite extends Sprite {
    public function _3a41c1473d6cdccc5561a081263fd3b3f64bc00d658b373faddc528ab4470d27_flash_display_Sprite() {
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
