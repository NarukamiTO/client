package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _5fc0df178728dad553371bcea27a733a7b0b89a68d2e5f64332b5ba8ed8d2bef_flash_display_Sprite extends Sprite {
    public function _5fc0df178728dad553371bcea27a733a7b0b89a68d2e5f64332b5ba8ed8d2bef_flash_display_Sprite() {
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
