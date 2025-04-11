package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _4eddc6d1a60731b254971ee057a2b99332142f434bd3690387a10211aade4e97_flash_display_Sprite extends Sprite {
    public function _4eddc6d1a60731b254971ee057a2b99332142f434bd3690387a10211aade4e97_flash_display_Sprite() {
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
