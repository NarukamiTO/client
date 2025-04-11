package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _238f222210817333033b35aa737ba8de257d4df23609f40b2472357f35e07d6c_flash_display_Sprite extends Sprite {
    public function _238f222210817333033b35aa737ba8de257d4df23609f40b2472357f35e07d6c_flash_display_Sprite() {
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
