package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _dbd5cbcb7832eb74d81473f352b0cc6ace96ad6c2a24d4f9c0fdbdd751f0b292_flash_display_Sprite extends Sprite {
    public function _dbd5cbcb7832eb74d81473f352b0cc6ace96ad6c2a24d4f9c0fdbdd751f0b292_flash_display_Sprite() {
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
