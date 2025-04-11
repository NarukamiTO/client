package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _f9fe0ba47b8f509cc1d66a3d8eca940754b1802ff534a5bacc50647ec4973a30_flash_display_Sprite extends Sprite {
    public function _f9fe0ba47b8f509cc1d66a3d8eca940754b1802ff534a5bacc50647ec4973a30_flash_display_Sprite() {
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
