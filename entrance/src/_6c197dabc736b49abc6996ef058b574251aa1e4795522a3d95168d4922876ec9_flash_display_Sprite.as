package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _6c197dabc736b49abc6996ef058b574251aa1e4795522a3d95168d4922876ec9_flash_display_Sprite extends Sprite {
    public function _6c197dabc736b49abc6996ef058b574251aa1e4795522a3d95168d4922876ec9_flash_display_Sprite() {
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
