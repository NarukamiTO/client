package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _550d270e9aa6e5a15204aabf084b662ed3d0942e2a28bab885b127239aafb537_flash_display_Sprite extends Sprite {
    public function _550d270e9aa6e5a15204aabf084b662ed3d0942e2a28bab885b127239aafb537_flash_display_Sprite() {
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
