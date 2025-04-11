package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _efaddafba47c048c1f059f394fde0803c49ef9dc94d32dbbb0eef67628de5aa5_flash_display_Sprite extends Sprite {
    public function _efaddafba47c048c1f059f394fde0803c49ef9dc94d32dbbb0eef67628de5aa5_flash_display_Sprite() {
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
