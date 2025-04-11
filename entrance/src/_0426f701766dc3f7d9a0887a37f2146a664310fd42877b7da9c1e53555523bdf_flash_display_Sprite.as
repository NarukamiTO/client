package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _0426f701766dc3f7d9a0887a37f2146a664310fd42877b7da9c1e53555523bdf_flash_display_Sprite extends Sprite {
    public function _0426f701766dc3f7d9a0887a37f2146a664310fd42877b7da9c1e53555523bdf_flash_display_Sprite() {
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
