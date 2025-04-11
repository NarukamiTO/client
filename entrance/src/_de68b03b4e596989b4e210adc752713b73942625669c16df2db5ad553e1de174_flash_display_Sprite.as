package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _de68b03b4e596989b4e210adc752713b73942625669c16df2db5ad553e1de174_flash_display_Sprite extends Sprite {
    public function _de68b03b4e596989b4e210adc752713b73942625669c16df2db5ad553e1de174_flash_display_Sprite() {
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
