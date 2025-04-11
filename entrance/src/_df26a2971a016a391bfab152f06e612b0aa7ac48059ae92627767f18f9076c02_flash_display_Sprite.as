package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _df26a2971a016a391bfab152f06e612b0aa7ac48059ae92627767f18f9076c02_flash_display_Sprite extends Sprite {
    public function _df26a2971a016a391bfab152f06e612b0aa7ac48059ae92627767f18f9076c02_flash_display_Sprite() {
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
