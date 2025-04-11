package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _e501fd44903933ae5055c84e2be7a1471401548208ab4ed91116e89c22ac5e07_flash_display_Sprite extends Sprite {
    public function _e501fd44903933ae5055c84e2be7a1471401548208ab4ed91116e89c22ac5e07_flash_display_Sprite() {
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
