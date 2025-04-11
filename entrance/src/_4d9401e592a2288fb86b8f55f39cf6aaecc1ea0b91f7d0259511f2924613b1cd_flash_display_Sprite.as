package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _4d9401e592a2288fb86b8f55f39cf6aaecc1ea0b91f7d0259511f2924613b1cd_flash_display_Sprite extends Sprite {
    public function _4d9401e592a2288fb86b8f55f39cf6aaecc1ea0b91f7d0259511f2924613b1cd_flash_display_Sprite() {
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
