package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _c0770b9dde448958634fa1986f750b79051e3cfa4c50db1d7c7c1616031ad2c8_flash_display_Sprite extends Sprite {
    public function _c0770b9dde448958634fa1986f750b79051e3cfa4c50db1d7c7c1616031ad2c8_flash_display_Sprite() {
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
