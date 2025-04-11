package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _4e89f02ef5e050763ced7fc63e66fe0ec0b097798d471efdb2ad4141a1e57392_flash_display_Sprite extends Sprite {
    public function _4e89f02ef5e050763ced7fc63e66fe0ec0b097798d471efdb2ad4141a1e57392_flash_display_Sprite() {
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
